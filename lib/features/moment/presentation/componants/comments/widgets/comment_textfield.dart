import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_add_moment_comment/add_moment_comment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_add_moment_comment/add_moment_comment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_moment_comment/get_moment_comment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_moment_comment/get_moment_comment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/moment_screen.dart';


class CommentTextField extends StatelessWidget{
   TextEditingController commentController ;
  final String momentId;

  CommentTextField({super.key, required this.commentController,required this.momentId});

  @override
  Widget build(BuildContext context) {
return Expanded(
  child: Row(
    mainAxisAlignment:
    MainAxisAlignment.spaceEvenly,
    children: [
      Container(
        height: ConfigSize.defaultSize! * 5,
        width: ConfigSize.defaultSize! * 35,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(
              ConfigSize.defaultSize! * 1.6),
        ),
        child: TextField(
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: null,
          controller: commentController,
          textInputAction: TextInputAction.send,
          onSubmitted: (message) {},
          cursorColor: const Color(0xffA653ff),
          cursorHeight:
          ConfigSize.defaultSize! * 3,
          cursorWidth:
          ConfigSize.defaultSize! * 0.3,
          style: Theme.of(context)
              .textTheme
              .bodyLarge,
          decoration: InputDecoration(
              fillColor: Theme.of(context)
                  .colorScheme
                  .secondary
                  .withOpacity(0.3),
              filled: true,
              hintText: StringManager.addComment,
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall,
              contentPadding: EdgeInsets.only(
                left: ConfigSize.defaultSize! * 2,
                top: ConfigSize.defaultSize! *
                    -0.5,
                right:
                ConfigSize.defaultSize! * 2,
                bottom:
                ConfigSize.defaultSize! * 1.5,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius:
                BorderRadius.circular(
                    ConfigSize.defaultSize! *
                        2),
              ),
              border: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(
                    ConfigSize.defaultSize! *
                        2),
              )),
        ),
      ),
      InkWell(
        onTap: () {
          BlocProvider.of<AddMomentCommentBloc>(
              context)
              .add(AddMomentCommentEvent(
                      momentId: momentId.toString(),
                      comment: commentController.text));
              BlocProvider.of<GetMomentCommentBloc>(context)
                  .add(GetMomentCommentEvent(
                momentId: momentId.toString(),
              ));
              commentController.clear();

            },
        child: Container(
          width: ConfigSize.defaultSize! * 5,
          height: ConfigSize.defaultSize! * 5,
          decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .secondary
                  .withOpacity(0.3),
              borderRadius: BorderRadius.circular(
                  ConfigSize.defaultSize! * 3),
              border: Border.all(
                  color: Theme.of(context)
                      .colorScheme
                      .secondary)),
          child: Icon(
            Icons.send,
            color: Theme.of(context)
                .colorScheme
                .background,
          ),
        ),
      ),
    ],
  ),
);
  }

}