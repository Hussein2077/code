
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_comment_model.dart';
import 'package:tik_chat_v2/features/moment/presentation/componants/comments/widgets/comment_textfield.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_delete_comment/delete_moment_comment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_delete_comment/delete_moment_comment_state.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_moment_comment/get_moment_comment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_moment_comment/get_moment_comment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_moment_comment/get_moment_comment_state.dart';
import 'package:tik_chat_v2/features/moment/presentation/moment_controller.dart';
import 'package:tik_chat_v2/features/moment/presentation/widgets/moment_bottom_bar.dart';

import 'widgets/moment_comment_row.dart';

class MomentCommentsScreen extends StatefulWidget {
  final String momentId;
final String? type;
  const MomentCommentsScreen({
    required this.momentId,
     this.type,
    super.key,
  });

  @override
  State<MomentCommentsScreen> createState() => MomentCommentsScreenState();
}

class MomentCommentsScreenState extends State<MomentCommentsScreen> {
  List<MomentCommentModel>? commentListtemp=[];
  TextEditingController commentController = TextEditingController(text: '');
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    BlocProvider.of<GetMomentCommentBloc>(context)
        .add(GetMomentCommentEvent(momentId: widget.momentId.toString()));
    super.initState();
    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    commentListtemp!.clear();
    MomentBottomBarState.commentsCounter.value++;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteMomentCommentBloc, DeleteMomentCommentState>(
      listener: (context, state) {
        if (state is DeleteMomentCommentSucssesState) {
          BlocProvider.of<GetMomentCommentBloc>(context)
              .add(GetMomentCommentEvent(momentId: widget.momentId.toString()));
          MomentController.commentsDecrement(int.parse(widget.momentId));
          MomentBottomBarState.commentsCounter.value++;
          sucssesToast(context: context, title: state.message);
        } else if (state is DeleteMomentCommentErrorState) {
          errorToast(context: context, title: state.error);
        } else if (state is DeleteMomentCommentLoadingState) {
          loadingToast(context: context);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: ConfigSize.screenHeight!,
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: ConfigSize.defaultSize! * 3,
                    ),
                    Row(
                      children: [
                        const Spacer(flex: 1,),
                        IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios)),
                        const Spacer(flex: 4,),
                        Text(StringManager.comments,style: Theme.of(context).textTheme.titleLarge,),
                        const Spacer(flex: 5,),
                      ],
                    ),


                    BlocBuilder<GetMomentCommentBloc, GetMomentCommentState>(
                      builder: (context, state) {
                        if (state is GetMomentCommentSucssesState) {
                          commentListtemp = state.data;
                          return SizedBox(
                            width: ConfigSize.screenWidth!,
                            height: ConfigSize.screenHeight! * 0.88,
                            child: Column(
                              children: [
                                Container(
                                  height: ConfigSize.screenHeight! * 0.82,
                                  padding: EdgeInsets.only(
                                    left: ConfigSize.defaultSize!,
                                    right: ConfigSize.defaultSize!,
                                  ),
                                  child: state.data!.isNotEmpty
                                      ? MomentComments(
                                    type: widget.type,
                                          momentCommentListModel:
                                               state.data!,
                                          scrollController: scrollController,
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                              Text(
                                                StringManager.thisMoment.tr(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                              ),
                                            ]),
                                ),
                                CommentTextField(
                                  commentController: commentController,
                                  momentId: widget.momentId.toString(),
                                ),
                              ],
                            ),
                          );
                        }
                        else if (state is GetMomentCommentErrorState) {
                          return CustomErrorWidget(
                            message: state.errorMassage,
                          );
                        } else if (state is GetMomentCommentLoadingState) {
                          if (commentListtemp!.isEmpty) {
                            return SizedBox(
                                height: ConfigSize.screenHeight! * 0.88,
                                child: const LoadingWidget());
                          } else {

                            return SizedBox(
                              width: ConfigSize.screenWidth!,
                              height: ConfigSize.screenHeight! * 0.88,
                              child: Column(
                                children: [
                                  Container(
                                      height: ConfigSize.screenHeight! * 0.82,
                                      padding: EdgeInsets.only(
                                        left: ConfigSize.defaultSize!,
                                        right: ConfigSize.defaultSize!,
                                      ),
                                      child: MomentComments(
                                        type: widget.type,

                                        momentCommentListModel: commentListtemp!,
                                        scrollController: scrollController,
                                      )),
                                  CommentTextField(
                                    commentController: commentController,
                                    momentId: widget.momentId.toString(),
                                  ),
                                ],
                              ),
                            );
                          }
                        } else {
                          return const CustomErrorWidget(
                              message: StringManager.noDataFoundHere);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      BlocProvider.of<GetMomentCommentBloc>(context).add(
          LoadMoreMomentCommentEvent(momentId: widget.momentId.toString()));
    } else {}
  }
}
