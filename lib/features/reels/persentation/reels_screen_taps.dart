
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
                FollowingReelsScreen(),
                ReelsScreen(),

              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 5
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  color: ColorManager.orang,
                  borderRadius: BorderRadius.circular(
                      ConfigSize.defaultSize! * 0.8),
                ),
                isScrollable: true,
                padding: EdgeInsets.symmetric(
                  vertical: ConfigSize.defaultSize!,
                    horizontal: ConfigSize.defaultSize! ),
                controller: _tabController,
                tabs: [
                  Text(
                    StringManager.followingReels.tr(),
                    style:
                    Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    StringManager.reels.tr(),
                    style:
                    Theme.of(context).textTheme.headlineSmall,
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
