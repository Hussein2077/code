import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/tik_tok_animition.dart';

class WaitingDialog extends StatefulWidget {
  const WaitingDialog({super.key});

  @override
  State<WaitingDialog> createState() => _WaitingDialogState();
}

class _WaitingDialogState extends State<WaitingDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ConfigSize.defaultSize!),
      ),
      child: Container(
        height: ConfigSize.defaultSize! * 20,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: ColorManager.bageGriedinet),
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize!),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(vertical: ConfigSize.defaultSize!),
                child: Text(
                  StringManager.waitForUsersResponse.tr(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: ConfigSize.defaultSize! * 1.7,
                      overflow: TextOverflow.fade),
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize! * 14),
              child: SizedBox(
                  height: ConfigSize.defaultSize!*3,
                  child: const TikTokLoadingAnimation(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
