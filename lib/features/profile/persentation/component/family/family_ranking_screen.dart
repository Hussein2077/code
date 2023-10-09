import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/screen_back_ground.dart';
import 'package:tik_chat_v2/core/widgets/screen_color_back_ground.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/family_ranking_manager/family_ranking_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/family_ranking_manager/family_ranking_state.dart';

import 'widgets/family_rank_bottom_bar.dart';
import 'widgets/family_rank_tabs.dart';
import 'widgets/tab_bar_view.dart';

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
  void dispose() {
    rankingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FamilyRankingBloc, FamilyRankingStates>(
      builder: (context, state) {
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
                        HeaderWithOnlyTitle(
                          title: StringManager.family.tr(),
                          titleColor: Colors.white,
                        ),
                        FamilyRankTabs(
                          rankingController: rankingController,
                        ),
                        SizedBox(
                          height: ConfigSize.defaultSize! * 3,
                        ),
                        Expanded(
                          child: TabBarView(
                              controller: rankingController,
                              children: [
                                RankingTabBarView(
                                  data: state.dailyData,
                                  stateRequest: state.dailyDataRequest,
                                  message: state.dailyDatakMassage,
                                ),
                                RankingTabBarView(
                                  data: state.weekData,
                                  stateRequest: state.weekDataRequest,
                                  message: state.weekDatakMassage,
                                ),
                                RankingTabBarView(
                                  data: state.monthData,
                                  stateRequest: state.monthDataRequest,
                                  message: state.monthDatakMassage,
                                ),
                              ]),
                        ),
                        const FamilyRankBottomBar()
                      ],
                    ))));
      },
    );
  }
}
