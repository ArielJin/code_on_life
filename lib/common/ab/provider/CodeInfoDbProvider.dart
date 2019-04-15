



import 'dart:convert';

import 'package:code_on_life/common/ab/BaseDbProvider.dart';
import 'package:code_on_life/common/mode/CodeInfo.dart';
import 'package:sqflite/sqflite.dart';

class CodeInfoDbProvider extends BaseDbProvider {


  final String name = "CodeInfo";

  final String columnId = "_id";
  final String columnData = "data";

//  int id;
  String data;

  CodeInfoDbProvider();



  @override
  tableName() {
    // TODO: implement tableName
    return name;
  }

  @override
  tableSqlString() {
    // TODO: implement tableSqlString
    return tableBaseString(name, columnId) +
        '$columnData text not null)';
  }


  Map<String, dynamic> toMap(/*String userName, */String data) {
    Map<String, dynamic> map = {/*columnUserName: userName, */columnData: data};
//    if (id != null) {
//      map[columnId] = id;
//    }

    return map;
  }

  CodeInfoDbProvider.fromMap(Map map) {
//    id = map[columnId];
//    userName = map[columnUserName];
    data = map[columnData];
  }

  Future _getCodeInfoProvider(Database db) async {
    List<Map<String, dynamic>> maps = await db.query(name,
        columns: [columnId, /*columnUserName, */columnData]);
    if (maps != null && maps.length > 0) {
//      print("================= maps first ============");
//      print(maps);
//      CodeInfoDbProvider provider = CodeInfoDbProvider.fromMap(maps.first);
//      return provider;
    return maps;
    }

    return null;
  }


  ///插入到数据库
  Future insert(/*String userName, */CodeInfo codeInfo) async {
    Database db = await getDataBase();
//    var authUserProvider = await _getCodeIn afoProvider(db/*, userName*/);
//    if (authUserProvider != null) {
//      await db
//          .delete(name, where: "$columnId = ?", whereArgs: [0]);
//    }
//
//    id = 0; //id主键自增  因为仅保存当前用户  所以用户表数据记录永远只要一条
    return await db.insert(name, toMap(/*userName, */json.encode(codeInfo.toJson())));
  }

  ///修改数据
  Future update(CodeInfo newCi, CodeInfo oldCi) async {
    Database db = await getDataBase();
    return await db.rawUpdate("UPDATE $name SET $columnData = ? WHERE $columnData = ?",[json.encode(newCi.toJson()),json.encode(oldCi.toJson())]);

  }


  ///获取事件数据
  Future<List<CodeInfo>> getCodeInfos() async {
    Database db = await getDataBase();

    List<Map<String, dynamic>> maps = await _getCodeInfoProvider(db);

    if (maps != null && maps.length > 0) {

      List<CodeInfo> list = new List();


        for (var item in maps) {
          CodeInfo codeInfo = CodeInfo.fromJson(json.decode(item[columnData]));
          print('CodeInfo ======= >> ${codeInfo.text}\n');
          list.add(codeInfo);


        }

        print('----------- ${list.length}');

        return list;



    }

//    if (provider != null) {
//      print("provider.data :");
//      print(provider.data);
//
//      List<CodeInfo> list = new List();
//
//      List<dynamic> codeInfosMap = await compute(CodeUtils.decodeListResult, json.decode(provider.data) as String);
//
////      var mapData =
////      await compute(CodeUtils.decodeMapResult, json.decode(provider.data) as String);
//
//      if(codeInfosMap.length > 0) {
//
//        for (var item in codeInfosMap) {
//          list.add(CodeInfo.fromJson(item));
//
//
//        }
//
//
//      }
//
//      return list;
//
////      return CodeInfo.fromJson(json.decode(json.encode(mapData)));
//    }
    return null;
  }


}