import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'mian_button.dart';

class WarningDialog extends StatelessWidget {
  final BuildContext buildContext;
  final String text;

  const WarningDialog({
    Key? key,
    required this.buildContext,
    required this.text,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Dialog(
      //   insetAnimationDuration: const Duration(microseconds: 500),
      // insetAnimationCurve : Curves.bounceInOut,
      insetPadding:
          EdgeInsets.symmetric(horizontal: ConfigSize.screenWidth! * 0.06),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 2),
      ),
      child: Container(
          height: ConfigSize.screenHeight! * 0.25,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 2)),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.all(ConfigSize.defaultSize! * 2.0),
            child: Column(
              children: [
                Text(
                  StringManager.advice.tr(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(
                  height: ConfigSize.screenHeight! * 0.03,
                ),
                Text(
                  text,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(
                  height: ConfigSize.screenHeight! * 0.03,
                ),

                MainButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  title: StringManager.ok.tr(),
                  width: ConfigSize.screenWidth! * 0.5,
                ),
              ],

            ),
          )),
    );
  }



}
