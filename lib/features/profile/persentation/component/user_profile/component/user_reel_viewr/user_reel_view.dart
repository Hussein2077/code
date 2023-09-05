import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/dynamic_link.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_reels/get_user_reels_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_reels/get_user_reels_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_reels/get_user_reels_state.dart';

import 'package:tik_chat_v2/features/reels/persentation/manager/manager_make_reel_like/make_reel_like_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_make_reel_like/make_reel_like_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/widgets/reels_viewer.dart';

class UserReelView extends StatefulWidget {
  final UserDataModel userDataModel;
  final int startIndex ; 

  const UserReelView({
    super.key,
    required this.userDataModel,
    required this.startIndex , 
  });

  @override
  State<UserReelView> createState() => UserReelViewState();
}

class UserReelViewState extends State<UserReelView> {
  static List<int> likedVideos = [];

  @override
  void initState() {
    likedVideos = [];

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<GetUserReelsBloc, GetUserReelsState>(
      builder: (context, state) {
        if (state is GetUserReelsSucssesState) {
          for (int i = 0; i < state.data!.length; i++) {
            state.data![i].userId = widget.userDataModel.id;
            state.data![i].userImage = widget.userDataModel.profile!.image;
            state.data![i].userName = widget.userDataModel.name;
          }

          return ReelsViewer(
            userView: true,
            startIndex: widget.startIndex ,
            reelsList: state.data!,
            appbarTitle: StringManager.reels,
            onShare: (reel) {
              DynamicLinkProvider()
                  .showReelLink(
                reelId: reel.id!,
                reelImage: reel.userImage!,
              )
                  .then((value) {
                Share.share(value);
              });
              log('Shared reel url ==> ${reel.id}');
            },
            onLike: (id) {

              BlocProvider.of<MakeReelLikeBloc>(context)
                  .add(MakeReelLikeEvent(reelId: id.toString()));

              setState(() {
               if ( UserReelViewState.likedVideos.contains(id)  ){
                                likedVideos.remove(id);

               }else {
                likedVideos.add(id);

               }
              });
            },
            onFollow: () {
              log('======> Clicked on follow <======');
            },
            onComment: (comment) {
              log('Comment on reel ==> $comment');
            },
            onClickMoreBtn: () {
              log('======> Clicked on more option <======');
            },
            onClickBackArrow: () {
              log('======> Clicked on back arrow <======');
            },
            onIndexChanged: (index) {
              log("heeer");
              if (state.data!.length - index < 5) {
                if (widget.userDataModel.id == MyDataModel.getInstance().id) {
                  BlocProvider.of<GetUserReelsBloc>(context)
                      .add(const LoadMoreUserReelsEvent(id: null));
                } else {
                  BlocProvider.of<GetUserReelsBloc>(context).add(
                      LoadMoreUserReelsEvent(
                          id: widget.userDataModel.id.toString()));
                }
              }
              log(state.data!.length.toString());
              log('======> Current Index ======> $index <========');
            },
            showProgressIndicator: false,
            showVerifiedTick: false,
            showAppbar: true,
          );
        } else if (state is GetUserReelsLoadingState) {
          return const LoadingWidget();
        } else if (state is GetReelUsersErrorState) {
          return CustomErrorWidget(
            message: state.errorMassage,
          );
        } else {
          return CustomErrorWidget(
            message: StringManager.unexcepectedError.tr(),
          );
        }
      },
    ));
  }
}
