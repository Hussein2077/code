import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/gredin_text_vip.dart';
import 'package:tik_chat_v2/core/widgets/see_more_text.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_comment_model.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_delete_comment/delete_moment_comment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_delete_comment/delete_moment_comment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_moment_comment/get_moment_comment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_moment_comment/get_moment_comment_event.dart';


class MomentComments extends StatefulWidget {
  final String? type;
  final List<MomentCommentModel> momentCommentListModel;
  final ScrollController scrollController;

  const MomentComments(
      {required this.momentCommentListModel,
      required this.scrollController,
      this.type,
  super.key});

@override
State<MomentComments> createState() => _MomentCommentsState();
}

class _MomentCommentsState extends State<MomentComments> {
  @override
  Widget build(BuildContext context) {
    return
      ListView.builder(
        controller: widget.scrollController,
        itemCount: widget.momentCommentListModel.length,
        itemBuilder: (context, i) {
          return Container(
            // height: ConfigSize.screenHeight! * 0.14,
            margin: EdgeInsets.symmetric(
                vertical: ConfigSize.defaultSize!,
                horizontal: ConfigSize.defaultSize! * 2),
            padding: EdgeInsets.symmetric(
                vertical: ConfigSize.defaultSize!,
                horizontal: ConfigSize.defaultSize! * 2),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(
                      flex: 1,
                    ),
                    InkWell(
                      onTap: () {
                        Methods.instance.userProfileNvgator(
                            context: context,
                            userId: widget.momentCommentListModel[i].userId.toString());
                      },
                      child: UserImage(
                        boxFit: BoxFit.cover,
                        image: (widget.momentCommentListModel[i].userProfilePic),
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: ConfigSize.defaultSize! * 20,
                          child: GradientTextVip(
                            text: (widget.momentCommentListModel[i].userName),
                            textStyle: Theme
                                .of(context)
                                .textTheme
                                .headlineMedium!.copyWith(
                                fontWeight: FontWeight.w500
                            ),
                            isVip: false,
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              child: Text(
                                (widget.momentCommentListModel[i].commentTime
                                    .substring(11, 16)),


                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodySmall!,

                                //comment==true? momentCommentModel.userProfilePic:momentLikeModel.userImage!,
                              ),
                            ),
                            SizedBox(width: ConfigSize.defaultSize! * .5,),
                            SizedBox(
                              child: Text(
                               (widget.momentCommentListModel[i].commentTime
                                    .substring(0, 10)),


                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodySmall!,

                                //comment==true? momentCommentModel.userProfilePic:momentLikeModel.userImage!,
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                    const Spacer(
                      flex: 5,
                    ),
                    if (widget.momentCommentListModel[i].userId==MyDataModel.getInstance().id||widget.type=='mine')
                      SizedBox(
                        width: ConfigSize.defaultSize! * 4,
                        height: ConfigSize.defaultSize! * 4,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            customButton: Icon(
                              Icons.more_vert_rounded,
                              size: ConfigSize.defaultSize! * 2.5,
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .primary,
                            ),
                            dropdownDecoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(
                                  ConfigSize.defaultSize!),
                              border: Border.all(color: Colors.white,),

                            ),

                            items: [
                              ...MenuItems.firstItems.map(
                                    (item) =>
                                    DropdownMenuItem<MenuItem>(
                                      value: item,
                                      child: MenuItems.buildItem(item),
                                    ),
                              ),
                            ],
                            onChanged: (value) {
                              MenuItems.onChanged(context, value!,
                                  widget.momentCommentListModel[i].momentId.toString(),
                                  widget.momentCommentListModel[i].commentId!
                              );
                            },
                            dropdownWidth: ConfigSize.defaultSize! * 12,

                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: ConfigSize.defaultSize! * 0.5,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      InkWell(
                        onLongPress: () {
                          Clipboard.setData(ClipboardData(
                            text:                             widget.momentCommentListModel[i].comment,

                          ));
                          sucssesToast(
                              context: context,
                              title: StringManager.copiedToClipboard.tr());
                        },

                        child: ExpandableText(
                          widget.momentCommentListModel[i].comment,
                          trimLines: 1,
                          style:
                            Theme
                                .of(context)
                                .textTheme
                                .bodyLarge!.copyWith(
                                fontSize: ConfigSize.defaultSize!*1.6

                            ),
                        ),
                      ),


                    ],
                  ),
                ),


              ],
            ),
          );
        },
      )
    ;
  }
}

class MenuItem {
  const MenuItem({
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;
}

abstract class MenuItems {
  static List<MenuItem> firstItems = [delete,];


  static final delete = MenuItem(
      text: StringManager.delete.tr(), icon: Icons.delete_forever);



  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.red.withOpacity(0.8), size: 22),
        SizedBox(
          width: ConfigSize.defaultSize!,
        ),
        Expanded(
          child: Text(
            item.text,
            style: TextStyle(
              color: Colors.red.withOpacity(0.8),
            ),
          ),
        ),
      ],
    );
  }

  static void onChanged(BuildContext context, MenuItem item, String momentId,int commentId) {
    BlocProvider.of<DeleteMomentCommentBloc>(context).add(DeleteMomentCommentEvent(
            momentId: momentId, commentId: commentId.toString()));
    BlocProvider.of<GetMomentCommentBloc>(context).add(LocalDeleteCommentEvent(
        momentId: momentId, commentId: commentId.toString()));
  }
}