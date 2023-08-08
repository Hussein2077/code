
import 'package:flutter/material.dart';

import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class EmptyWidget extends StatelessWidget {
  final String message ; 
  const EmptyWidget({required this.message ,  super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: [
          
        SizedBox(
        
        child:Image.asset(AssetsPath.emptyScreen) ,
      ),

        Padding(
          padding: EdgeInsets.only(top: ConfigSize.defaultSize!*20),
          child: Text(
                         message,
                          style: TextStyle(color: Colors.black , fontSize: ConfigSize.defaultSize!*2),
                        ),
        ),
      ],)
    );
  }
}