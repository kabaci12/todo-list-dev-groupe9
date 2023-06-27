import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todos_project/model/todo.dart';

class DatabaseServices {
  static final DatabaseServices instance = DatabaseServices._init();

  static Database? _database;

  DatabaseServices._init();

  // get database in local

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDB('todo.db');

    return _database!;
  }

  Future<Database> initDB(String filepath) async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, filepath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE IF NOT EXISTS Todo ("
          "uid integer primary key AUTOINCREMENT,"
          "title TEXT,"
          "description TEXT,"
          "completed TEXT" // 1 : true , 0 false
          ")",
        );
      },
    );
  }

  Future<int> createTodo(Todo todo) async {
    final db = await database;
    return await db.insert(
      "Todo",
      {
        "title": todo.title,
        "description": todo.description,
        "completed": todo.completed ? "1" : "0"
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateTodo(Todo todo) async {
    final db = await database;
    return await db.update(
      "Todo",
      {
        "title": todo.title,
        "description": todo.description,
        "completed": todo.completed ? "1" : "0"
      },
      where: "uid=?",
      whereArgs: [todo.uid],
    );
  }

  Future<int> removeTodo(Todo todo) async {
    final db = await database;
    return await db.delete("Todo", where: "uid=?", whereArgs: [todo.uid]);
  }

  Future<List<Todo>> getTodos() async {
    List<Todo> todos = [];
    final db = await database;
    final result = await db.query("Todo");

    for (var res in result) {
      todos.add(Todo.fromMap(res));
    }

    return todos;
  }
}
