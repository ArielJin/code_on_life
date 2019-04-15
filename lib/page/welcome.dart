


import 'package:code_on_life/common/style/CodeOnLifeStyle.dart';
import 'package:code_on_life/common/utils/NavigatorUtils.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {

  static final String sName = "WelcomePage";

  @override
  _WelcomePageState createState() => _WelcomePageState();


}

class _WelcomePageState extends State<WelcomePage> with TickerProviderStateMixin{

  Animation animation;

  AnimationController controller;

  var animationStateListener;

  @override
  void initState() {
    super.initState();

    controller = new AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    animation = new Tween(begin: 0.5, end: 1.0).animate(controller);
    animationStateListener = (status) async {
      if (status == AnimationStatus.completed) {
//        Navigator.of(context).pushAndRemoveUntil(
//            new MaterialPageRoute(builder: (context) => new Home()),
//            (route) => route == null);
        NavigatorUtils.goHome(context);

      }
    };

    animation.addStatusListener((status) => animationStateListener(status));

    controller.forward();


  }

  @override
  Widget build(BuildContext context) {
    return new FadeTransition(
      opacity: animation,
//      child: new Image.asset(
//        "./images/3.0x/bg_splash.png",
//        fit: BoxFit.cover,
//      ),
      child: new Stack(
        alignment: new Alignment(0, -0.8),
        children: <Widget>[
          new Image.asset(
            CodeOnLifeICons.BG_PACKAGE_WELCOME,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
//          new Image.asset(
//            "./images/3.0x/bg_splash_cardqu.png",
//            width: 208,
//            height: 289.67,
//          )
        ],
      ),
    );
  }


  @override
  void dispose() {
    controller.removeStatusListener(animationStateListener);
    controller.dispose();
    super.dispose();
  }


}
