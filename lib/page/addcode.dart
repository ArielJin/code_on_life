import 'package:barcode_base/barcode_base.dart';
import 'package:code_on_life/common/ab/provider/CodeInfoDbProvider.dart';
import 'package:code_on_life/common/mode/CodeInfo.dart';
import 'package:code_on_life/common/utils/RandomUtils.dart';
import 'package:code_on_life/widget/InputWidget.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class AddCode extends StatefulWidget {
  final CodeInfo codeInfo;

  AddCode(this.codeInfo);

  @override
  _AddCodeState createState() => _AddCodeState(codeInfo);
}

class _AddCodeState extends State<AddCode> {
  final CodeInfo codeInfo;

  CodeInfo _dbCodeInfo;
  bool _isUpdate = false;

  _AddCodeState(this.codeInfo);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkCode();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
            appBar: AppBar(
              titleSpacing: -10,
              title: Text('添码'),
            ),
            bottomNavigationBar: RaisedButton(
              padding: EdgeInsets.all(20),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              splashColor: Colors.blue,
              child:
                  Text(_dbCodeInfo != null ? _isUpdate ? "修改码" : "返回" : '添加码'),
              onPressed: _addCode,
            ),
            body: SafeArea(
                child: SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 20)),
                    BarCodeView.autoBuildBarCode(
                        data: codeInfo.text,
                        codeType: codeInfo.format,
                        hasText: true,
                        size: 150,
                        onError: (ex) {
                          print('[QR] ERROR - $ex');
                        }),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Text('编码：${codeInfo.text}\n类型：${codeInfo.format}'),
                    Padding(padding: EdgeInsets.only(top: 40)),
                    InputWidget(
                      leftText: '  名称  ：',
                      hintText: codeInfo.name,
                      onChanged: (String name) {
                        if (_dbCodeInfo != null) {
                          setState(() {
                            _isUpdate = name != "" && (_dbCodeInfo.name != name ||
                                _dbCodeInfo.phoneNo != codeInfo.phoneNo);
                          });
                        }
                        codeInfo.name = name.trim() == "" ? _dbCodeInfo.name : name;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    InputWidget(
                      leftText: '手机号：',
                      hintText: '请输入手机号',
                      onChanged: (String phoneNo) {
                        if (_dbCodeInfo != null) {
                          setState(() {
                            _isUpdate = phoneNo != "" && (_dbCodeInfo.name != codeInfo.name ||
                                _dbCodeInfo.phoneNo != phoneNo);
                          });
                        }

                        codeInfo.phoneNo = phoneNo;
                      },
                    ),
                  ],
                ),
              ),
            ))));
  }

  Future _checkCode() async {
    CodeInfoDbProvider provider = new CodeInfoDbProvider();
    List<CodeInfo> list = await provider.getCodeInfos();
    if (list != null && list.length > 0) {
      list.any((item) {
        if (CodeInfo.islike(item, codeInfo)) {
          _dbCodeInfo = item;
          return true;
        }
        return false;
      });
    }

    setState(() {
      codeInfo.name =
          _dbCodeInfo != null ? _dbCodeInfo.name : RandomUtils.getRandomName(2);
    });
  }

  _addCode() async {
    if (_dbCodeInfo != null) {
      if (_isUpdate) {
        await CodeInfoDbProvider().update(codeInfo, _dbCodeInfo);
        Toast.show("已修改！", context);
        Navigator.pop(context, codeInfo);
      } else {
        Navigator.pop(context);

      }
    } else {
      await CodeInfoDbProvider().insert(codeInfo);
      Toast.show("已添加！", context);
      Navigator.pop(context, codeInfo);
    }

  }
}
