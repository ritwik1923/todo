import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:todo/AddTask.dart';
// import 'package:sqlit_test/models/Todo_info.dart';

final String tableTodo = 'todo';
final String columnTitle = 'alltask';
final String columnDateTime = 'dateTime';

class DB_Helper {
  static Database _database;
  static DB_Helper _DB_Helper;

  DB_Helper._createInstance();
  factory DB_Helper() {
    if (_DB_Helper == null) {
      _DB_Helper = DB_Helper._createInstance();
    }
    return _DB_Helper;
  }

  Future<Database> get database async {
    if (_database == null) {
      // create new database
      _database = await initializeDatabase();
    }
    // else return existing database
    return _database;
  }

  Future<Database> initializeDatabase() async {
    try {
      // creating path to save database
      var dir = await getDatabasesPath();
      var path = dir + "$tableTodo.db";
      print("path: $path");

      // $columnId integer primary key autoincrement,
      var database = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) {
          db.execute('''
          create table $tableTodo ( 
          $columnDateTime text primary key,
          $columnTitle text not null)
        ''');
        },
      );
      return database;
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> insertTodo(StoreTask dbHelper) async {
    var db = await this.database;
    try {
      var result = await db.insert(tableTodo, dbHelper.toMap());
      print('Inserting record of ${dbHelper.dateTime} : $result');
    } on Exception catch (e) {
      print("data might be present so updateing it...");
      updateTodo(dbHelper);
    }
    // inserting new data in database
  }

  Future<void> updateTodo(StoreTask dbHelper) async {
    var db = await this.database;
    try {
      var result = await db.update(tableTodo, dbHelper.toMap(),
          where: '$columnDateTime = ?', whereArgs: [dbHelper.dateTime]);
      print('Updating record of ${dbHelper.dateTime} : $result');
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> deleteALLTodo() async {
    var db = await this.database;

    try {
      var result = await db.delete(tableTodo);
      print('Deleted All Database : $result');
      // throw 42;
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> deleteTodo(StoreTask dbHelper) async {
    var db = await this.database;
    try {
      var result = await db.delete(tableTodo,
          where: '$columnDateTime = ?', whereArgs: [dbHelper.dateTime]);
      print('Deleted record of ${dbHelper.dateTime} : $result');
      // throw 42;
    } on Exception catch (e) {
      print(e);
    }
  }

  // getting data from database by date
  Future<StoreTask> getTodo(String date) async {
    try {
      // StoreTask _Todos = [];
      // != null
      var db = await this.database;
      var result = await db
          .query(tableTodo, where: '$columnDateTime = ?', whereArgs: [date]);

      // print("${res.TodoDateTime}: ${res.title}");
      print("is there?: ${result.isNotEmpty}");
      return result.isNotEmpty ? StoreTask.fromMap(result.first) : null;
    } on Exception catch (e) {
      // print(e);
      throw null;
    }
  }

  // getting all data from database
  Future<List<StoreTask>> getTodos() async {
    List<StoreTask> _Todos = [];

    var db = await this.database;
    var result = await db.query(tableTodo);
    result.forEach((element) {
      var TodoInfo = StoreTask.fromMap(element);
      _Todos.add(TodoInfo);
    });

    return _Todos.isNotEmpty ? _Todos : null;
  }
}
