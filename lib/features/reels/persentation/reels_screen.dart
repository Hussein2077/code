import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/dynamic_link.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/snackbar.dart';
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
import 'package:tik_chat_v2/features/reels/persentation/reels_screen_taps.dart';
import 'package:tik_chat_v2/features/reels/persentation/widgets/reels_page.dart';
import 'package:tik_chat_v2/features/reels/persentation/widgets/reels_viewer.dart';
import 'package:tik_chat_v2/main_screen/components/nav_bar/bottom_nav_layout.dart';
import 'package:tik_chat_v2/main_screen/main_screen.dart';
import 'package:tik_chat_v2/splash.dart';

final GlobalKey keyForUploadVideo = GlobalKey();
final GlobalKey keyForSwapInCenter = GlobalKey();
final GlobalKey keyForSwapInBottom = GlobalKey();

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => ReelsScreenState();
}

class ReelsScreenState extends State<ReelsScreen> {
  late TextEditingController report;

  static int currentIndex = 0;
  static ValueNotifier<int> currentIndexNavBar = ValueNotifier<int>(-1);

  @override
  void initState() {
    report = TextEditingController();
    if (SplashScreen.initPage == 1) {
      BlocProvider.of<GetReelsBloc>(context)
          .add(GetReelsEvent(reelId: MainScreen.reelId));
    }

    startShowCase(context);


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
        body: BlocListener<UploadReelsBloc, UploadReelsState>(
            listener: (context, state) {
              if (state is UploadReelsLoadingState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(loadingSnackBar(context));
              } else if (state is UploadReelsErrorState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(errorSnackBar(context, state.error));
              } else if (state is UploadReelsSucssesState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(successSnackBar(context, state.message));

                BlocProvider.of<GetUserReelsBloc>(context)
                    .add(const GetUserReelEvent(id: null));
              }
            },
            child: Scaffold(
                body: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: BlocConsumer<GetReelsBloc, GetReelsState>(
                      builder: (context, state) {
                        if (state is GetReelsSucssesState) {
                          ReelsPage.isFirst = true;
                          ReelsController.getInstance.likesMap(state.data!);
                          ReelsController.getInstance
                              .likesCountMap(state.data!);
                          ReelsController.getInstance.followMap(state.data!);
                          return LiquidPullToRefresh(
                              color: ColorManager.bage,
                              backgroundColor: ColorManager.loadingColor,
                              showChildOpacityTransition : false,


                              onRefresh: () async{

                                BlocProvider.of<GetReelsBloc>(context).add(GetReelsEvent());

                              },
                              child:

                            ReelsViewer(
                            followingOrReels: false,

                            // userView: false,
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
                              BlocProvider.of<MakeReelLikeBloc>(context).add(
                                  MakeReelLikeEvent(reelId: id.toString()));
                              setState(() {
                                ReelsController.likedVideos[id.toString()] =
                                    !ReelsController
                                        .likedVideos[id.toString()]!;
                                ReelsController.getInstance
                                    .changeLikeCount(id.toString());
                              });
                            },
                            onFollow: (userId, isFollow) {
                              setState(() {
                                ReelsController.followingMap[userId] =
                                    !ReelsController.followingMap[userId]!;
                              });
                              BlocProvider.of<FollowBloc>(context)
                                  .add(FollowEvent(userId: userId));
                            },
                            onComment: (comment) {},
                            onClickMoreBtn: (id, userData) {
                              Navigator.pushNamed(
                                  context, Routes.reportReelsScreen,
                                  arguments: ReportReelsScreenPramiter(
                                      id: id.toString(),
                                      userId: userData.toString(),
                                      report: report));
                            },
                            onClickBackArrow: () {
                              Navigator.pop(context);
                            },

                            showProgressIndicator: false,
                            showVerifiedTick: false,
                            showAppbar: true,
                          ));
                        } else if (state is GetReelsLoadingState) {
                          return const LoadingWidget();
                        } else if (state is GetReelsErrorState) {
                          return CustomErrorWidget(message: state.errorMassage);
                        } else {
                          return CustomErrorWidget(
                              message: StringManager.unexcepectedError.tr());
                        }
                      },
                      listener: (context, state) async {
                        if (state is GetReelsSucssesState) {
                          for (int i = 0; i < state.data!.length; i++) {
                            if (!ReelsController.thumbnail
                                .containsKey(state.data![i].id.toString())) {
                              Uint8List thumbnailPath = await ReelsController
                                  .getInstance
                                  .getVideoThumbnail(state.data![i].url!);
                              ReelsController.thumbnail.putIfAbsent(
                                  state.data![i].id.toString(),
                                  () => thumbnailPath);
                            }
                          }
                        }
                      },
                    )))));
  }
  Future<bool?> startShowCase(BuildContext context) async {
    // todo remove one of them
    ReelsScreenTaps.isFirst =
    await Methods.instance.getShowCase().then((value) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(seconds: 2), () {
          if (ReelsScreenTaps.isFirst &&
              BottomNavLayoutState.currentIndex == 1) {
            ShowCaseWidget.of(context).startShowCase(
                [keyForUploadVideo, keyForSwapInCenter, keyForSwapInBottom]);
          }
        });
      });
      if (ReelsScreenTaps.isFirst) {
        ReelsScreenState.currentIndexNavBar.addListener(() {
          Future.delayed(const Duration(seconds: 2), () {
            if (ReelsScreenTaps.isFirst &&
                BottomNavLayoutState.currentIndex == 1) {
              ShowCaseWidget.of(context).startShowCase(
                  [keyForUploadVideo, keyForSwapInCenter, keyForSwapInBottom]);
            }
          });
        });
      }
      return true;
    });
  }
}
