import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class FreeOrPaidButton extends StatelessWidget {
  const FreeOrPaidButton({super.key, this.onPressed, required this.text});

  final void Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: onPressed,
        child: Container(
          height: ConfigSize.defaultSize! * 4,
          width: ConfigSize.defaultSize! * 15,
          decoration: BoxDecoration(
              gradient: const LinearGradient(colors: ColorManager.goldList),
              borderRadius: BorderRadius.circular(ConfigSize.defaultSize!)),
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: ColorManager.whiteColor, fontWeight: FontWeight.w700),
            ),
          ),
        ));
  }
}
