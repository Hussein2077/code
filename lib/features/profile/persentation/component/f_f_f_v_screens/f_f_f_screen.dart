import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/snackbar.dart';
import 'package:tik_chat_v2/core/widgets/user_info_row.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/f_f_f_v_screens/logic_follow_unfollow.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/follow_manger/bloc/follow_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/follow_manger/bloc/follow_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_follwers_or_following_manger/bloc/get_follower_or_following_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_follwers_or_following_manger/bloc/get_follower_or_following_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_follwers_or_following_manger/bloc/get_follower_or_following_state.dart';

// ignore: must_be_immutable
class FFFScreen extends StatefulWidget {
  final String title;
  int page = 1;

  FFFScreen({required this.title, super.key});

  @override
  State<FFFScreen> createState() => _FFFScreenState();
}

class _FFFScreenState extends State<FFFScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    LogicFollowUnfollow.theFollowedUsersMap.clear();

    scrollController.addListener(scrollListener);

    if (widget.title == StringManager.friends.tr()) {
      BlocProvider.of<GetFollowerOrFollowingBloc>(context)
          .add(const GetFriendsOrFollowersOrFollwothemEvent(type: '3'));
    } else if (widget.title == StringManager.followers.tr()) {
      BlocProvider.of<GetFollowerOrFollowingBloc>(context)
          .add(const GetFriendsOrFollowersOrFollwothemEvent(type: '2'));
    } else {
      BlocProvider.of<GetFollowerOrFollowingBloc>(context)
          .add(const GetFriendsOrFollowersOrFollwothemEvent(type: '1'));
    }
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: ConfigSize.defaultSize! * 0.8,
          ),
          HeaderWithOnlyTitle(
            title: widget.title,
          ),
          BlocListener<FollowBloc, FollowState>(
            listener: (context, state) {

              if (state is FollowSucssesState) {

                LogicFollowUnfollow.followUnfollowController(
                    LogicFollowUnfollow.userId,
                    LogicFollowUnfollow
                        .theFollowedUsersMap[LogicFollowUnfollow.userId]!);
              }else if(state is FollowErrorState){
                ScaffoldMessenger.of(context).showSnackBar(
                    errorSnackBar(context,state.error));
              }else if(state is UnFollowSucssesState){
                LogicFollowUnfollow.followUnfollowController(
                    LogicFollowUnfollow.userId,
                    LogicFollowUnfollow
                        .theFollowedUsersMap[LogicFollowUnfollow.userId]!);

              }else if(state is UnFollowErrorState){
                ScaffoldMessenger.of(context).showSnackBar(
                    errorSnackBar(context,state.error));
                }
            },
            child: BlocBuilder<GetFollowerOrFollowingBloc,
                GetFollowerOrFollowingState>(
              builder: (context, state) {
                if (state is GetFollowerOrFollowingSucssesState) {
                  return Expanded(
                    child: ListView.builder(
                        controller: scrollController,
                        itemCount: state.data!.length,
                        itemExtent: 80,
                        itemBuilder: (context, index) {
                          LogicFollowUnfollow.theFollowedUsersMap.putIfAbsent(
                              state.data![index].id!,
                              () => state.data![index].isFollow!);

                          return UserInfoRow(
                            userData: state.data![index],
                            endIcon: ValueListenableBuilder(
                              valueListenable:
                                  LogicFollowUnfollow.followUnfollowNotifier,
                              builder: (context, value, child) {
                                return MainButton(
                                  title: LogicFollowUnfollow.theFollowedUsersMap[state.data![index].id]! ? StringManager.unFollow.tr() : StringManager.follow.tr(),
                                  titleSize: LogicFollowUnfollow.theFollowedUsersMap[state.data![index].id]! ? ConfigSize.defaultSize! / 1.2 : ConfigSize.defaultSize! * 1.2,
                                  width: ConfigSize.defaultSize! * 6,
                                  height: ConfigSize.defaultSize! * 3,
                                  buttonColor: LogicFollowUnfollow.theFollowedUsersMap[state.data![index].id]! ? ColorManager.bageGriedinet : const [
                                    Color(0x96FF382C),
                                    Color(0x90FFBB0D),
                                  ],
                                  onTap: () {
                                    LogicFollowUnfollow.userId = state.data![index].id!;
                                    LogicFollowUnfollow.followUnfollowControllerEvents(
                                        context,
                                        state.data![index].id!,
                                        LogicFollowUnfollow.theFollowedUsersMap[state.data![index].id]!,
                                    );
                                  },
                                );
                              },
                            ),
                            idOrNot: const SizedBox(),
                          );
                        }),
                  );
                } else if (state is GetFollowerOrFollowingLoadingState) {
                  return const LoadingWidget();
                } else if (state is GetFollowerOrFollowingErrorState) {
                  return CustomErrorWidget(
                    message: state.errorMassage,
                  );
                } else {
                  return CustomErrorWidget(
                    message: StringManager.unexcepectedError.tr(),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      widget.page++;
      if (widget.title == StringManager.friends.tr()) {
        BlocProvider.of<GetFollowerOrFollowingBloc>(context).add(
            GetMoreFriendsOrFollowersOrFollwothemEvent(
                type: '3', page: widget.page.toString()));
      } else if (widget.title == StringManager.followers.tr()) {
        BlocProvider.of<GetFollowerOrFollowingBloc>(context).add(
            GetMoreFriendsOrFollowersOrFollwothemEvent(
                type: '2', page: widget.page.toString()));
      } else {
        BlocProvider.of<GetFollowerOrFollowingBloc>(context).add(
            GetMoreFriendsOrFollowersOrFollwothemEvent(
                type: '1', page: widget.page.toString()));
      }
    } else {}
  }
}
