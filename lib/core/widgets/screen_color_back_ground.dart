import 'package:flutter/material.dart';

class ScreenColorBackGround extends StatelessWidget {
 final List<Color>? color ; 
  final Widget child ; 
  final Color? color1 ;
  final bool? withoutHighit ;
   const  ScreenColorBackGround({this.color1 ,  required this.child ,  this.color ,  super.key , this.withoutHighit});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height:withoutHighit==true? null : MediaQuery.of(context).size.height,
      decoration:color!=null? BoxDecoration(gradient:  LinearGradient(colors: color!)):color1!=null? BoxDecoration(color:color1):const BoxDecoration(color:Colors.blue),
      child: child ,

    );
  }
}