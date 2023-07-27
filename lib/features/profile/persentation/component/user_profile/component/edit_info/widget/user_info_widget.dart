

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ConfigSize.defaultSize!*30,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          
          rowWidget(context: context, title: StringManager.bio , subTitle: "اسمي الحمودي"),
                  rowWidget(context: context, title: StringManager.interests ,subTitle: "بحب رنا رشدي"),
    
          rowWidget(context: context, title: StringManager.userName , subTitle: "حمودي ابن المحافظ"),
    
          rowWidget(context: context, title: StringManager.country ,image: AssetsPath.globalIcon),
    
    
      ],),
    );
  }
}


Widget rowWidget ({required BuildContext context , required String title , String?subTitle , String? image , }){
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
    child: Row(children: [
      // const Spacer(flex: 1),
      Text(title , style: TextStyle(color: Colors.grey , fontSize: ConfigSize.defaultSize!*1.7),),
          const Spacer(flex: 15),
  
      if(subTitle!=null)
          Text(subTitle , style: TextStyle(color: Colors.grey , fontSize: ConfigSize.defaultSize!*1.5),),
          
          if(image!=null)
          Image.asset(image , scale: 2,),
                          const Spacer(flex: 1),
  
          Icon(Icons.arrow_forward_ios , color: Theme.of(context).colorScheme.primary,),
                  // const Spacer(flex: 1),
  
  
  
    ],),
  );
}