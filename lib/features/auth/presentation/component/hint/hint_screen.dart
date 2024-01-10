import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class HintScreen extends StatelessWidget {
  const HintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: ConfigSize.defaultSize! * 2,
          ),
          Center(
            child: Container(
              width: ConfigSize.defaultSize! * 35,
              height: ConfigSize.defaultSize! * 65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage(AssetsPath.hint),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          SizedBox(
            height: ConfigSize.defaultSize! * 2,
          ),
          Text(
            StringManager.hint.tr(),
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          SizedBox(
            height: ConfigSize.defaultSize! * 2,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.mainScreen,
                (route) => false,
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: ConfigSize.defaultSize! * 5.2),
              width: ConfigSize.defaultSize! * 15,
              height: ConfigSize.defaultSize! * 3,
              decoration: BoxDecoration(
                  gradient:
                      const LinearGradient(colors: ColorManager.mainColorList),
                  borderRadius:
                      BorderRadius.circular(ConfigSize.defaultSize! * 1.0)),
              child: Center(
                child: Text(
                  StringManager.done.tr(),
                  style: const TextStyle(
                      color: ColorManager.whiteColor,
                      fontSize: 18,
                      decoration: TextDecoration.none),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
