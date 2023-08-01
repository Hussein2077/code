

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ScreenBackGround extends StatelessWidget {
 final String image ; 
  final Widget child ; 
   const  ScreenBackGround({required this.child , required this.image ,  super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(image: DecorationImage(image: AssetImage(image) , fit: BoxFit.fill)),
      child: child ,

    );
  }
}