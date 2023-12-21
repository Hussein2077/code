import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/invitation_bloc_s/get_invitation_parent_bloc/get_invitations_parent_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/invitation_bloc_s/get_invitation_parent_bloc/get_invitations_parent_state.dart';

class ProfitCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ConfigSize.screenWidth,
      height: ConfigSize.screenHeight! * 0.25,
      margin: EdgeInsets.symmetric(
          vertical: ConfigSize.defaultSize! * 1,
          horizontal: ConfigSize.defaultSize! * 1.8),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors:  [
            const Color(0xFFFF382C),
            const Color(0xFFFFBB0D),
            Colors.white.withOpacity(0.8),
            Colors.white.withOpacity(0.9),
            Colors.white,
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),

          //color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 2.5),
          border: Border.all(color: Colors.white)),
      child: BlocBuilder<GetInvitationParentDetailsBloc, InvitationDetailsParentStates>(
        builder: (context, state) {
          if (state is ParentDataScussesState) {
            return SizedBox(
              width: ConfigSize.screenWidth,
              height: ConfigSize.screenHeight! * 0.25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(StringManager.dayEarned.tr()),
                          Text(state.parentStaticsModel.dayEarned.toString()),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(StringManager.dayInvited.tr()),
                          Text(state.parentStaticsModel.dayInvited.toString()),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(StringManager.totalEarned.tr()),
                          Text(state.parentStaticsModel.totalEarned.toString()),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(StringManager.totalInvited.tr()),
                          Text(state.parentStaticsModel.totalInvited.toString()),
                        ],
                      ),
                    ],
                  ),
                  MainButton(
                    width: ConfigSize.screenWidth! * 0.6,
                    height: ConfigSize.screenHeight! * 0.05,
                    title: StringManager.watch.tr(),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.userScreen,
                      );
                    },
                  ),
                ],
              ),
            );
          } else if (state is ParentDataErorrState) {
            log('kkkkk2');

            return CustomErrorWidget(
              message: state.massage,
            );
          } else if (state is ParentDataLoadingState) {
            log('kkkkk3');

            return const LoadingWidget();
          } else {
            log('kkkkk4');

            return const SizedBox();
          }
        },
      ),
    );
  }
}
