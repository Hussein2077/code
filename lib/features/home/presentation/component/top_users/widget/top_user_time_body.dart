import 'package:flutter/material.dart';

import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/home/data/model/user_rank_model.dart';
import 'package:tik_chat_v2/features/home/presentation/component/top_users/widget/first_sec_thr_users.dart';
import 'package:tik_chat_v2/features/home/presentation/component/top_users/widget/others_users.dart';

class TopUserTimeBody extends StatelessWidget {
  final RankingModel? usersRank;
  final RequestState state;
  final String error;
 final String type;
  const TopUserTimeBody(
      {required this.usersRank,
      required this.error,
      required this.state,
      required this.type,
      super.key});

  @override
  Widget build(BuildContext context) {
    Brightness currentBrightness = Theme.of(context).brightness;
    bool isDarkTheme = currentBrightness == Brightness.dark;

    switch (state) {
      case RequestState.loaded:
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 50,
                height: ConfigSize.defaultSize! * 27,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: isDarkTheme
                            ? const AssetImage(
                                AssetsPath.topUsersBackGroundBlack)
                            : const AssetImage(AssetsPath.topUsersBackGround),
                        fit: BoxFit.fill)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //sec
                      FirstSecThrUsers(
                        userData:usersRank!.userRankModels[1] ,
                        badge: AssetsPath.secBadge,
                        height: ConfigSize.defaultSize! * 9,
                        position: ConfigSize.defaultSize! * 11,
                        type: type,
                      ),

                      // first
                      FirstSecThrUsers(
                        userData:usersRank!.userRankModels[0]  ,
                        badge: AssetsPath.firstBadge,
                        height: ConfigSize.defaultSize! * 10,
                        position: ConfigSize.defaultSize! * 6,
                        type: type,
                      ),
                      //third
                      FirstSecThrUsers(
                        userData: usersRank!.userRankModels[2] ,
                        badge: AssetsPath.thrBadge,
                        height: ConfigSize.defaultSize! * 9,
                        position: ConfigSize.defaultSize! * 11,
                        type: type,
                      ),
                    ]),
              ),
               OthersUsers(usersData:usersRank!.userOtherModel,
                 type: type,
    ),
            ],
          ),
        );
      case RequestState.loading:
        {
          return const LoadingWidget();
        }
      case RequestState.error:
        return CustomErrorWidget(
          message: error,
        );
    }
  }
}
