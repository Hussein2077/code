import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/aristocracy_level.dart';
import 'package:tik_chat_v2/core/widgets/level_continer.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/home/data/model/user_top_model.dart';

class FirstSecThrUsers extends StatelessWidget {
  final double imageSize ; 
    final double position ; 
   
  final double height ; 
  final String badge ; 
  final UserTopModel userData ; 

  const FirstSecThrUsers({required this.userData ,  required this.badge , required this.imageSize , required this.height , required this.position ,   super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
                        Methods().userProfileNvgator(context: context ,userId: userData.userId.toString()  );

     
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(

                    margin: EdgeInsets.only(
                        top: position,
                      ),
                    height: height,
                    child:UserImage(image:userData.avater!  ,child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Image.asset(
                            badge,
                            scale: 2.5,
                          )),  )
                    
                    
               
                  ),
          
          SizedBox(
            width: ConfigSize.defaultSize!*6,
            child: Text(
              userData.name!,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //todo add what shemi done

              AristocracyLevel(level: ),
              LevelContainer(image: ),
            ],
          ),
          Container(
            width: ConfigSize.
            defaultSize! * 5.6,
            height: ConfigSize.defaultSize! * 1.7,
            decoration: BoxDecoration(
                color: ColorManager.bage,
                borderRadius: BorderRadius.circular(ConfigSize.defaultSize!)),
                child: Center(child: Text(userData.exp.toString() , style:TextStyle(color: ColorManager.borwn , fontSize: ConfigSize.defaultSize!*1.2 , fontWeight: FontWeight.bold) ,)),
          )
        ],
      ),
    );
  }
}
