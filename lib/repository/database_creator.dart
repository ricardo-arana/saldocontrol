import 'dart:io';
import 'package:path/path.dart';
import 'package:saldocontrol/common/Constanst.dart';
import 'package:saldocontrol/repository/tables/DebitoTable.dart';
import 'package:saldocontrol/repository/tables/TarjetaTable.dart';
import 'package:sqflite/sqflite.dart';

Database db;


class DatabaseCreator{
  

  static void databaseLog(String functionName, String sql,
      [List<Map<String, dynamic>> selectQueryResult, int insertAndUpdateQueryResult, List<dynamic> params]) {
    print(functionName);
    print(sql);
    if (params != null) {
      print(params);
    }
    if (selectQueryResult != null) {
      print(selectQueryResult);
    } else if (insertAndUpdateQueryResult != null) {
      print(insertAndUpdateQueryResult);
    }
  }

  Future<void> createTodoTable(Database db) async {
    
    final todoSql = '''CREATE TABLE ${TarjetaTable.tableName}
    (
      ${TarjetaTable.id} INTEGER PRIMARY KEY,
      ${TarjetaTable.name} TEXT,
      ${TarjetaTable.img} TEXT,
      ${TarjetaTable.code} TEXT,
      ${TarjetaTable.balance} REAL
    )''';

    await db.execute(todoSql);

  }

  Future<void> createDebitoTable(Database db) async {
    
    final debitoSql = '''CREATE TABLE ${DebitoTable.tableName}
    (
      ${DebitoTable.id} INTEGER PRIMARY KEY,
      ${DebitoTable.name} TEXT,
      ${DebitoTable.hora} TEXT,
      ${DebitoTable.idCard} INTEGER,
      ${DebitoTable.dias} TEXT
    )''';

    await db.execute(debitoSql);

  }

  Future<String> getDatabasePath(String dbName) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);

    //make sure the folder exists
    if (await Directory(dirname(path)).exists()) {
      //await deleteDatabase(path);
    } else {
      await Directory(dirname(path)).create(recursive: true);
    }
    return path;
  }

  Future<void> initDatabase() async {
    final path = await getDatabasePath(Constanst.dbname);
    db = await openDatabase(path, version: 1, onCreate: onCreate);
    print(db);
  }

  Future<void> onCreate(Database db, int version) async {
    await createTodoTable(db);
    await createDebitoTable(db);
  }


}


