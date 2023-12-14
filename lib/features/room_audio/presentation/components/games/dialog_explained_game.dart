import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
class ExplainGame extends StatelessWidget {
  final String explainGame;
  final String iconGame;
  final String? logoIcon;
  final List<Color>?linearGradient;
  final double? hight;
  final double? hightContaner;
  final String? dicound;
  final double? topPostion;
  const ExplainGame({super.key,required this.explainGame, required this.iconGame,
     this.linearGradient,
     this.hightContaner, this.hight, this.dicound, this.topPostion, this.logoIcon

  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:hight?? ConfigSize.screenHeight! * 0.7,
      width: ConfigSize.screenWidth,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [

          Container(
            padding: EdgeInsets.all(ConfigSize.defaultSize!*2),
            height:hightContaner?? ConfigSize.screenHeight! * 0.62,
            width: ConfigSize.screenWidth,
            decoration:   BoxDecoration(
              gradient: LinearGradient(colors:linearGradient?? ColorManager.bageGriedinet),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Text(
                explainGame,
                style: const TextStyle(fontSize: 16,color: Colors.black,overflow: TextOverflow.visible),
                textAlign: TextAlign.center,
              ),
            ),

          ),
          Positioned(
            top: 0,
            child: Image.asset(iconGame, scale: .7,),


          ),
          Positioned(
            top:topPostion?? ConfigSize.defaultSize!*7,
            right: ConfigSize.defaultSize,
            child:  IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.close, color: Colors.black, size: ConfigSize.defaultSize! * 3,),
            ),


          ),

          if(logoIcon!=null)
          Positioned(
            bottom: ConfigSize.defaultSize,
            child: Image.asset(logoIcon!, scale: .7,),
          ),
        ],
      ),
    );
  }
}
