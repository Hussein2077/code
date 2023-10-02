import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/reels/data/models/reel_comment_model.dart';
import 'package:tik_chat_v2/features/reels/persentation/components/comments/comment_item.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reel_comments/get_reel_comments_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reel_comments/get_reel_comments_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_make_reel_comment/make_reel_comment_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_make_reel_comment/make_reel_comment_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_make_reel_comment/make_reel_comment_state.dart';
import '../../../../../core/utils/config_size.dart';

class CommentBottomSheet extends StatefulWidget {
  final List<ReelCommentModel> commentList;
  final String reelId;
  final Function(String)? onComment;

  const CommentBottomSheet(
      {Key? key,
      required this.commentList,
      this.onComment,
      required this.reelId})
      : super(key: key);

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  final ScrollController scrollController = ScrollController();

  final commentController = TextEditingController(text: '');
  @override
  void initState() {
    scrollController.addListener(scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MakeReelCommentBloc, MakeReelCommentState>(
      listener: (context, state) {
        if (state is MakeReelCommentSucssesState){
          BlocProvider.of<GetReelCommentsBloc>(context).add(
                              GetReelsCommentsEvent(
                                  reelId: widget.reelId));
        }else if (state is MakeReelCommentErrorState){
          errorToast(context: context, title: state.error);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(ConfigSize.defaultSize! * 1.6),
            topRight: Radius.circular(ConfigSize.defaultSize! * 1.6),
          ),
          color: Colors.transparent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: ConfigSize.defaultSize! * 1.6,
                  right: ConfigSize.defaultSize! * 1.6,
                  top: ConfigSize.defaultSize!*1.6),
              child: Text(
                StringManager.comments.tr(),
                style: TextStyle(color: Colors.black, fontSize: ConfigSize.defaultSize!*1.8),
              ),
            ),
             SizedBox(height: ConfigSize.defaultSize!*2),
            if (widget.commentList.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding:  EdgeInsets.only(left: ConfigSize.defaultSize!*1.6, right: ConfigSize.defaultSize!*1.6),
                  itemCount: widget.commentList.length,
                  itemBuilder: (ctx, i) =>
                      CommentItem(commentItem: widget.commentList[i]),
                ),
              ),
            if (widget.commentList.isEmpty)
               Expanded(
                  child: Center(
                child: Text(StringManager.noCommentsYet.tr()),
              )),
            const Divider(),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: TextField(
                controller: commentController,
                decoration: InputDecoration(
                  hintText:  StringManager.addAComment.tr(),//noCommentsYet
                  hintStyle: const TextStyle(color: Colors.grey),
                  contentPadding:  EdgeInsets.all(ConfigSize.defaultSize!),
                  border: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  suffixIcon: InkWell(
                      onTap: () {
                        if (widget.onComment != null) {
                          String comment = commentController.text;
                          widget.onComment!(comment);
                        }
                        BlocProvider.of<MakeReelCommentBloc>(context).add(
                            MakeReelCommentEvent(
                                comment: commentController.text,
                                reelId: widget.reelId));
                                commentController.clear();
                      },
                      child: const Icon(Icons.send)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      BlocProvider.of<GetReelCommentsBloc>(context)
          .add(LoadMoreReelsCommentsEvent(reelId: widget.reelId));
    } else {}
  }
}
