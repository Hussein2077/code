

import 'package:flutter/material.dart';

class CustoumErrorWidget extends StatelessWidget {

  final String message ; 
  const CustoumErrorWidget({required this.message ,  super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child:  Center(child: Text(message,style:  Theme.of(context).textTheme.headlineLarge,),)
    );
  }
}