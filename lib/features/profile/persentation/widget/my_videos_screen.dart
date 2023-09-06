import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/profile/persentation/widget/reels_box.dart';

class MyVideosScreen extends StatelessWidget{
  final UserDataModel userDataModel;

  const MyVideosScreen({required this.userDataModel,super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Theme.of(context).colorScheme.background,
     appBar: AppBar(
       backgroundColor: Theme.of(context).colorScheme.background,
title: Text(StringManager.myVideos,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
  fontSize: ConfigSize.defaultSize!*1.8
),),
     ),

     body: ReelsBox(userDataModel: userDataModel,),
   );
  }


}