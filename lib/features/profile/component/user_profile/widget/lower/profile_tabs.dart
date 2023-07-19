

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';

class ProfileTabs extends StatelessWidget {
  final TabController profileController ;
  const ProfileTabs({required this.profileController ,  super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: ConfigSize.defaultSize!*30,
      child: TabBar(
        controller:  profileController,
        indicatorColor: ColorManager.orang,
        indicatorPadding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!*6),
        labelColor: Theme.of(context).colorScheme.primary,
        unselectedLabelColor: Colors.grey,
        labelStyle:TextStyle(fontSize: ConfigSize.defaultSize!*1.8 , fontWeight: FontWeight.bold) ,
        unselectedLabelStyle:TextStyle(fontSize: ConfigSize.defaultSize!*1.6) ,
    
        tabs:const [
        Text(StringManager.profile , ),
              Text(StringManager.reels,)
    
    
      ]),
    );
  }
}