import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class PrivacyAndServiceTextWidget extends StatelessWidget {
  const PrivacyAndServiceTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
      color: ColorManager.whiteColor.withOpacity(0.8),
      fontSize: ConfigSize.defaultSize! + 2,
    );
    TextStyle style2 = TextStyle(
      color: ColorManager.whiteColor.withOpacity(0.8),
      fontSize: ConfigSize.defaultSize! + 2,
      decoration: TextDecoration.combine([
        TextDecoration.underline, // Add an underline
        // Set the underline thickness
      ]),
      decorationColor: Colors.white, // The color of the underline
      decorationThickness: 1.0, // The thickness of the underline
    );

    return Container(
      padding: EdgeInsets.only(bottom: ConfigSize.defaultSize!),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                StringManager.bySigningOrLogin.tr(),
                style: style,
              ),
              const SizedBox(
                width: 2,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.privacyPolicyScreen);
                },
                child: Text(
                  StringManager.privacyPolicy.tr(),
                  style: style2,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                StringManager.and.tr(),
                style: style,
              ),
              const SizedBox(
                width: 2,
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  StringManager.termsOfService.tr(),
                  style: style2,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
