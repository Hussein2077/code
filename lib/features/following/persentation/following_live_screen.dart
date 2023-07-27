

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/custom_horizental_dvider.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/body/video/video_live_box.dart';

class FollowingLiveScreen extends StatelessWidget {
  const FollowingLiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          SizedBox(height: ConfigSize.defaultSize!*5,),
         Text(StringManager.followingLive , style: Theme.of(context).textTheme.headlineLarge,),
         CustomHorizntalDvider(width: ConfigSize.defaultSize!*5 , color: ColorManager.orang,),
       
         Expanded(
           child: GridView.builder(
                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
         
            itemCount: 10,
            itemBuilder: (context, index) {
              int style = 0 ; 
              if(index==0 || index==1 ||index==2){
                style = index ; 
              }else {
                style = index % 3 ;
              }
                 return   VideoLiveBox(style: style,);
            }),
         )

      ],),

    );
  }
}