import 'dart:async';
import 'package:cashier/model/modelDB.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

enum Alerts { done , error }

class DB {
  static Database? _database;

  static Future<void> initiateDatabase() async {
    if (_database != null) {
      return;
    }
    //  not null unique,
    try {
      _database = await openDatabase(
        join(await getDatabasesPath(), dbName),
        version: 1,
        onCreate: (db, version) {
          return db.execute(
              '''CREATE TABLE $tableName ($columnId INTEGER PRIMARY KEY NOT NULL,
            $columnLable STRING NOT NULL UNIQUE,
            $columnTitle STRING,
            $columnPrice INTEGER)''');
        },
      );
    } catch (error) {
      print(error);
    }
  }

  static Database? dbs() => _database;
  static Future<int> insert(String table, ModelDB item) async =>
      await _database!.insert(
        table,
        item.toMap(),

        // conflictAlgorithm: ConflictAlgorithm.replace,
      );
  static Future<int> update(String table, ModelDB item) async =>
      await _database!
          .update(table, item.toMap(), where: 'id = ?', whereArgs: [item.id]);

  static Future<int> delete(String table, int ids) async =>
      await _database!.delete(table, where: 'id = ?', whereArgs: [ids]);

  static Future<List<Map<String, dynamic>>> rawQuery(String table) async =>
      _database!.rawQuery(table);

  static Future<List<Map<String, dynamic>>> query({
    required String table,
    required List<String> columns,
    required String where,
    required List<Object> whereArgs,
  }) async =>
      _database!.query(
        table,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
      );

  static Future getEventTableData() async {
    List<Map<String, dynamic>> eventRecords = await _database!.query(tableName);
    return eventRecords;
  }

  Future close() async => _database!.close();
}
