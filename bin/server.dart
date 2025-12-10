import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import '../lib/db.dart';

void main() async {
  final db = DatabaseService();
  final router = Router();

  // CORS headers
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
    'Access-Control-Allow-Headers': 'Content-Type',
  };

  // GET welcome message for the base path /
  router.get('/', (Request request) {
    return Response.ok(
        jsonEncode({
          'message': 'Welcome to the Task API!',
          'endpoints': {
            'GET /tasks': 'Get all tasks',
            'POST /tasks': 'Create a new task',
            'PUT /tasks/{id}': 'Update a task',
            'DELETE /tasks/{id}': 'Delete a task',
          },
          'example': '/tasks'
        }),
        headers: headers);
  });

  // GET all tasks
  router.get('/tasks', (Request request) {
    final tasks = db.getAllTasks().map((t) => t.toJson()).toList();
    return Response.ok(jsonEncode(tasks), headers: headers);
  });

  // CREATE task
  router.post('/tasks', (Request request) async {
    final body = jsonDecode(await request.readAsString());
    final task = db.createTask(body['title']);
    return Response(201,
        body: jsonEncode(task.toJson()), headers: headers);
  });

  // UPDATE task
  router.put('/tasks/<id|[0-9]+>', (Request request, String id) async {
    final body = jsonDecode(await request.readAsString());
    final task = db.updateTask(
      int.parse(id),
      body['title'],
      body['completed'],
    );

    if (task == null) {
      return Response.notFound(
          jsonEncode({'error': 'Task not found'}), headers: headers);
    }

    return Response.ok(jsonEncode(task.toJson()), headers: headers);
  });

  // DELETE task
  router.delete('/tasks/<id|[0-9]+>', (Request request, String id) {
    final success = db.deleteTask(int.parse(id));
    return success
        ? Response.ok(jsonEncode({'success': true}), headers: headers)
        : Response.notFound(
            jsonEncode({'error': 'Task not found'}), headers: headers);
  });

  // OPTIONS (CORS)
  router.options('/<any|.*>', (Request request) {
    return Response.ok('', headers: headers);
  });

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addHandler(router);

  final port = int.parse(Platform.environment['PORT'] ?? '5000');
  await serve(handler, InternetAddress.anyIPv4, port);

  // Check if running on Replit
  final replSlug = Platform.environment['REPL_SLUG'];
  final replOwner = Platform.environment['REPL_OWNER'];
  final isReplit = replSlug != null && replOwner != null;

  // Get local IP address (only for local development)
  String? localIp;
  if (!isReplit) {
    try {
      for (var interface in await NetworkInterface.list()) {
        for (var addr in interface.addresses) {
          if (addr.type == InternetAddressType.IPv4 && 
              !addr.isLoopback && 
              !addr.address.startsWith('169.254') &&
              !addr.address.startsWith('172.31')) { // Skip internal container IPs
            localIp = addr.address;
            break;
          }
        }
        if (localIp != null) break;
      }
    } catch (e) {
      // If we can't get IP, just use localhost
    }
  }

  // Print API endpoints
  final localhostUrl = 'http://localhost:$port';
  final networkUrl = localIp != null ? 'http://$localIp:$port' : null;
  final replitUrl = isReplit ? 'https://$replSlug.$replOwner.repl.co' : null;
  
  print('\n' + '=' * 50);
  print('✅ Server running on port $port');
  print('=' * 50);
  
  if (isReplit) {
    // Replit deployment
    print('\n🌍 Public API URL (Replit):');
    print('  $replitUrl');
    print('\n📡 API Endpoints:');
    print('  GET    $replitUrl/          (Welcome message)');
    print('  GET    $replitUrl/tasks');
    print('  POST   $replitUrl/tasks');
    print('  PUT    $replitUrl/tasks/{id}');
    print('  DELETE $replitUrl/tasks/{id}');
  } else {
    // Local development
    print('\n🌐 Base URLs:');
    print('  Local:    $localhostUrl');
    if (networkUrl != null) {
      print('  Network:  $networkUrl');
    }
    print('  Android:  http://10.0.2.2:$port (for Android Emulator)');
    print('\n📡 API Endpoints:');
    print('  GET    $localhostUrl/          (Welcome message)');
    print('  GET    $localhostUrl/tasks');
    print('  POST   $localhostUrl/tasks');
    print('  PUT    $localhostUrl/tasks/{id}');
    print('  DELETE $localhostUrl/tasks/{id}');
  }
  
  print('\n' + '=' * 50 + '\n');
}

