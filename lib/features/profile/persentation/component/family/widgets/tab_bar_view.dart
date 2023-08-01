

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/profile/data/model/fanily_rank_model.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/family/widgets/other_top_widget.dart';

import 'top_three_widget.dart';

class RankingTabBarView extends StatelessWidget {
    final FamilyRankModel? data;
  final RequestState stateRequest;
  final String message ; 
  const RankingTabBarView({required this.message ,  this.data , required this.stateRequest , super.key});

  @override
  Widget build(BuildContext context) {
     switch (stateRequest){
       case RequestState.loaded:
       return Stack(
                            children: [
                               TopThreeWidget(topRanking: data!.topRanking),
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: ConfigSize.defaultSize! * 21),
                                  child:  OtherTopWidget(otherRanking: data!.otherRanking,))
                            ],
                          );
       
       case RequestState.loading:
       return const LoadingWidget();
       case RequestState.error:
         return CustoumErrorWidget(message: message);
     }
            
  }
}