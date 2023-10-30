import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/aristocracy_level.dart';
import 'package:tik_chat_v2/core/widgets/gredin_text_vip.dart';
import 'package:tik_chat_v2/core/widgets/level_continer.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';

class MomentInfoRow extends StatelessWidget {
  final MomentModel momentModel;

  const MomentInfoRow({required this.momentModel, super.key});

  @override
  Widget build(BuildContext context) {
    log('kkkk${momentModel.frameId}');
    log('kkkk${momentModel.frame}');

    return InkWell(
      onTap: () {
        Methods.instance.userProfileNvgator(
            context: context, userId: momentModel.userId.toString());
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
                  image: momentModel.userImage,
                  frame: momentModel.frame,
                  frameId: momentModel.frameId,
                ),
                const Spacer(
                  flex: 1,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: ConfigSize.defaultSize! * 0.5,
                        ),
                        GradientTextVip(
                          text: momentModel.userName,
                          textStyle: Theme.of(context).textTheme.bodyLarge!,
                          isVip: momentModel.hasColorName,
                        ),
                        SizedBox(
                          width: ConfigSize.defaultSize! * 0.5,
                        ),
                        Text(
                          Methods.instance.formatDateTime(
                              dateTime: momentModel.creeatedTime,
                              locale: context.locale.languageCode),
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                  fontSize: ConfigSize.defaultSize! ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        LevelContainer(
                          width: ConfigSize.defaultSize! * 5,
                          height: ConfigSize.defaultSize! * 5,
                          image: momentModel.senderImage,
                        ),
                        AristocracyLevel(
                          level: momentModel.vip,
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(
                  flex: 5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
