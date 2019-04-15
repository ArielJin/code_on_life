import 'dart:io';

import 'package:sqflite/sqflite.dart';

/**
 * 数据库管理
 */
class SqlManager {
  static const _VERSION = 1;

  static const _NAME = "code_on_life.db";

  static Database _database;

  static init() async {
    var databasesPath = await getDatabasesPath();

    String dbName = _NAME;

    String path = databasesPath + dbName;

    if (Platform.isIOS) {
      path = databasesPath + "/" + dbName;
    }

    _database = await openDatabase(path, version: _VERSION,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      //await db.execute("CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)");
    });

    print('数据库创建成功，version:$_VERSION, 库名：$_NAME');

    print('path: $path');
  }

  /**
   * 表是否存在
   */
  static isTableExits(String tableName) async {
    await getCurrentDatabase();
    var res = await _database.rawQuery(
        "select * from Sqlite_master where type = 'table' and name = '$tableName'");
    return res != null && res.length > 0;
  }

  /**
   * 获取当前数据库对象
   */

  static Future<Database> getCurrentDatabase() async {
    if (_database == null) {
      await init();
    }

    return _database;
  }

  /**
   * 关闭
   */

  static close() {
    print("数据库 :database   close  ");
    _database.close();
    _database = null;
  }
}
