



import 'package:barcode_scan/mode/sacn_result.dart';
import 'package:code_on_life/common/mode/CodeInfo.dart';
import 'package:code_on_life/page/addcode.dart';
import 'package:code_on_life/page/home.dart';
import 'package:code_on_life/page/showcode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorUtils {



  ///替换
  static pushReplacementNamed(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  ///切换无参数页面
  static pushNamed(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  ///主页
  static goHome(BuildContext context){


    Navigator.pushReplacementNamed(context, HomePage.sName);
  }


  ///添加会员码
  static Future goAddCode(BuildContext context, ScanResult scanResult){

    return NavigatorRouter(
      context,
      AddCode(CodeInfo(scanResult.text, scanResult.format.toString().replaceAll(RegExp(r'BarcodeFormat.'), '')))
    );

  }

  ///编辑会员码
  static Future goEditCode(BuildContext context, CodeInfo codeInfo){

    return NavigatorRouter(
        context,
        AddCode(codeInfo)
    );

  }

  ///横屏显示二维码
  static Future goShowCode(BuildContext context, CodeInfo codeInfo){

    return NavigatorRouter(
        context,
        ShowCode(codeInfo)
    );

  }


  static NavigatorRouter(BuildContext context, Widget widget) {
    return Navigator.push(context, new CupertinoPageRoute(builder: (context) => widget));
  }






}