
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/features/reels/persentation/reels_screen.dart';
import '../../../core/utils/config_size.dart';
import 'following_reels_screen.dart';

class ReelsScreenTaps extends StatefulWidget {
  const ReelsScreenTaps({super.key});

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
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            TabBarView(
              controller: _tabController,
              children: const [
                ReelsScreen(),
                FollowingReelsScreen(),
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
                labelPadding: EdgeInsets.symmetric(
                  horizontal: ConfigSize.defaultSize!
                ),
                labelStyle: TextStyle(
                  fontSize: ConfigSize.defaultSize! * 1.5,
                  fontWeight: FontWeight.bold
                ),
                unselectedLabelColor: Colors.grey,

                indicatorPadding: EdgeInsets.symmetric(
                    horizontal: ConfigSize.defaultSize!*2,
                  vertical:  ConfigSize.defaultSize!-16,

                ),
                padding: EdgeInsets.symmetric(
                  vertical: ConfigSize.defaultSize!*2,
                     ),
                controller: _tabController,
                tabs: [
                  Text(
                    StringManager.reels.tr(),
                    // style:
                    // Theme.of(context).textTheme.headlineSmall!.copyWith(
                    //     // color: Colors.white,
                    //   fontSize:  ConfigSize.defaultSize! * 1.6
                    // ),
                  ),

                  Text(
                    StringManager.followingReels.tr(),
                    // style:
                    // Theme.of(context).textTheme.headlineSmall!.copyWith(
                    //   // color: Colors.white,
                    //     fontSize:  ConfigSize.defaultSize! * 1.6
                    // ),
                  ),


                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
