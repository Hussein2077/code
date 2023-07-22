

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/screen_back_ground.dart';

import 'widgets/vip_bottom_bar.dart';
import 'widgets/vip_tab_view.dart';
import 'widgets/vip_tabs.dart';

class VipScreen extends StatefulWidget {
  const VipScreen({super.key});

  @override
  State<VipScreen> createState() => _VipScreenState();
}

class _VipScreenState extends State<VipScreen>with TickerProviderStateMixin {
  late TabController vipContriller ; 
  @override
  void initState() {
   vipContriller = TabController(length: 8, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
    ScreenBackGround(image: AssetsPath.vipBackGround, child: Column(children: [
      SizedBox(height: ConfigSize.defaultSize!*3.5,),
const HeaderWithOnlyTitle(title: StringManager.vip , titleColor: Colors.white, ),
      SizedBox(height: ConfigSize.defaultSize!*2,),

VipTabs(vipContriller: vipContriller,),
      SizedBox(height: ConfigSize.defaultSize!*5,),

Expanded(
  child:    TabBarView(
  
    controller: vipContriller,
  
    children:const [
  
      VipTabView(vipIcon: AssetsPath.kinghtIcon),
  
      VipTabView(vipIcon: AssetsPath.baronIcon),
  
  
  
      VipTabView(vipIcon: AssetsPath.viscount),
  
  
  
      VipTabView(vipIcon: AssetsPath.count),
  
  
  
      VipTabView(vipIcon: AssetsPath.marquis),
  
  
  
      VipTabView(vipIcon: AssetsPath.duke),
  
  
  
      VipTabView(vipIcon: AssetsPath.king),
  
  
  
      VipTabView(vipIcon: AssetsPath.superKing),
  
  
  
    ]),
),



const VipBottomBar()



    ],))
     ,);
  }
}