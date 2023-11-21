import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/user_info_row.dart';

import '../../../../../../core/widgets/loading_widget.dart';
import '../../../manager/get_follwers_or_following_manger/bloc/get_follower_or_following_bloc.dart';
import '../../../manager/get_follwers_or_following_manger/bloc/get_follower_or_following_event.dart';
import '../../../manager/get_follwers_or_following_manger/bloc/get_follower_or_following_state.dart';

class SendItemWidgetVip extends StatelessWidget {
  const SendItemWidgetVip({Key? key, required this.itemId})
      : super(key: key);
  final String itemId;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetFollowerOrFollowingBloc>(context)
        .add(const GetFriendsOrFollowersOrFollwothemEvent(type: '3'));
    return BlocBuilder<GetFollowerOrFollowingBloc, GetFollowerOrFollowingState>(
      builder: (context, state) {
        if (state is GetFollowerOrFollowingSucssesState) {
          return Container(
            color: Theme.of(context).colorScheme.background,
            child: ListView.builder(
                itemCount: state.data!.length,
                itemBuilder: (context, index) {
                  return UserInfoRow(
                    itemId: itemId,
                    userData: state.data![index],
                    flag:'vip' ,
                    // showId: true,
                  );
                }),
          );
        } else if (state is GetFollowerOrFollowingLoadingState) {
          return const LoadingWidget();
        } else {
          return  Scaffold(
            body: Center(
                child: CustomErrorWidget(
              message: StringManager.unexcepectedError.tr(),
            )),
          );
        }
      },
    );
  }
}
