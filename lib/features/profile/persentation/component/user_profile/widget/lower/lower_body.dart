

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';

import 'profile_tab_view_body.dart';
import 'profile_tabs.dart';
import 'reels_tab_view_body.dart';

class LowerProfileBody extends StatefulWidget {
  const LowerProfileBody({super.key});

  @override
  State<LowerProfileBody> createState() => _LowerProfileBodyState();
}

class _LowerProfileBodyState extends State<LowerProfileBody> with TickerProviderStateMixin {
  late TabController profileController ; 
  @override
  void initState() {
    profileController = TabController(length: 2, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: ConfigSize.defaultSize!*2,),
      ProfileTabs(profileController: profileController,),
            SizedBox(height: ConfigSize.defaultSize!*2,),

      SizedBox(
        height: MediaQuery.of(context).size.height/2.4,
        child: TabBarView(
          controller: profileController,
           children:const [
            ProfileTabViewBody(),
          ReelsTabView()
      
        ]),
      ),
    ],);
  }
}