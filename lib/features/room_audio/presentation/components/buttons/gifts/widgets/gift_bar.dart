import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';


class GiftBar extends StatelessWidget {
  const GiftBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius:  BorderRadius.only(
            topLeft: Radius.circular(ConfigSize.defaultSize!),
            topRight: Radius.circular(ConfigSize.defaultSize!)),
        color: Colors.black.withOpacity(0.4),
      ),
      width: ConfigSize.screenWidth,
        child: Row(children:  [
         const  Expanded(
            flex: 1,
            child: Icon(
              Icons.circle,
              color: ColorManager.deepPurble,
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              StringManager.giftbar.tr(),
              style: const  TextStyle(color: ColorManager.gold),
            ),
          ),
        ]),
    );
  }
}
