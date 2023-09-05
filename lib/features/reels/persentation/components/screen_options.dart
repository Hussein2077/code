import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/user_profile/component/user_reel_viewr/user_reel_view.dart';
import 'package:tik_chat_v2/features/reels/data/models/reel_comment_model.dart';
import 'package:tik_chat_v2/features/reels/data/models/reel_model.dart';
import 'package:tik_chat_v2/core/utils/convert_numbers_to_short.dart';
import 'package:tik_chat_v2/features/reels/persentation/components/comments/comment_bottomsheet.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reel_comments/get_reel_comments_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reel_comments/get_reel_comments_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reel_comments/get_reel_comments_state.dart';
import 'package:tik_chat_v2/features/reels/persentation/reels_screen.dart';
import 'package:tik_chat_v2/features/reels/persentation/widgets/user_image_reel.dart';

class ScreenOptions extends StatelessWidget {
  final ReelModel item;
  final bool showVerifiedTick;
  final Function(ReelModel)? onShare;
  final Function(int)? onLike;
  final Function(String)? onComment;
  final Function()? onClickMoreBtn;
  final Function(String,bool)? onFollow;
  final bool? userView;
  final bool isFollowed ;

  const ScreenOptions({
    Key? key,
    required this.item,
    this.showVerifiedTick = true,
    this.onClickMoreBtn,
    this.onComment,
    this.onFollow,
    this.onLike,
    this.onShare,
    this.userView,
  required  this.isFollowed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ReelCommentModel>? commentListtemp;
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (item.userImage != null)
              UserImageReel(image: item.userImage!,isFollowed: isFollowed, userId:item.userId! ,onFollow: onFollow, ),
            if (item.userImage == null)
              const CircleAvatar(
                radius: 16,
                child: Icon(Icons.person, size: 18),
              ),
            SizedBox(height: ConfigSize.defaultSize),
            if (userView == null)
              if (onLike != null &&
                  (!item.likeExists! &&
                      !ReelsScreenState.likedVideos.contains(item.id)))
                IconButton(
                  icon: Icon(
                    CupertinoIcons.heart_solid,
                    color: Colors.white,
                    size: ConfigSize.defaultSize! * 4,
                  ),
                  onPressed: () => onLike!(item.id!),
                ),
            if (userView == true)
              if (onLike != null &&
                  (!UserReelViewState.likedVideos.contains(item.id)))
                IconButton(
                  icon: Icon(
                    CupertinoIcons.heart_solid,
                    color: Colors.white,
                    size: ConfigSize.defaultSize! * 4,
                  ),
                  onPressed: () => onLike!(item.id!),
                ),
            if (userView == null)
              if (item.likeExists! ||
                  ReelsScreenState.likedVideos.contains(item.id))
                IconButton(
                  icon: Icon(
                    CupertinoIcons.heart_solid,
                    color: Colors.red,
                    size: ConfigSize.defaultSize! * 4,
                  ),
                  onPressed: () => onLike!(item.id!),
                ),
            if (userView == true)
              if (UserReelViewState.likedVideos.contains(item.id))
                IconButton(
                  icon: Icon(
                    CupertinoIcons.heart_solid,
                    color: Colors.red,
                    size: ConfigSize.defaultSize! * 4,
                  ),
                  onPressed: () => onLike!(item.id!),
                ),
            userView == null
                ? Text(
                    (!item.likeExists! &&
                            ReelsScreenState.likedVideos.contains(item.id))
                        ? NumbersToShort.convertNumToShort(item.likeNum! + 1)
                        : NumbersToShort.convertNumToShort(item.likeNum!),
                    style: const TextStyle(color: Colors.white))
                : Text(
                    (!item.likeExists! &&
                            UserReelViewState.likedVideos.contains(item.id))
                        ? NumbersToShort.convertNumToShort(item.likeNum! + 1)
                        : (item.likeExists! &&
                                !UserReelViewState.likedVideos
                                    .contains(item.id))
                            ? NumbersToShort.convertNumToShort(
                                item.likeNum! - 1)
                            : NumbersToShort.convertNumToShort(item.likeNum!),
                    style: const TextStyle(color: Colors.white)),
            SizedBox(height: ConfigSize.defaultSize),
            IconButton(
              icon: const Icon(CupertinoIcons.chat_bubble_text_fill,
                  color: Colors.white),
              onPressed: () {
                if (onComment != null) {
                  if (commentListtemp == null) {
                    BlocProvider.of<GetReelCommentsBloc>(context)
                        .add(GetReelsCommentsEvent(reelId: item.id.toString()));
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
                                    commentList:
                                        commentListtemp ?? state.data ?? [],
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
                              } else if (state is GetReelsCommentsErrorState) {
                                return CustomErrorWidget(
                                    message: state.errorMassage);
                              } else {
                                return CustomErrorWidget(
                                  message: StringManager.unexcepectedError.tr(),
                                );
                              }
                            },
                          ));
                }
              },
            ),
            Text(NumbersToShort.convertNumToShort(item.commentNum!),
                style: const TextStyle(color: Colors.white)),
            SizedBox(height: ConfigSize.defaultSize! * 2),
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
                onPressed: onClickMoreBtn!,
                color: Colors.white,
              ),
          ],
        ));
  }
}
