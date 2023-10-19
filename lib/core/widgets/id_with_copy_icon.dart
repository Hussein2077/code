// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';

class IdWithCopyIcon extends StatelessWidget {

  var userData;
  IdWithCopyIcon({required this.userData, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Clipboard.setData(ClipboardData(text: userData.uuid.toString()));
        sucssesToast(context: context, title: StringManager.theTextHasBeenCopied.tr()
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('ID: ${userData.uuid.toString()}',
              style: TextStyle(
                  color: userData.isGold! ? ColorManager.gold : ColorManager.orang,
                  fontSize: ConfigSize.defaultSize! * 1.7)),
          SizedBox(
            width: ConfigSize.defaultSize,
          ),
          Icon(
            Icons.copy,
            size: ConfigSize.defaultSize! * 1.8,
            color: ColorManager.orang,
          )
        ],
      ),
    );
  }
}
