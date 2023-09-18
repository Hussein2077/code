import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/home/data/model/user_rank_model.dart';
import 'package:tik_chat_v2/features/home/presentation/component/top_users/widget/time_tabs.dart';

import 'top_user_time_body.dart';

class TopUsersTypeBody extends StatelessWidget {
  final RankingModel? usersRankH;
  final RequestState hState;
  final String hError;
  final RankingModel? usersRankD;
  final RequestState dState;
  final String dError;
  final RankingModel? usersRankW;
  final RequestState wState;
  final String wError;
  final RankingModel? usersRankM;
  final RequestState mState;
  final String mError;
  final TabController timeController;
  const TopUsersTypeBody(
      {required this.usersRankD,
      required this.dState,
      required this.dError,
      required this.usersRankW,
      required this.wState,
      required this.wError,
      required this.usersRankM,
      required this.mState,
      required this.mError,
      required this.timeController,
      required this.hError,
      required this.hState,
      required this.usersRankH,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TimeTabs(
          timeController: timeController,
        ),
        SizedBox(
          height: ConfigSize.defaultSize! * 3,
        ),
        Expanded(
          child: TabBarView(controller: timeController, children: [
            TopUserTimeBody(
              error: hError,
              state: hState,
              usersRank: usersRankH,
            ),
            TopUserTimeBody(
              error: dError,
              state: dState,
              usersRank: usersRankD,
            ),
            TopUserTimeBody(
              error: wError,
              state: wState,
              usersRank: usersRankW,
            ),
            TopUserTimeBody(
              error: mError,
              state: mState,
              usersRank: usersRankM,
            ),
          ]),
        )
      ],
    );
  }
}
