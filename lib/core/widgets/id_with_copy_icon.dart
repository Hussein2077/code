// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/shimmer_id.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';

class IdWithCopyIcon extends StatefulWidget {
  var userData;
  Color? color;
  IdWithCopyIcon({required this.userData,this.color, super.key});

  @override
  State<IdWithCopyIcon> createState() => _IdWithCopyIconState();
}

class _IdWithCopyIconState extends State<IdWithCopyIcon> {
  @override
  Widget build(BuildContext context) {
    Brightness currentBrightness = Theme.of(context).brightness;

    bool isDarkTheme = currentBrightness == Brightness.dark;
    return InkWell(
      onTap: () {
        Clipboard.setData(ClipboardData(text: widget.userData.uuid.toString()));
        sucssesToast(
            context: context, title: StringManager.theTextHasBeenCopied.tr());
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.userData.isGold!
              ? ShimmerId(
                  id: widget.userData.uuid.toString(),
                  style: TextStyle(

                    color: Colors.black,

                    fontSize: ConfigSize.defaultSize! * 1.6,
                  ),
                )
              : Text(
                  'ID: ${widget.userData.uuid.toString()}',
                  style: TextStyle(
                    color: isDarkTheme?widget.color?? Colors.white: widget.color??Colors.black,
                    fontSize: ConfigSize.defaultSize! * 1.9,
                  ),
                ),
          SizedBox(
            width: ConfigSize.defaultSize,
          ),
          Icon(
            Icons.copy,
            size: ConfigSize.defaultSize! * 1.8,
            color: widget.userData.isGold!
                ? ColorManager.shimmerGold1
                : ColorManager.orang,
          )
        ],
      ),
    );
  }
}
