import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/reels/data/models/reel_comment_model.dart';
import 'package:tik_chat_v2/features/reels/data/models/reel_model.dart';
import 'package:tik_chat_v2/core/utils/convert_numbers_to_short.dart';
import 'package:tik_chat_v2/features/reels/persentation/components/comments/comment_bottomsheet.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reel_comments/get_reel_comments_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reel_comments/get_reel_comments_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reel_comments/get_reel_comments_state.dart';
import 'package:tik_chat_v2/features/reels/persentation/reels_screen.dart';

class ScreenOptions extends StatelessWidget {
  final ReelModel item;
  final bool showVerifiedTick;
  final Function(String)? onShare;
  final Function(int)? onLike;
  final Function(String)? onComment;
  final Function()? onClickMoreBtn;
  final Function()? onFollow;

  const ScreenOptions({
    Key? key,
    required this.item,
    this.showVerifiedTick = true,
    this.onClickMoreBtn,
    this.onComment,
    this.onFollow,
    this.onLike,
    this.onShare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ReelCommentModel>? commentListtemp;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 110),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (item.userImage != null)
                          InkWell(
                              onTap: () {
                                if (item.userId ==
                                    MyDataModel.getInstance().id) {
                                  Navigator.pushNamed(
                                      context, Routes.userProfile);
                                } else {
                                  Navigator.pushNamed(
                                      context, Routes.userProfile,
                                      arguments: UserProfilePreamiter(
                                          null, item.userId.toString()));
                                }
                              },
                              child: UserImage(image: item.userImage!)),
                        if (item.userImage == null)
                          const CircleAvatar(
                            radius: 16,
                            child: Icon(Icons.person, size: 18),
                          ),
                        const SizedBox(width: 6),
                        Text(item.userName!,
                            style: const TextStyle(color: Colors.white)),
                        const SizedBox(width: 10),
                        if (showVerifiedTick)
                          const Icon(
                            Icons.verified,
                            size: 15,
                            color: Colors.white,
                          ),
                        if (showVerifiedTick) const SizedBox(width: 6),
                        if (onFollow != null &&
                            item.userId != MyDataModel.getInstance().id)
                          TextButton(
                            onPressed: onFollow,
                            child: Text(
                              StringManager.follow.tr(),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 6),
                    if (item.description != null)
                      Text(item.description ?? '',
                          style: const TextStyle(color: Colors.white)),
                    const SizedBox(height: 10),
                    // if (item.musicName != null)
                    //   Row(
                    //     children: [
                    //       const Icon(
                    //         Icons.music_note,
                    //         size: 15,
                    //         color: Colors.white,
                    //       ),
                    //       Text(
                    //         'Original Audio - ${item.musicName}',
                    //         style: const TextStyle(color: Colors.white),
                    //       ),
                    //     ],
                    //   ),
                  ],
                ),
              ),
              Column(
                children: [
                  if (onLike != null && (!item.likeExists!&&!ReelsScreenState.likedVideos.contains(item.id)))
                    IconButton(
                      icon: const Icon(Icons.favorite_outline,
                          color: Colors.white),
                      onPressed: () => onLike!(item.id!),
                    ),
                  if (item.likeExists!||ReelsScreenState.likedVideos.contains(item.id))
                  
                    const Icon(Icons.favorite_rounded, color: Colors.red),
                  Text(
                    (!item.likeExists!&&ReelsScreenState.likedVideos.contains(item.id))?
                    NumbersToShort.convertNumToShort(item.likeNum!+1):NumbersToShort.convertNumToShort(item.likeNum!),
                      style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 20),
                  IconButton(
                    icon:
                        const Icon(Icons.comment_rounded, color: Colors.white),
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
                                    if (state is GetReelsCommentsSucssesState) {
                                      commentListtemp = state.data;
                                      return CommentBottomSheet(
                                          reelId: item.id.toString(),
                                          commentList: commentListtemp ??
                                              state.data ??
                                              [],
                                          onComment: onComment);
                                    } else if (state
                                        is GetReelsCommentsLoadingState) {
                                      if (commentListtemp == null) {
                                        return const LoadingWidget();
                                      } else {
                                        return CommentBottomSheet(
                                            reelId: item.id.toString(),
                                            commentList: commentListtemp ?? [],
                                            onComment: onComment);
                                      }
                                    } else if (state
                                        is GetReelsCommentsErrorState) {
                                      return CustomErrorWidget(
                                          message: state.errorMassage);
                                    } else {
                                      return CustomErrorWidget(
                                        message: StringManager.unexcepectedError
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
                  const SizedBox(height: 20),
                  if (onShare != null)
                    InkWell(
                      onTap: () => onShare!(item.url!),
                      child: Transform(
                        transform: Matrix4.rotationZ(5.8),
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  if (onClickMoreBtn != null)
                    IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: onClickMoreBtn!,
                      color: Colors.white,
                    ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
