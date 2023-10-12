import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/dynamic_link.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/moment/presentation/moment_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/user_profile/component/user_reel_viewr/widget/problem_customers_services.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/follow_manger/bloc/follow_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/follow_manger/bloc/follow_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_reels/get_user_reels_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_reels/get_user_reels_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reels/get_reels_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reels/get_reels_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reels/get_reels_state.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_make_reel_like/make_reel_like_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_make_reel_like/make_reel_like_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_report_reals/report_reals_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_report_reals/report_reals_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_report_reals/report_reals_state.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_upload_reel/upload_reels_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_upload_reel/upload_reels_state.dart';
import 'package:tik_chat_v2/features/reels/persentation/reels_controller.dart';
import 'package:tik_chat_v2/features/reels/persentation/widgets/reels_viewer.dart';
import 'package:tik_chat_v2/main_screen/main_screen.dart';
import 'package:tik_chat_v2/splash.dart';


class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => ReelsScreenState();
}

late TextEditingController report;

class ReelsScreenState extends State<ReelsScreen> with TickerProviderStateMixin{
  static ValueNotifier<bool> follow = ValueNotifier<bool>(false);
  static Map<String, Uint8List> thumbnail = {};
  static Map<String, bool> likedVideos = {};
  static Map<String, int> likedVideoCount = {};
  static Map<String, bool> followMap = {};

  late TabController _tabController;




  // static List<String> followList = [];

  @override
  void initState() {
    super.initState();

    likedVideos = {};
    likedVideoCount = {};
    followMap = {};

    // followList = [];
    if (SplashScreen.initPage == 1) {
      BlocProvider.of<GetReelsBloc>(context).add(GetReelsEvent(reelId: MainScreen.reelId));
    }

    report = TextEditingController();
    _tabController = TabController(
      length: 2,
      vsync: this, // Provide a TickerProvider
    );
  }

  @override
  void dispose() {

    report.dispose();
    likedVideos.clear();
    likedVideoCount.clear();
    followMap.clear();
    thumbnail.clear();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: ConfigSize.defaultSize!*3.8,
          backgroundColor: Theme.of(context).colorScheme.background,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: TabBar(indicatorColor: ColorManager.orang,
              indicatorSize: TabBarIndicatorSize.label,
              controller: _tabController,
              tabs: [
                Text(
                  StringManager.reels.tr(),
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(
                  StringManager.momentTab.tr(),
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            BlocListener<UploadReelsBloc, UploadReelsState>(
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
                            ReelsController.getInstance.likesCountMap(state.data!);
                            ReelsController.getInstance.followMap(state.data!);
                         log(" instaincr reel ${    ReelsController.getInstance.hashCode}");
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
                                BlocProvider.of<MakeReelLikeBloc>(context)
                                    .add(MakeReelLikeEvent(reelId: id.toString()));
                                setState(() {
                                  ReelsScreenState.likedVideos[id.toString()] =
                                      !ReelsScreenState.likedVideos[id.toString()]!;
                                  ReelsController.getInstance.changeLikeCount(id.toString());
                                });
                              },
                              onFollow: (userId, isFollow) {
                                setState(() {
                                  followMap[userId] = !followMap[userId]!;

                                });
                                BlocProvider.of<FollowBloc>(context)
                                    .add(FollowEvent(userId: userId));
                              },
                              onComment: (comment) {
                                log('Comment on reel ==> $comment');
                              },
                              onClickMoreBtn: (id, userData) {
                                bottomDailog(
                                    context: context,
                                    widget: SingleChildScrollView(
                                      padding: EdgeInsets.only(
                                        bottom:
                                            MediaQuery.of(context).viewInsets.bottom,
                                      ),
                                      child: moreDilog(
                                        context: context,
                                        userId: userData.toString(),
                                        id: id.toString(),
                                      ),
                                    ));
                                log('======> Clicked on more option <======');
                              },
                              onClickBackArrow: () {
                                Navigator.pop(context);
                                log('======> Clicked on back arrow <======');
                              },
                              onIndexChanged: (index) {
                                if(state.data!.length - index == 4){
                                  BlocProvider.of<GetReelsBloc>(context).add(LoadMoreReelsEvent());
                                }
                                log("${state.data!.length}zzzzz");
                                log('======> Current Index ======> $index <========');
                              },
                              showProgressIndicator: false,
                              showVerifiedTick: false,
                              showAppbar: true,
                            );
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
                              if (!thumbnail
                                  .containsKey(state.data![i].id.toString())) {
                                Uint8List thumbnailPath = await  ReelsController.getInstance
                                    .getVideoThumbnail(state.data![i].url!);
                                thumbnail.putIfAbsent(state.data![i].id.toString(),
                                    () => thumbnailPath);
                              }
                            }
                          }
                        },
                      )))),

            const MomentScreen(),
          ],
        ));



      // BlocListener<UploadReelsBloc, UploadReelsState>(
      //   listener: (context, state) {
      //     if (state is UploadReelsLoadingState) {
      //       loadingToast(context: context, title: StringManager.loading.tr());
      //     } else if (state is UploadReelsErrorState) {
      //       errorToast(context: context, title: state.error);
      //     } else if (state is UploadReelsSucssesState) {
      //       BlocProvider.of<GetUserReelsBloc>(context).add(const GetUserReelEvent(id: null));
      //       sucssesToast(context: context, title: state.message);
      //     }
      //   },
      //   child: Scaffold(
      //       body: SizedBox(
      //           width: MediaQuery.of(context).size.width,
      //           height: MediaQuery.of(context).size.height,
      //           child: BlocConsumer<GetReelsBloc, GetReelsState>(
      //             builder: (context, state) {
      //               if (state is GetReelsSucssesState) {
      //                 ReelsController.getInstance.likesMap(state.data!);
      //                 ReelsController.getInstance.likesCountMap(state.data!);
      //                 ReelsController.getInstance.followMap(state.data!);
      //              log(" instaincr reel ${    ReelsController.getInstance.hashCode}");
      //                 return ReelsViewer(
      //                   userView: false,
      //                   reelsList: state.data!,
      //                   appbarTitle: StringManager.reels.tr(),
      //                   onShare: (reel) {
      //                     DynamicLinkProvider()
      //                         .showReelLink(
      //                       reelId: reel.id!,
      //                       reelImage: reel.userImage!,
      //                     )
      //                         .then((value) {
      //                       Share.share(value);
      //                     });
      //                   },
      //                   onLike: (id) {
      //                     BlocProvider.of<MakeReelLikeBloc>(context)
      //                         .add(MakeReelLikeEvent(reelId: id.toString()));
      //                     setState(() {
      //                       ReelsScreenState.likedVideos[id.toString()] =
      //                           !ReelsScreenState.likedVideos[id.toString()]!;
      //                       ReelsController.getInstance.changeLikeCount(id.toString());
      //                     });
      //                   },
      //                   onFollow: (userId, isFollow) {
      //                     setState(() {
      //                       followMap[userId] = !followMap[userId]!;
      //
      //                     });
      //                     BlocProvider.of<FollowBloc>(context)
      //                         .add(FollowEvent(userId: userId));
      //                   },
      //                   onComment: (comment) {
      //                     log('Comment on reel ==> $comment');
      //                   },
      //                   onClickMoreBtn: (id, userData) {
      //                     bottomDailog(
      //                         context: context,
      //                         widget: SingleChildScrollView(
      //                           padding: EdgeInsets.only(
      //                             bottom:
      //                                 MediaQuery.of(context).viewInsets.bottom,
      //                           ),
      //                           child: moreDilog(
      //                             context: context,
      //                             userId: userData.toString(),
      //                             id: id.toString(),
      //                           ),
      //                         ));
      //                     log('======> Clicked on more option <======');
      //                   },
      //                   onClickBackArrow: () {
      //                     Navigator.pop(context);
      //                     log('======> Clicked on back arrow <======');
      //                   },
      //                   onIndexChanged: (index) {
      //                     if(state.data!.length - index == 4){
      //                       BlocProvider.of<GetReelsBloc>(context).add(LoadMoreReelsEvent());
      //                     }
      //                     log(state.data!.length.toString() + "zzzzz");
      //                     log('======> Current Index ======> $index <========');
      //                   },
      //                   showProgressIndicator: false,
      //                   showVerifiedTick: false,
      //                   showAppbar: true,
      //                 );
      //               } else if (state is GetReelsLoadingState) {
      //                 return const LoadingWidget();
      //               } else if (state is GetReelsErrorState) {
      //                 return CustomErrorWidget(message: state.errorMassage);
      //               } else {
      //                 return CustomErrorWidget(
      //                     message: StringManager.unexcepectedError.tr());
      //               }
      //             },
      //             listener: (context, state) async {
      //               if (state is GetReelsSucssesState) {
      //                 for (int i = 0; i < state.data!.length; i++) {
      //                   if (!thumbnail
      //                       .containsKey(state.data![i].id.toString())) {
      //                     Uint8List thumbnailPath = await  ReelsController.getInstance
      //                         .getVideoThumbnail(state.data![i].url!);
      //                     thumbnail.putIfAbsent(state.data![i].id.toString(),
      //                         () => thumbnailPath);
      //                   }
      //                 }
      //               }
      //             },
      //           ))));
  }

  Widget moreDilog({
    required BuildContext context,
    required String id,
    required String userId,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: ConfigSize.defaultSize!,
          horizontal: ConfigSize.defaultSize!),
      width: MediaQuery.of(context).size.width,
      height: ConfigSize.defaultSize! * 35,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize!)),
      child: moreReportDialogIcon(
        context: context,
        title: StringManager.report.tr(),
        onTap: () => BlocProvider.of<ReportRealsBloc>(context).add(ReportReals(
            reportedId: userId, realId: id, description: report.text)),
      ),
    );
  }

  Widget moreReportDialogIcon(
      {required BuildContext context,
      required String title,
      void Function()? onTap}) {
    return BlocListener<ReportRealsBloc, ReportRealsState>(
      listener: (context, state) {
        if (state is ReportReelsLoadingState) {
          loadingToast(context: context, title: StringManager.loading.tr());
        } else if (state is ReportReelsSucssesState) {
          sucssesToast(context: context, title: state.message);
        } else if (state is ReportReelsErrorState) {
          sucssesToast(context: context, title: state.error);
        }
      },
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            ProblemTextFormField(
              textEditingController: report,
            ),
            MainButton(
              onTap: onTap!,
              title: StringManager.report.tr(),
              width: MediaQuery.of(context).size.width,
            ),
          ],
        ),
      ),
    );
  }
}
