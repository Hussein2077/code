import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForceRotateWidget extends StatefulWidget{
 final Widget? widget;
 const ForceRotateWidget( {super.key,required this.widget,});
  @override
  State<ForceRotateWidget> createState() => _ForceRotateWidgetState();
}

class _ForceRotateWidgetState extends State<ForceRotateWidget> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }
  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
  @override
  Widget build(BuildContext context) {
return Scaffold(
  body: widget.widget,
);
  }
}