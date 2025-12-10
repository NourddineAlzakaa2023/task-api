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

  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  await serve(handler, InternetAddress.anyIPv4, port);

  print('✅ Server running on port $port');
}

