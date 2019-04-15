




import 'package:barcode_base/barcode_base.dart';
import 'package:code_on_life/common/mode/CodeInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orientation/orientation.dart';

class ShowCode extends StatefulWidget {

  final CodeInfo codeInfo;


  ShowCode(this.codeInfo);

  @override
  _ShowCode createState() => _ShowCode(codeInfo);

}


class _ShowCode extends State<ShowCode> {

  final CodeInfo codeInfo;


  _ShowCode(this.codeInfo);

//  DeviceOrientation _deviceOrientation;
//
//  StreamSubscription<DeviceOrientation> subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

//    subscription = OrientationPlugin.onOrientationChange.listen((value) {
//      // If the widget was removed from the tree while the asynchronous platform
//      // message was in flight, we want to discard the reply rather than calling
//      // setState to update our non-existent appearance.
//      if (!mounted) return;
//
//      setState(() {
//        _deviceOrientation = value;
//      });
//
//      OrientationPlugin.forceOrientation(value);
//    });
    SystemChrome.setEnabledSystemUIOverlays([]);
    OrientationPlugin.forceOrientation(DeviceOrientation.landscapeRight);
  }

  @override
  void dispose() {
    // TODO: implement dispose
//    subscription?.cancel();
//    OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        child: Scaffold(

      body: Center(
        child: BarCodeView.autoBuildBarCode(
            data: codeInfo.text,
            codeType: codeInfo.format,
            hasText: true,
            size: 260,
            barHeight: 150,
            onError: (ex) {
              print('[QR] ERROR - $ex');
            }),
      ),

    ),
        onWillPop: (){
          OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp).then((_){

            SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
            Navigator.pop(context);

          });

        });
  }


}