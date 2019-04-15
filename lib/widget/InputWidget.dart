




import 'package:flutter/material.dart';

class InputWidget extends StatefulWidget {

  final bool obscureText;

  final String hintText;

  final String leftText;

  final ValueChanged<String> onChanged;

  final TextStyle textStyle;

  final TextEditingController controller;


  @override
  _InputWidget createState() => _InputWidget();

  InputWidget({Key key, this.obscureText = false, this.hintText, this.leftText, this.onChanged, this.textStyle,
    this.controller}) : super(key : key);


}


class _InputWidget extends State<InputWidget> {

  _InputWidget() : super();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(padding: EdgeInsets.only(left: 20)),
        Text(widget.leftText),
        Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: widget.hintText,
              ),
              obscureText: widget.obscureText,
              controller: widget.controller,
              onChanged: widget.onChanged,
            )),
        Padding(padding: EdgeInsets.only(right: 20))
      ],
    );
  }



}