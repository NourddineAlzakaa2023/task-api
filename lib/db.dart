import 'package:sqlite3/sqlite3.dart';
import 'task.dart';

class DatabaseService {
  final Database db;

  DatabaseService() : db = sqlite3.open('tasks.db') {
    db.execute('''
      CREATE TABLE IF NOT EXISTS tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        completed INTEGER NOT NULL
      );
    ''');
  }

  List<Task> getAllTasks() {
    final result = db.select('SELECT * FROM tasks');
    return result
        .map((row) => Task(
              id: row['id'] as int,
              title: row['title'] as String,
              completed: row['completed'] == 1,
            ))
        .toList();
  }

  Task createTask(String title) {
    final stmt =
        db.prepare('INSERT INTO tasks (title, completed) VALUES (?, ?)');
    stmt.execute([title, 0]);
    stmt.dispose();

    final id = db.lastInsertRowId;
    return Task(id: id, title: title, completed: false);
  }

  Task? updateTask(int id, String title, bool completed) {
    db.execute(
      'UPDATE tasks SET title = ?, completed = ? WHERE id = ?',
      [title, completed ? 1 : 0, id],
    );

    if (db.getUpdatedRows() == 0) return null;

    return Task(id: id, title: title, completed: completed);
  }

  bool deleteTask(int id) {
    db.execute('DELETE FROM tasks WHERE id = ?', [id]);
    return db.getUpdatedRows() > 0;
  }
}

