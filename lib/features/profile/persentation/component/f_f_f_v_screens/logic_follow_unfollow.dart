import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/follow_manger/bloc/follow_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/follow_manger/bloc/follow_event.dart';

class LogicFollowUnfollow {

  static ValueNotifier<int> followUnfollowNotifier = ValueNotifier<int>(0);
  static Map<int, bool> theFollowedUsersMap = {};
  static int userId =-1;


  static void followUnfollowControllerEvents(
      BuildContext context, int userId, bool isFollow) {

    if (isFollow) {
      BlocProvider.of<FollowBloc>(context)
          .add(UnFollowEvent(userId: userId.toString()));
    } else {
      BlocProvider.of<FollowBloc>(context)
          .add(FollowEvent(userId: userId.toString()));
    }
  }

  static void followUnfollowController(

      int userId, bool isFollow) {
    log('4');
    log('44444${userId}');


    if (isFollow) {
      log('5555${userId}');

      LogicFollowUnfollow.theFollowedUsersMap[userId] = false;
      LogicFollowUnfollow.followUnfollowNotifier.value++;
    } else {
      log('66666${userId}');

      LogicFollowUnfollow.theFollowedUsersMap[userId] = true;
      LogicFollowUnfollow.followUnfollowNotifier.value++;

    }
  }
}
