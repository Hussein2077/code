import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/see_more_text.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/my_videos_screen/widgets/reels_box.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/user_profile/component/user_reel_viewr/widget/user_reels_controller.dart';
import 'package:tik_chat_v2/features/reels/data/models/reel_comment_model.dart';
import 'package:tik_chat_v2/features/reels/data/models/reel_model.dart';
import 'package:tik_chat_v2/core/utils/convert_numbers_to_short.dart';
import 'package:tik_chat_v2/features/reels/persentation/components/comments/comment_bottomsheet.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reel_comments/get_reel_comments_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reel_comments/get_reel_comments_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reel_comments/get_reel_comments_state.dart';
import 'package:tik_chat_v2/features/reels/persentation/reels_controller.dart';
import 'package:tik_chat_v2/features/reels/persentation/widgets/user_image_reel.dart';
import 'dart:ui' as ui;

class UserScreenOptions extends StatelessWidget {
  final ReelModel item;
  final bool showVerifiedTick;
  final Function(ReelModel)? onShare;
  final Function(int)? onLike;
  final Function(String)? onComment;
  final Function(int, int)? onClickMoreBtn;
  final Function(String, bool)? onFollow;
  //final bool? userView;
  final bool? isFollowed;

  const UserScreenOptions(
      {Key? key,
        required this.item,
        this.showVerifiedTick = true,
        this.onClickMoreBtn,
        this.onComment,
        this.onFollow,
        this.onLike,
        this.onShare,
       // this.userView,
        this.isFollowed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ReelCommentModel>? commentListtemp;
    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: ConfigSize.defaultSize!),
          child: SizedBox(
            width:
            MediaQuery.of(context).size.width - ConfigSize.defaultSize! * 2,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (item.userImage != null)
                        UserImageReel(
                          image: item.userImage!,
                          isFollowed: item.isFollow,
                          userId: item.userId!,
                          onFollow: onFollow,
                        ),
                      if (item.userImage == null)
                        CircleAvatar(
                          radius: ConfigSize.defaultSize! * 2,
                          child: Icon(Icons.person, size: ConfigSize.defaultSize! * 2),
                        ),
                      SizedBox(height: ConfigSize.defaultSize),
                      Column(
                        children: [
                          // if (userView == false)
                          //   if (onLike != null)
                          //     if (!UserReelsController.likedVideos[item.id.toString()]!)
                          //       IconButton(
                          //         icon: Icon(
                          //           CupertinoIcons.heart_solid,
                          //           color: Colors.white,
                          //           size: ConfigSize.defaultSize! * 4,
                          //         ),
                          //         onPressed: () => onLike!(item.id!),
                          //       ),
                          //User View
                        //  if (userView == true)
                            if (onLike != null)
                              if (!ReelsBox.likedVideos[item.id.toString()]!)
                                IconButton(
                                  icon: Icon(
                                    CupertinoIcons.heart_solid,
                                    color: Colors.white,
                                    size: ConfigSize.defaultSize! * 4,
                                  ),
                                  onPressed: () => onLike!(item.id!),
                                ),
                          // if (userView == false)
                          //   if (UserReelsController.likedVideos[item.id.toString()]!)
                          //     IconButton(
                          //       icon: Icon(
                          //         CupertinoIcons.heart_solid,
                          //         color: Colors.red,
                          //         size: ConfigSize.defaultSize! * 4,
                          //       ),
                          //       onPressed: () => onLike!(item.id!),
                          //     ),
                          //User View
                          //if (userView == true)
                            if (ReelsBox.likedVideos[item.id.toString()]!)
                              IconButton(
                                icon: Icon(
                                  CupertinoIcons.heart_solid,
                                  color: Colors.red,
                                  size: ConfigSize.defaultSize! * 4,
                                ),
                                onPressed: () => onLike!(item.id!),
                              ),
                          // userView == false
                          //     ? Text(
                          //     NumbersToShort.convertNumToShort(UserReelsController
                          //         .likedVideoCount[item.id.toString()]!),
                          //     style: const TextStyle(color: Colors.white))
                          //     :
                          Text(
                              NumbersToShort.convertNumToShort(
                                  ReelsBox.likedVideoCount[item.id.toString()]!),
                              style: const TextStyle(color: Colors.white)),
                          SizedBox(height: ConfigSize.defaultSize),
                          IconButton(
                            icon: const Icon(CupertinoIcons.chat_bubble_text_fill,
                                color: Colors.white),
                            onPressed: () {
                              if (onComment != null) {
                                if (commentListtemp == null) {

                                  BlocProvider.of<GetReelCommentsBloc>(context).add(
                                      GetReelsCommentsEvent(
                                          reelId: item.id.toString()));
                                }

                                showModalBottomSheet(
                                    barrierColor: Colors.transparent,
                                    context: context,
                                    builder: (ctx) => BlocBuilder<GetReelCommentsBloc,
                                        GetReelsCommentsState>(
                                      builder: (context, state) {
                                        if (state
                                        is GetReelsCommentsSucssesState) {
                                          commentListtemp = state.data;

                                          return CommentBottomSheet(
                                              reelId: item.id.toString(),
                                             // commentList: commentListtemp ?? state.data ?? [],
                                              onComment: onComment);
                                        } else if (state
                                        is GetReelsCommentsLoadingState) {
                                          if (commentListtemp == null) {
                                            return const LoadingWidget();
                                          } else {
                                            return CommentBottomSheet(
                                                reelId: item.id.toString(),
                                               // commentList: commentListtemp ?? [],
                                                onComment: onComment);
                                          }
                                        } else if (state
                                        is GetReelsCommentsErrorState) {
                                          return CustomErrorWidget(
                                              message: state.errorMassage);
                                        } else {
                                          return CustomErrorWidget(
                                            message: StringManager
                                                .unexcepectedError
                                                .tr(),
                                          );
                                        }
                                      },
                                    ));
                              }

                            },
                          ),
                          Text(NumbersToShort.convertNumToShort(item.commentNum!),
                              style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                      SizedBox(height: ConfigSize.defaultSize! * 1),
                      InkWell(
                        onTap: () => onShare!(item),
                        child: Transform(
                          transform: Matrix4.rotationZ(5.8),
                          child: const Icon(
                            CupertinoIcons.arrowshape_turn_up_right_fill,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: ConfigSize.defaultSize),
                      if (onClickMoreBtn != null)
                        IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () => onClickMoreBtn!(item.id!, item.userId!),
                          color: Colors.white,
                        ),
                      // Center(
                      //   child: SizedBox(
                      //       width:ConfigSize.screenWidth!*0.8,
                      //       //MediaQuery.of(context).size.width -
                      //           //ConfigSize.defaultSize!,
                      //       child: ExpandableText(
                      //         item.description.toString(),
                      //         trimLines: 3,
                      //         style: TextStyle(
                      //             color: Colors.white,
                      //             fontSize: ConfigSize.defaultSize! * 1.6),
                      //         //overflow: TextOverflow.fade,
                      //       )),
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width - ConfigSize.defaultSize! * 11,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                            width:ConfigSize.screenWidth!*0.7,
                            //MediaQuery.of(context).size.width -
                            //ConfigSize.defaultSize!,
                            child: ExpandableText(
                              item.userName.toString(),
                              textAlign: TextAlign.right,
                              trimLines: 3,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: ConfigSize.defaultSize! * 1.8),
                              //overflow: TextOverflow.fade,
                            )),
                        SizedBox(
                          height: ConfigSize.defaultSize,
                        ),
                        SizedBox(
                            width:ConfigSize.screenWidth!*0.7,
                            //MediaQuery.of(context).size.width -
                            //ConfigSize.defaultSize!,
                            child: ExpandableText(
                              item.description.toString(),
                              textAlign: TextAlign.right,

                              trimLines: 3,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ConfigSize.defaultSize! * 1.6),
                              //overflow: TextOverflow.fade,
                            )),
                      ],
                    ),
                  ),
                ]
            ),
          )),
    );
  }
}
