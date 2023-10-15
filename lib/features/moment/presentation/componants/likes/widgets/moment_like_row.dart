import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/gredin_text_vip.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_like_model.dart';


class MomentLikes extends StatelessWidget {
  final ScrollController scrollController;

  final List<MomentLikeModel> momentLikeModelList;

  const MomentLikes(
      {required this.momentLikeModelList,
      required this.scrollController,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: momentLikeModelList.length,
      itemBuilder: (context, i) {
        return InkWell(
          onTap: () {
            Methods().userProfileNvgator(
                context: context,
                userId: momentLikeModelList[i].userId.toString());
          },
          child: Container(
            width: ConfigSize.screenWidth,
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
                      image: momentLikeModelList[i].userImage ?? '',
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
                            text: (momentLikeModelList[i].userName) ?? '',
                            textStyle: Theme.of(context).textTheme.bodyLarge!,
                            isVip: false,
                          ),
                        ),
                        SizedBox(
                          width: ConfigSize.defaultSize! * 20,
                          child: Text(
                            "ID ${momentLikeModelList[i].uuId.toString()}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontSize: ConfigSize.defaultSize! * 1.1),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(
                      flex: 5,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: ConfigSize.defaultSize! * 2,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const Spacer(
                      flex: 2,
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
      },
    );
  }
}
