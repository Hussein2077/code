

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/header/live_tab_bar.dart';

class HomeHeader extends StatelessWidget {
  final TabController liveController ; 
  const HomeHeader({required this.liveController ,  super.key});

  @override
  Widget build(BuildContext context) {
    return    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
     InkWell(onTap: (){
      Navigator.pushNamed(context, Routes.topUsersScreen);
     }, child: Image.asset(AssetsPath.topUserIcon , scale: 2,)),
     LiveTabBAR(liveController: liveController,),
     Image.asset(AssetsPath.searchIcon , scale: 2.5,),
          InkWell(onTap: (){
            Navigator.pushNamed(context, Routes.createLive);
          }, child: Image.asset(AssetsPath.createLiveIcon , scale: 2.5,))


   


    ],);
  }
}