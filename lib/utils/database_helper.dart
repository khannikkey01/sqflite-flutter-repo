import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'todo.db');

    return await openDatabase(
      databasePath,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todo(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        isDone INTEGER
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> getTodos() async {
    final db = await database;
    return await db.query('todo');
  }

  Future<int> insertTodo(Map<String, dynamic> todo) async {
    final db = await database;
    return await db.insert('todo', todo);
  }

  Future<int> updateTodo(Map<String, dynamic> todo) async {
    final db = await database;
    return await db.update(
      'todo',
      todo,
      where: 'id = ?',
      whereArgs: [todo['id']],
    );
  }

  Future<int> deleteTodo(int id) async {
    final db = await database;
    return await db.delete(
      'todo',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}