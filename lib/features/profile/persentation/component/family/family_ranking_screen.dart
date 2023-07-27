import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/screen_back_ground.dart';
import 'package:tik_chat_v2/core/widgets/screen_color_back_ground.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/family/widgets/other_top_widget.dart';

import 'widgets/family_rank_bottom_bar.dart';
import 'widgets/family_rank_tabs.dart';
import 'widgets/top_three_widget.dart';

class FamilyRankingScreen extends StatefulWidget {
  const FamilyRankingScreen({super.key});

  @override
  State<FamilyRankingScreen> createState() => _FamilyRankingScreenState();
}

class _FamilyRankingScreenState extends State<FamilyRankingScreen>
    with TickerProviderStateMixin {
  late TabController rankingController;
  @override
  void initState() {
    rankingController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenColorBackGround(
            color: ColorManager.mainColorList,
            child: ScreenBackGround(
                image: AssetsPath.familyBackGround,
                child: Column(
                  children: [
                    SizedBox(
                      height: ConfigSize.defaultSize! * 3.5,
                    ),
                    const HeaderWithOnlyTitle(
                      title: StringManager.family,
                      titleColor: Colors.white,
                    ),
                    FamilyRankTabs(
                      rankingController: rankingController,
                    ),
                    SizedBox(
                      height: ConfigSize.defaultSize! * 3,
                    ),
                    Expanded(
                      child:
                          TabBarView(controller: rankingController, children: [
                        for (int i = 0; i < 3; i++)
                          Stack(
                            children: [
                              const TopThreeWidget(),
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: ConfigSize.defaultSize! * 21),
                                  child: const OtherTopWidget())
                            ],
                          ),
                      ]),
                    ),
                    const FamilyRankBottomBar()
                  ],
                ))));
  }
}
