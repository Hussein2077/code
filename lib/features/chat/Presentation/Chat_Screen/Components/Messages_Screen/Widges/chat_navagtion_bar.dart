import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';

import '../../../../../../../core/utils/config_size.dart';



class ChatNavgationBar extends StatelessWidget {
  const ChatNavgationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(
          flex: 1,
        ),
        const Icon(Icons.image),
        const Spacer(
          flex:1,
        ),
        SizedBox(
          width: ConfigSize.defaultSize! * 25,
          height: ConfigSize.defaultSize! * 4,
          child: TextField(
            cursorColor: ColorManager.orang,
            decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.emoji_emotions,
                  color: ColorManager.lightGray,
                ),
                contentPadding:  EdgeInsets.symmetric(
                    vertical: ConfigSize.defaultSize!-4, horizontal: ConfigSize.defaultSize!),
                filled: true,
                fillColor: ColorManager.lightGray,
                hintText: StringManager.hinttext.tr(),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(ConfigSize.defaultSize!*5),
                    borderSide:  BorderSide(
                        width: ConfigSize.defaultSize!-4, color: Colors.transparent)),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(ConfigSize.defaultSize!*5),
                    borderSide:  BorderSide(
                        width: ConfigSize.defaultSize!-4, color: Colors.transparent)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(ConfigSize.defaultSize!*5),
                    borderSide:  BorderSide(
                        width:ConfigSize.defaultSize!-4, color: Colors.transparent))),
          ),
        ),
        const Spacer(
          flex: 1,
        ),
        const Icon(Icons.card_giftcard),
        const Spacer(
          flex: 1,
        ),
        const Icon(Icons.mic),
        const Spacer(
          flex: 1,
        )
      ],
    );
  }
}
