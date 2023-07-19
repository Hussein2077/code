import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';

class FirstSecThrUsers extends StatelessWidget {
  final double imageSize ; 
    final double position ; 
   
  final double height ; 
  final String badge ; 

  const FirstSecThrUsers({required this.badge , required this.imageSize , required this.height , required this.position ,   super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        Container(
                  margin: EdgeInsets.only(
                      top: position,
                    ),
                  height: height,
                  child: Container(
                    width: imageSize,
                    height: imageSize,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(AssetsPath.testImage),
                            fit: BoxFit.fill)),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Image.asset(
                          badge,
                          scale: 2.5,
                        )),
                  ),
                ),
        
        Text(
          "حمود",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Container(
          width: ConfigSize.
          defaultSize! * 5.6,
          height: ConfigSize.defaultSize! * 1.7,
          decoration: BoxDecoration(
              color: ColorManager.bage,
              borderRadius: BorderRadius.circular(ConfigSize.defaultSize!)),
              child: Center(child: Text("1.4 M" , style:TextStyle(color: ColorManager.borwn , fontSize: ConfigSize.defaultSize!*1.2 , fontWeight: FontWeight.bold) ,)),
        )
      ],
    );
  }
}
