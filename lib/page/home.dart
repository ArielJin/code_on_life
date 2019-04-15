import 'package:barcode_scan/barcode_scan.dart';
import 'package:barcode_scan/mode/sacn_result.dart';
import 'package:code_on_life/common/ab/provider/CodeInfoDbProvider.dart';
import 'package:code_on_life/common/mode/CodeInfo.dart';
import 'package:code_on_life/common/utils/NavigatorUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  static final String sName = "HomePage";

  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CodeInfo> _codeinfos = new List();

  _HomePageState();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initCodeinfos();
  }

  Future initCodeinfos() async {
    List list = await CodeInfoDbProvider().getCodeInfos();
    setState(() {
      _codeinfos = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('已添码'),
        actions: <Widget>[
          GestureDetector(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: Text("扫码"),
            ),
            onTap: scan,
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: _codeinfos != null ? _codeinfos.length : 0,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Card(
                  margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Column(
                      children: <Widget>[
                        Text('${_codeinfos[index].name}'),
                        Text('${_codeinfos[index].text}'),
                      ],
                    ),
                  )),
              onTap: () {
                NavigatorUtils.goShowCode(context, _codeinfos[index]);
              },
              onLongPress: (){
                edit(_codeinfos[index]);
              },
            );
          }),
    );
  }

  Future edit(CodeInfo codeInfo) async {
    final result = await NavigatorUtils.goEditCode(context, codeInfo);

    if (result != null && result is CodeInfo) {
      setState(() {
        _codeinfos.any((item) {
          if (CodeInfo.islike(item, result)) {
            item.text = result.text;
            item.name = result.name;
            item.phoneNo = result.phoneNo;
            return true;
          } else {
            return false;
          }
        });
      });
    }
  }

  Future scan() async {
    try {
      ScanResult scanResult = await BarcodeScanner.scan();
      final result = await NavigatorUtils.goAddCode(context, scanResult);
      if (result != null && result is CodeInfo) {
        setState(() {
          if (_codeinfos == null) {
            _codeinfos = new List();
            _codeinfos.add(result);
          } else if (_codeinfos.length > 0) {
            bool isUpdate = _codeinfos.any((item) {
              if (CodeInfo.islike(item, result)) {
                item.text = result.text;
                item.name = result.name;
                item.phoneNo = result.phoneNo;
                return true;
              } else {
                return false;
              }
            });
            if (!isUpdate) {
              _codeinfos.add(result);
            }
          }
        });
      }
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
//        The user did not grant the camera permission!

      } else {
//        Unknown error: $e

      }
    } on FormatException {
//      null (User returned using the "back"-button before scanning anything. Result)

    } catch (e) {
//      Unknown error: $e

    }
  }
}
