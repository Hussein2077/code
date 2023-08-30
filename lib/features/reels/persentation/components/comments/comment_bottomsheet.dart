import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/reels/data/models/reel_comment_model.dart';
import 'package:tik_chat_v2/features/reels/persentation/components/comments/comment_item.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reel_comments/get_reel_comments_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reel_comments/get_reel_comments_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_make_reel_comment/make_reel_comment_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_make_reel_comment/make_reel_comment_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_make_reel_comment/make_reel_comment_state.dart';

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
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          color: Colors.transparent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Text(
                'Comments',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            if (widget.commentList.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  itemCount: widget.commentList.length,
                  itemBuilder: (ctx, i) =>
                      CommentItem(commentItem: widget.commentList[i]),
                ),
              ),
            if (widget.commentList.isEmpty)
              const Expanded(
                  child: Center(
                child: Text('No Comments yet.'),
              )),
            const Divider(),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: TextField(
                controller: commentController,
                decoration: InputDecoration(
                  hintText: 'Add a comment...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  contentPadding: const EdgeInsets.all(10),
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
