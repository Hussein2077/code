import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/home/data/model/user_rank_model.dart';

import 'package:tik_chat_v2/features/home/presentation/component/top_users/widget/time_tabs.dart';

import 'top_user_time_body.dart';

class TopUsersTypeBody extends StatelessWidget {
//     final RankingModel? usersRankD;
//   final RequestState dState;
//   final String dError;
//   final RankingModel? usersRankCW;
//   final RequestState wState;
//   final String wError;
//   final RankingModel? usersRankCM;
//   final RequestState mState;
//   final String mError;
 final TabController timeController ; 
  const TopUsersTypeBody({
    // required this.usersRankD , 
    
     required this.timeController, 
     
     super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         TimeTabs(timeController: timeController,),
           SizedBox(height: ConfigSize.defaultSize!*3,),           

    Expanded(
    child: TabBarView(
      controller: timeController,
      children:const [
    TopUserTimeBody(),
    TopUserTimeBody(),
    TopUserTimeBody(),
    ]),
    )
     
      ],
    );
  }
}
