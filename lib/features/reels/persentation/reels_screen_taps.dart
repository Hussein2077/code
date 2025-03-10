
import 'dart:developer';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/features/reels/persentation/reels_screen.dart';
import '../../../core/utils/config_size.dart';
import 'following_reels_screen.dart';

class ReelsScreenTaps extends StatefulWidget {
  const ReelsScreenTaps({super.key});
static bool isFirst=true;
  @override
  State<ReelsScreenTaps> createState() => ReelsScreenTapsState();
}

class ReelsScreenTapsState extends State<ReelsScreenTaps>
    with TickerProviderStateMixin {
  late TabController _tabController;




  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      initialIndex: 1,
      vsync: this, // Provide a TickerProvider
    );

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ShowCaseWidget(
          onComplete: (index,key){

            if (index == 2) {
              ReelsScreenTaps.  isFirst=false;
              ReelsScreenState.currentIndexNavBar.removeListener(() { });
               Methods.instance.saveShowCase(isFirst:ReelsScreenTaps. isFirst);
            }
          },
          builder: Builder(
            builder: (context) {
              return Stack(
                alignment: Alignment.topCenter,
                children: [
                  TabBarView(
                    controller: _tabController,
                    children: const [
                      FollowingReelsScreen(),
                      ReelsScreen(),

                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5
                    ),
                    child: TabBar(
                      // indicator: BoxDecoration(),
                      isScrollable: true,
                      indicatorColor: Colors.white,
                      labelStyle: TextStyle(
                        fontSize: ConfigSize.defaultSize! * 1.5,
                        fontWeight: FontWeight.bold
                      ),
                      unselectedLabelColor: Colors.grey,
                      indicatorPadding: EdgeInsets.symmetric(
                          horizontal: ConfigSize.defaultSize!*2,


                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: ConfigSize.defaultSize!*2.5,
                           ),
                      controller: _tabController,
                      tabs: [
                        Text(
                          StringManager.followingReels.tr(),
                          // style:
                          // Theme.of(context).textTheme.headlineSmall!.copyWith(
                          //   // color: Colors.white,
                          //     fontSize:  ConfigSize.defaultSize! * 1.6
                          // ),
                        ),
                        Text(
                          StringManager.forYou.tr(),
                          // style:
                          // Theme.of(context).textTheme.headlineSmall!.copyWith(
                          //     // color: Colors.white,
                          //   fontSize:  ConfigSize.defaultSize! * 1.6
                          // ),
                        ),




                      ],
                    ),
                  ),

                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
