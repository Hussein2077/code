
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/dynamic_link.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/follow_manger/bloc/follow_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/follow_manger/bloc/follow_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_reels/get_user_reels_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_reels/get_user_reels_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reels/get_reels_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reels/get_reels_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reels/get_reels_state.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_make_reel_like/make_reel_like_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_make_reel_like/make_reel_like_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_upload_reel/upload_reels_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_upload_reel/upload_reels_state.dart';
import 'package:tik_chat_v2/features/reels/persentation/reels_controller.dart';
import 'package:tik_chat_v2/features/reels/persentation/widgets/more_dialog_widget.dart';
import 'package:tik_chat_v2/features/reels/persentation/widgets/reels_viewer.dart';
import 'package:tik_chat_v2/main_screen/main_screen.dart';
import 'package:tik_chat_v2/splash.dart';


class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => ReelsScreenState();
}

class ReelsScreenState extends State<ReelsScreen>{

  @override
  void initState() {
    if (SplashScreen.initPage == 1) {
      BlocProvider.of<GetReelsBloc>(context).add(GetReelsEvent(reelId: MainScreen.reelId));
    }
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<UploadReelsBloc, UploadReelsState>(
            listener: (context, state) {
              if (state is UploadReelsLoadingState) {
                loadingToast(context: context, title: StringManager.loading.tr());
              } else if (state is UploadReelsErrorState) {
                errorToast(context: context, title: state.error);
              } else if (state is UploadReelsSucssesState) {
                BlocProvider.of<GetUserReelsBloc>(context).add(const GetUserReelEvent(id: null));
                sucssesToast(context: context, title: state.message);
              }
            },
            child: Scaffold(
                body: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: BlocConsumer<GetReelsBloc, GetReelsState>(
                      builder: (context, state) {
                        if (state is GetReelsSucssesState) {
                          ReelsController.getInstance.likesMap(state.data!);
                          ReelsController.getInstance
                              .likesCountMap(state.data!);
                          ReelsController.getInstance.followMap(state.data!);
                          return ReelsViewer(
                            userView: false,
                            reelsList: state.data!,
                            //appbarTitle: StringManager.reels.tr(),
                            onShare: (reel) {
                              DynamicLinkProvider()
                                  .showReelLink(
                                reelId: reel.id!,
                                reelImage: reel.userImage!,
                              )
                                  .then((value) {
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
                              bottomDailog(
                                  context: context,
                                  widget: SingleChildScrollView(
                                    padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom,
                                    ),
                                    child: MoreDialog(
                                      userId: userData.toString(),
                                      id: id.toString(),
                                    ),
                                  ));
                            },
                            onClickBackArrow: () {
                              Navigator.pop(context);
                            },
                            onIndexChanged: (index) {
                              ReelsViewer.reelModel = state.data?[index];
                              if (state.data!.length - index == 4) {
                                BlocProvider.of<GetReelsBloc>(context)
                                    .add(LoadMoreReelsEvent());
                              }
                            },
                            showProgressIndicator: false,
                            showVerifiedTick: false,
                            showAppbar: true,
                          );
                        }
                        else if (state is GetReelsLoadingState) {
                          return const LoadingWidget();
                        }
                        else if (state is GetReelsErrorState) {
                          return CustomErrorWidget(message: state.errorMassage);
                        } else {
                          return CustomErrorWidget(
                              message: StringManager.unexcepectedError.tr());
                        }
                      },
                      listener: (context, state) async {
                        if (state is GetReelsSucssesState) {
                          for (int i = 0; i < state.data!.length; i++) {
                            if (!ReelsController.thumbnail.containsKey(state.data![i].id.toString())) {
                              Uint8List thumbnailPath = await ReelsController.getInstance.getVideoThumbnail(state.data![i].url!);
                              ReelsController.thumbnail.putIfAbsent(state.data![i].id.toString(), () => thumbnailPath);
                            }
                          }
                        }
                      },
                    ))
            )));

  }
}
