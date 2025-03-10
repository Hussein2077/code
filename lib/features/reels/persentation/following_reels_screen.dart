
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/dynamic_link.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/follow_manger/bloc/follow_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/follow_manger/bloc/follow_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_following_reels/get_following_reels_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_following_reels/get_following_reels_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_following_reels/get_following_reels_state.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_make_reel_like/make_reel_like_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/reels_controller.dart';
import 'package:tik_chat_v2/features/reels/persentation/widgets/reels_page.dart';
import 'package:tik_chat_v2/features/reels/persentation/widgets/reels_viewer.dart';

import 'manager/manager_make_reel_like/make_reel_like_bloc.dart';

class FollowingReelsScreen extends StatefulWidget {
  const FollowingReelsScreen({super.key});

  @override
  State<FollowingReelsScreen> createState() => _FollowingReelsScreenState();
}

class _FollowingReelsScreenState extends State<FollowingReelsScreen> {
  late TextEditingController report  ;


  @override
  void initState() {
    report = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    report.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: BlocConsumer<GetFollowingReelsBloc, GetFollowingReelsState>(
            builder: (context, state) {
              if (state is GetFollowingReelsSucssesState) {
                ReelsPage.isFirst = true;
                ReelsController.getInstance.likesMap(state.data!);
                ReelsController.getInstance.likesCountMap(state.data!);
                ReelsController.getInstance.followMap(state.data!);
                return LiquidPullToRefresh(
                  color: ColorManager.bage,
                  backgroundColor: ColorManager.loadingColor,
                  showChildOpacityTransition : false,


                  onRefresh: () async{

                    BlocProvider.of<GetFollowingReelsBloc>(context).add(GetFollowingReelsEvent());

                  },
                  child: ReelsViewer(
                    followingOrReels: true,
                    reelsList: state.data!,
                    onShare: (reel) {
                      DynamicLinkProvider().showReelLink(
                        reelId: reel.id!,
                        reelImage: reel.userImage!,
                      ).then((value) {
                        Share.share(value);
                      });
                    },
                    onLike: (id) {
                      BlocProvider.of<MakeReelLikeBloc>(context).add(MakeReelLikeEvent(reelId: id.toString()));
                      setState(() {
                        ReelsController.likedVideos[id.toString()] = !ReelsController.likedVideos[id.toString()]!;
                        ReelsController.getInstance.changeLikeCount(id.toString());
                      });
                    },
                    onFollow: (userId, isFollow) {
                      setState(() {
                        ReelsController.followingMap[userId] = !ReelsController.followingMap[userId]!;
                      });
                      BlocProvider.of<FollowBloc>(context).add(FollowEvent(userId: userId));
                    },
                    onComment: (comment) {
                    },
                    onClickMoreBtn: (id, userData) {

                      Navigator.pushNamed(context, Routes.reportReelsScreen,
                          arguments: ReportReelsScreenPramiter(
                              id: id.toString(),
                              userId: userData.toString(),
                              report: report

                          )
                      );

                    },
                    onClickBackArrow: () {
                      Navigator.pop(context);
                    },
                    showProgressIndicator: false,
                    showVerifiedTick: false,
                    showAppbar: true,
                  ),
                );
              } else if (state is GetFollowingReelsLoadingState) {


                return const LoadingWidget();


              } else if (state is GetFollowingReelsErrorState) {
                return CustomErrorWidget(message: state.errorMassage);
              } else {
                return CustomErrorWidget(message: StringManager.unexcepectedError.tr());
              }
            },
            listener: (context, state) async {
              if (state is GetFollowingReelsSucssesState) {

                for (int i = 0; i < state.data!.length; i++) {
                  if (!ReelsController.thumbnail.containsKey(state.data![i].id.toString())) {
                    Uint8List thumbnailPath = await ReelsController.getInstance.getVideoThumbnail(state.data![i].url!);
                    ReelsController.thumbnail.putIfAbsent(state.data![i].id.toString(), () => thumbnailPath);
                  }
                }
              }
            },
          )),
    );
  }
}
