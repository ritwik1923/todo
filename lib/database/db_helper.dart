import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:todo/AddTask.dart';
// import 'package:sqlit_test/models/alarm_info.dart';

final String tableAlarm = 'todo';
final String columnTitle = 'title';
final String columnDateTime = 'DateTime';

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
    // creating path to save database
    var dir = await getDatabasesPath();
    var path = dir + "$tableAlarm.db";

    // $columnId integer primary key autoincrement,
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          create table $tableAlarm ( 
          $columnDateTime text primary key,
          $columnTitle text not null,)
        ''');
      },
    );
    return database;
  }

  Future<void> insertAlarm(StoreTask alarmInfo) async {
    var db = await this.database;
    try {
      var result = await db.insert(tableAlarm, alarmInfo.toMap());
      print('Inserting record of ${alarmInfo.dateTime} : $result');
    } on Exception catch (e) {
      print(e);
      updateAlarm(alarmInfo);
    }
    // inserting new data in database
  }

  Future<void> updateAlarm(StoreTask alarmInfo) async {
    var db = await this.database;
    try {
      var result = await db.update(tableAlarm, alarmInfo.toMap(),
          where: '$columnDateTime = ?', whereArgs: [alarmInfo.dateTime]);
      print('Updating record of ${alarmInfo.dateTime} : $result');
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> deleteALLAlarm() async {
    var db = await this.database;

    try {
      var result = await db.delete(tableAlarm);
      print('Deleted All Database : $result');
      // throw 42;
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> deleteAlarm(StoreTask alarmInfo) async {
    var db = await this.database;
    try {
      var result = await db.delete(tableAlarm,
          where: '$columnDateTime = ?', whereArgs: [alarmInfo.dateTime]);
      print('Deleted record of ${alarmInfo.dateTime} : $result');
      // throw 42;
    } on Exception catch (e) {
      print(e);
    }
  }

  // getting all data from database
  Future<List<StoreTask>> getAlarms() async {
    List<StoreTask> _alarms = [];

    var db = await this.database;
    var result = await db.query(tableAlarm);
    result.forEach((element) {
      var alarmInfo = StoreTask.fromMap(element);
      _alarms.add(alarmInfo);
    });

    return _alarms;
  }
}
