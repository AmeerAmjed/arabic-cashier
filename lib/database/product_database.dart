import 'package:cashier/database/database_manager.dart';
import 'package:cashier/model/Product.dart';
import 'package:cashier/utils/constants.dart';
import 'package:sqflite/sqflite.dart';

class ProductDatabase extends DatabaseManager<Product> {
  @override
  String tableName = PRODUCT_TABLE;

  @override
  Future<void> createTable(Batch batch) async {
    batch.execute('''
      CREATE TABLE $tableName (
                    $ID INTEGER PRIMARY KEY NOT NULL,
                    $LADLE STRING NOT NULL UNIQUE,
                    $TITLE STRING,
                    $PRICE INTEGER)
              ''');
  }
}
