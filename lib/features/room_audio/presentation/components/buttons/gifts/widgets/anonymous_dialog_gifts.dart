import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class AnonymounsDialogGifts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background.withOpacity(0.5),
          border: Border.all(color: ColorManager.mainColor),
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 2),
        ),
        padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize! * 2),
        height: ConfigSize.screenHeight! * 0.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: ConfigSize.defaultSize! * 2,
            ),
            Text(
              StringManager.cantSendGift.tr(),
              style: Theme.of(context).textTheme.headlineMedium,
              overflow: TextOverflow.fade,
            ),
            const Divider(
              color: ColorManager.mainColor,
            ),
            InkWell(
              child: Text(StringManager.ok.tr()),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
