import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_add_moment_comment/add_moment_comment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_add_moment_comment/add_moment_comment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/widgets/moment_bottom_bar.dart';

class CommentTextField extends StatelessWidget{
   TextEditingController commentController ;
  final String momentId;

   CommentTextField({super.key, required this.commentController,required this.momentId});

  @override
  Widget build(BuildContext context) {
return Row(
  mainAxisAlignment:
  MainAxisAlignment.spaceEvenly,
  children: [
    Container(
      height: ConfigSize.defaultSize! * 5,
      width: ConfigSize.screenWidth! * .8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
            ConfigSize.defaultSize! * 1.6),
      ),
      child: TextField(

        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: null,
        controller: commentController,
        textInputAction: TextInputAction.send,
        //cursorColor: const Color(0xffA653ff),
        cursorHeight:
        ConfigSize.defaultSize! * 3,
        cursorWidth:
        ConfigSize.defaultSize! * 0.3,
        style: Theme.of(context)
            .textTheme
            .bodyLarge,
        decoration: InputDecoration(


            border: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(
                  ConfigSize.defaultSize! *
                      2),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
              borderRadius: BorderRadius.all(
                  Radius.circular(ConfigSize.defaultSize! * 5)),
            ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color:
                    Theme.of(context).colorScheme.primary,
                  ),
                  borderRadius: BorderRadius.all(
                      Radius.circular(ConfigSize.defaultSize! * 5)),
                ),
                fillColor:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                filled: true,
                hintText: StringManager.addComment.tr(),
                hintStyle: Theme.of(context).textTheme.bodySmall,
                contentPadding: EdgeInsets.only(
                  left: ConfigSize.defaultSize! * 2,
              top: ConfigSize.defaultSize! *
                  -0.5,
              right:
              ConfigSize.defaultSize! * 2,
              bottom:
              ConfigSize.defaultSize! * 1.5,
            ),


        ),
      ),
    ),
    InkWell(
      onTap: () {
            MomentBottomBarState.selectedMoment = int.parse(momentId);
            BlocProvider.of<AddMomentCommentBloc>(context).add(
                AddMomentCommentEvent(
                    momentId: momentId.toString(),
                    comment: commentController.text));
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
                    .primary)),
        child: Icon(
          Icons.send,
          color: Theme.of(context)
              .colorScheme
              .primary,
        ),
      ),
    ),
  ],
);
  }

}