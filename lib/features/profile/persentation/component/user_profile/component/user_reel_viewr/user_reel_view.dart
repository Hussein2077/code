import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/dynamic_link.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/my_videos_screen/widgets/reels_box.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/user_profile/component/user_reel_viewr/widget/user_reels_controller.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/user_profile/component/user_reel_viewr/widget/user_reels_viewer.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/follow_manger/bloc/follow_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/follow_manger/bloc/follow_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_delete_reel/delete_reel_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_delete_reel/delete_reel_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_delete_reel/delete_reel_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_reels/get_user_reels_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_reels/get_user_reels_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_reels/get_user_reels_state.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_make_reel_like/make_reel_like_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_make_reel_like/make_reel_like_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_upload_reel/upload_reels_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_upload_reel/upload_reels_state.dart';

class UserReelView extends StatefulWidget {
  final UserDataModel userDataModel;
  final int startIndex;

  const UserReelView({
    super.key,
    required this.userDataModel,
    required this.startIndex,
  });

  @override
  State<UserReelView> createState() => UserReelViewState();
}


class UserReelViewState extends State<UserReelView> {
  late TextEditingController report;

  @override
  void initState() {
    report = TextEditingController();
    // TODO: implement initState
    super.initState();
  }


  @override
  void dispose() {
    report.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UploadReelsBloc, UploadReelsState>(
      listener: (context, state) {
        if (state is UploadReelsLoadingState) {
          loadingToast(context: context, title: StringManager.loading.tr());
        } else if (state is UploadReelsErrorState) {
          errorToast(context: context, title: state.error);
        } else if (state is UploadReelsSucssesState) {
          sucssesToast(context: context, title: state.message);
        }
      },
      child: BlocListener<DeleteReelBloc, DeleteReelState>(
        listener: (context, state) {
          if (state is DeleteReelSucssesState) {
            BlocProvider.of<GetUserReelsBloc>(context)
                .add(const GetUserReelEvent(id: null));
            Navigator.pop(context);
          } else if (state is DeleteReelLodingState) {
            loadingToast(context: context, title: StringManager.loading.tr());
          } else if (state is DeleteReelErrorState) {
            errorToast(context: context, title: state.error);
          }
        },
        child: Scaffold(body: BlocBuilder<GetUserReelsBloc, GetUserReelsState>(
          builder: (context, state) {
            if (state is GetUserReelsSucssesState) {
              return UserReelsViewer(
                userData:widget.userDataModel ,
                //userView: true,
                startIndex: widget.startIndex,
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
                    ReelsBox.likedVideos[id.toString()] =
                    !ReelsBox.likedVideos[id.toString()]!;
                    UserReelsController.getInstance.changeLikeUserCount(id
                        .toString());
                  });
                  log(ReelsBox.likedVideos.toString());
                },
                onFollow: (userId, isFollow) {
                  BlocProvider.of<FollowBloc>(context)
                      .add(FollowEvent(userId: userId));
                },
                onComment: (comment) {
                  log('Comment on reel ==> $comment');
                },
                onClickMoreBtn: (id, userId) {
                  if (userId == MyDataModel.getInstance().id) {
                    return bottomDailog(
                        context: context,
                        widget: moreDilog(
                            report: report,
                            userId: userId.toString(),
                            context: context,
                            id: id.toString()));
                  } else {
                    Navigator.pushNamed(context, Routes.reportReelsScreen,
                        arguments: ReportReelsScreenPramiter(
                            id: id.toString(),
                            userId: userId.toString(),
                            report: report

                        )
                    );
                  }
                  /*MoreDialog(id : id ,userId: userId,report: report, )*/


                  log('======> Clicked on more option <======');
                },
                onClickBackArrow: () {
                  log('======> Clicked on back arrow <======');
                },

                showProgressIndicator: false,
                showVerifiedTick: false,
                showAppbar: true, isFromVideo: false,
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
        )),
      ),
    );
  }
}

Widget moreDilog({required TextEditingController report,
  required BuildContext context,
  required String id,
  required String userId,
}) {
  return Container(
      padding: EdgeInsets.symmetric(
          vertical: ConfigSize.defaultSize!,
          horizontal: ConfigSize.defaultSize!),
      width: MediaQuery
          .of(context)
          .size
          .width,
      height:  ConfigSize.defaultSize! * 12,
      decoration: BoxDecoration(
          color: Theme
              .of(context)
              .colorScheme
              .background,
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize!)),
      child: moreDilogIcon(
        context: context,
        widget: Icon(
          Icons.delete,
          color: Theme
              .of(context)
              .colorScheme
              .background,
        ),
        title: StringManager.delete.tr(),
        onTap: () =>
            BlocProvider.of<DeleteReelBloc>(context)
                .add(DeleteReelEvent(id: id)),
      )


  );
}

Widget moreDilogIcon({required BuildContext context,
  required Widget widget,
  required String title,
  void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Column(
      children: [
        Container(
          width: ConfigSize.defaultSize! * 4,
          height: ConfigSize.defaultSize! * 4,
          decoration: BoxDecoration(
              color: Theme
                  .of(context)
                  .colorScheme
                  .primary,
              shape: BoxShape.circle),
          child: Center(
            child: widget,
          ),
        ),
        Text(
          title,
          style: Theme
              .of(context)
              .textTheme
              .bodyMedium,
        )
      ],
    ),
  );
}

