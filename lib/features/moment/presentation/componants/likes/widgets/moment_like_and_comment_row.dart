import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/gredin_text_vip.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_comment_model.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_like_model.dart';


class MomentLikeAndCommentRow extends StatelessWidget {
  final MomentCommentModel? momentCommentModel;
  final MomentLikeModel? momentLikeModel;
  final bool? comment;

  final void Function()? onTap;

  const MomentLikeAndCommentRow(
      {this.onTap,
       this.momentCommentModel,
       this.momentLikeModel,
      required this.comment,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ??
          () {
            Methods().userProfileNvgator(
                context: context,
                userId: comment == true
                    ? momentCommentModel?.userId.toString()
                    : momentLikeModel!.userName.toString());
          },
      child: Container(
        width: ConfigSize.screenWidth,
        height: ConfigSize.defaultSize! * 3,
        padding:
            EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize! * 0.5),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 1,
                ),
                UserImage(
                  boxFit: BoxFit.cover,
                  image:
                  (comment==true? momentCommentModel?.userProfilePic:momentLikeModel?.userImage) ??''
                  ,
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
                        text:
                     (   comment==true? momentCommentModel?.userName:momentLikeModel?.userName)??''
                        ,
                        textStyle: Theme.of(context).textTheme.bodyLarge!,
                        isVip:false,
                        //comment==true? momentCommentModel.userProfilePic:momentLikeModel.userImage!,
                      ),
                    ),
                    SizedBox(
                      width: ConfigSize.defaultSize! * 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          Text(
                            "ID ${
                                (comment==true? momentCommentModel?.userId.toString():momentLikeModel?.userId.toString())??''}",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontSize: ConfigSize.defaultSize! * 1.1),
                          ),
                        ],
                      ),
                    ),
                    comment == true
                        ? Column(
                            children: [
                              SizedBox(
                                height: ConfigSize.defaultSize! * 1.2,
                              ),
                              Text(
                                momentCommentModel?.comment??'',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ],
                ),
                const Spacer(
                  flex: 5,
                ),
              ],
            ),
            Divider(
              indent: ConfigSize.defaultSize! * 8,
              endIndent: 50,
              thickness: 1,
              height: ConfigSize.defaultSize! * 2,
              color: ColorManager.gray,
            ),
          ],
        ),
      ),
    );
  }
}
