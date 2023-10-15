import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_following_moment/get_following_user_moment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_following_moment/get_following_user_moment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_user_moment/get_moment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_user_moment/get_moment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_i_like_it/get_moment_i_like_it_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_i_like_it/get_moment_i_like_it_event.dart';

import 'widgets/moment_bottom_bar.dart';

class MomentController {
  static get getInstance => MomentController();

  //comments

  //commentController(
  void commentController(BuildContext context, String type) {
    if (MomentBottomBarState.momentType == MomentType.myMoment) {
      BlocProvider.of<GetMomentBloc>(context).add(LocalCommentMoment(
          momentId: MomentBottomBarState.selectedMoment.toString(),
          type: type));
    } else if (MomentBottomBarState.momentType == MomentType.likedMoment) {
      BlocProvider.of<GetMomentILikeItBloc>(context).add(
          LocalCommentIlikedMomentEvent(
              momentId: MomentBottomBarState.selectedMoment.toString(),
              type: type));
    } else if (MomentBottomBarState.momentType == MomentType.followingMoment) {
      BlocProvider.of<GetFollowingUserMomentBloc>(context).add(
          LocalCommentFollowingMomentEvent(
              momentId: MomentBottomBarState.selectedMoment.toString(),
              type: type));
    }
  }

  // void commentsDecrement(int momentId){
  //   MomentBottomBarState.commentsOfMomentsMap[momentId] =
  //       MomentBottomBarState.commentsOfMomentsMap[momentId]! - 1;
  //   MomentBottomBarState.commentsCounter.value++;

  // }
  // void fillCommentMap ( List<MomentModel> momentModelList){
  //   log('fillCommentMap1${MomentBottomBarState.commentsOfMomentsMap}');
  //   for (int i = 0; i < momentModelList.length; i++) {
  //     MomentBottomBarState.commentsOfMomentsMap.putIfAbsent(
  //         momentModelList[i].momentId, () => momentModelList[i].commentNum);
  //   }
  // }

  //gifts

  // void giftIncrement(int momentId, int giftsNum) {
  //   MomentBottomBarState.giftsOfMomentsMap[momentId] =
  //       MomentBottomBarState.giftsOfMomentsMap[momentId]! + giftsNum;
  // }
  //
  // void fillGiftMap(List<MomentModel> momentModelList) {
  //   for (int i = 0; i < momentModelList.length; i++) {
  //     MomentBottomBarState.giftsOfMomentsMap.putIfAbsent(
  //         momentModelList[i].momentId, () => momentModelList[i].giftsCount);
  //   }
  // }

  //like

  void likeController(BuildContext context) {
    if (MomentBottomBarState.momentType == MomentType.myMoment) {
      BlocProvider.of<GetMomentBloc>(context).add(LocalLikeMoment(
          momentId: MomentBottomBarState.selectedMoment.toString()));
    } else if (MomentBottomBarState.momentType == MomentType.likedMoment) {
      BlocProvider.of<GetMomentILikeItBloc>(context).add(LocalLikeMomentIliked(
          momentId: MomentBottomBarState.selectedMoment.toString()));
    } else if (MomentBottomBarState.momentType == MomentType.followingMoment) {
      BlocProvider.of<GetFollowingUserMomentBloc>(context).add(
          LocalLikeFollowingMoment(
              momentId: MomentBottomBarState.selectedMoment.toString()));
    }
  }

  void giftController(BuildContext context) {
    log('done1 ');

    if (MomentBottomBarState.momentType == MomentType.myMoment) {
      log('done2 ');

      BlocProvider.of<GetMomentBloc>(context).add(LocalGiftMoment(
          giftsNum: MomentBottomBarState.giftsNum,
          momentId: MomentBottomBarState.selectedMoment.toString()));
      // (momentId:MomentBottomBarState.selectedMoment.toString() ));
    } else if (MomentBottomBarState.momentType == MomentType.likedMoment) {
      BlocProvider.of<GetMomentILikeItBloc>(context).add(LocalGiftILikedMoment(
          giftsNum: MomentBottomBarState.giftsNum,
          momentId:MomentBottomBarState.selectedMoment.toString() ));
    } else if (MomentBottomBarState.momentType == MomentType.followingMoment) {
      BlocProvider.of<GetFollowingUserMomentBloc>(context).add(LocalFollowingGiftMoment(
          giftsNum: MomentBottomBarState.giftsNum,

          momentId:MomentBottomBarState.selectedMoment.toString() ));
    }
  }
}













