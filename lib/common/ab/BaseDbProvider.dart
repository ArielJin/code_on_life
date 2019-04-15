

import 'package:code_on_life/common/ab/SqlManager.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseDbProvider {

  bool isTableExits = false;

  tableSqlString();

  tableName();

  tableBaseString(String name, String columnId) {
    return 'create table $name ($columnId integer primary key autoincrement,';

  }

  Future<Database> getDataBase() async {
    return await open();
  }


  @mustCallSuper
  prepare(name, String createSql) async {

    isTableExits = await SqlManager.isTableExits(name);

    if (!isTableExits) {

      Database db = await SqlManager.getCurrentDatabase();
      print("=================  数据库表创建  =====================");
      print(createSql);
      return await db.execute(createSql);

    }

  }

  @mustCallSuper
  open() async {

    if (!isTableExits) {

      await prepare(tableName(), tableSqlString());

    }

    return await SqlManager.getCurrentDatabase();

  }





}