
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/features/profile/component/my_bag/widgets/my_bag_tabs.dart';

import 'widget/mall_tab_view.dart';

class MallScreen extends StatefulWidget {
  const MallScreen({super.key});

  @override
  State<MallScreen> createState() => _MallScreenState();
}

class _MallScreenState extends State<MallScreen> with TickerProviderStateMixin{

   late TabController mallController ; 
  @override
  void initState() {
   mallController = TabController(length: 3, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,     
      body:Column(children: [
        SizedBox(height: ConfigSize.defaultSize!*3,),
    const  HeaderWithOnlyTitle(title: StringManager.mall) ,
            SizedBox(height: ConfigSize.defaultSize!,),

    MyBagScreenTabs(controller: mallController,),
     Expanded(child: TabBarView(
      controller: mallController,
      children:const [
MallTabView(),
MallTabView(),
MallTabView(),

    ],))
   
    
      
    ],) ,);
  }
}