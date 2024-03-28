import 'dart:async';

import 'package:cashier/model/base_model.dart';
import 'package:cashier/utils/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

enum Alerts { done , error }

abstract class DatabaseManager<T extends BaseModel> {
  static Database? _database;

  abstract String tableName;

  Database? get instance => _database;

  Future<void> createTable(Batch batch);

  Future<void> initiateDatabase() async {
    if (DatabaseManager._database != null) {
      return;
    }

    try {
      DatabaseManager._database = await openDatabase(
        join(await getDatabasesPath(), DB_NAME),
        version: 1,
        onCreate: (db, version) async {
          var batch = db.batch();
          await createTable(batch);
          await batch.commit();
        },
      );
    } catch (error) {
      print(error);
    }
  }

  Future<int> insert(T item) async =>
      await _database!.insert(tableName, item.toMap());

  Future<int> update(T item) async => await _database!
      .update(tableName, item.toMap(), where: 'id = ?', whereArgs: [item.id]);

  Future<int> delete(int ids) async =>
      await _database!.delete(tableName, where: 'id = ?', whereArgs: [ids]);

  Future<List<Map<String, dynamic>>> getEventTableData() async =>
      _database!.rawQuery(tableName);

  Future<List<Map<String, dynamic>>> query({
    required List<String> columns,
    required String where,
    required List<Object> whereArgs,
  }) async {
    return _database!.query(
      tableName,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }


}
