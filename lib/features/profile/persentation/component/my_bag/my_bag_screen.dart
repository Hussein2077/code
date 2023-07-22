

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';

import 'widgets/my_bag_tab_view.dart';
import 'widgets/my_bag_tabs.dart';

class MyBagScreen extends StatefulWidget {
  const MyBagScreen({super.key});

  @override
  State<MyBagScreen> createState() => _MyBagScreenState();
}

class _MyBagScreenState extends State<MyBagScreen>with TickerProviderStateMixin {
  late TabController bagController ; 
  @override
  void initState() {
   bagController = TabController(length: 3, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body:Column(children: [
        SizedBox(height: ConfigSize.defaultSize!*3,),
    const  HeaderWithOnlyTitle(title: StringManager.myBag) ,
            SizedBox(height: ConfigSize.defaultSize!,),

    MyBagScreenTabs(controller: bagController,),
     Expanded(child: TabBarView(
      controller: bagController,
      children:const [
MyBagTabView(),
MyBagTabView(),
MyBagTabView(),

    ],))
   
    
      
    ],) ,);
  }
}