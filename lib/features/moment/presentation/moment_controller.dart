import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_following_moment/get_following_user_moment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_following_moment/get_following_user_moment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_user_moment/get_moment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_user_moment/get_moment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_all/get_moment_all_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_all/get_moment_all_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_i_like_it/get_moment_i_like_it_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_i_like_it/get_moment_i_like_it_event.dart';

import 'widgets/moment_bottom_bar.dart';

class MomentController {
  static get getInstance => MomentController();

  //comments
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
    else if (MomentBottomBarState.momentType == MomentType.allMoments){
      BlocProvider.of<GetMomentallBloc>(context).add(
          LocalCommentMomentAllEvent(momentId:MomentBottomBarState.selectedMoment.toString() , type: type ));

    }
  }


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
    }else if(MomentBottomBarState.momentType == MomentType.allMoments){

      BlocProvider.of<GetMomentallBloc>(context).add(LocalLikeMomentAll(momentId:MomentBottomBarState.selectedMoment.toString() ));

    }
  }
//gifts
  void giftController(BuildContext context) {

    if (MomentBottomBarState.momentType == MomentType.myMoment) {

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
    }else if (MomentBottomBarState.momentType == MomentType.allMoments) {
      BlocProvider.of<GetMomentallBloc>(context).add(LocalGiftMomentAllEvent(
          giftsNum: MomentBottomBarState.giftsNum,
          momentId:MomentBottomBarState.selectedMoment.toString() ));
    }
  }
}













