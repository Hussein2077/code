import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';

import '../../../../core/utils/config_size.dart';

class MyProfilPropertyRow extends StatelessWidget {
  final String iconPath;
  final String title;
  final String? descriptiontitle;
  final Function() onTap;
  final bool? showIcon;

  const MyProfilPropertyRow(
      {super.key,
      required this.iconPath,
      required this.title,
      required this.onTap,
      this.showIcon,
      this.descriptiontitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: ConfigSize.screenWidth! /3.1,
          // margin: EdgeInsets.symmetric(vertical: ConfigSize.defaultSize! * 0.5),
          padding: EdgeInsets.symmetric(

              vertical: ConfigSize.defaultSize! * 0.2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 2),
            // image: const DecorationImage(
            //     image: AssetImage(AssetsPath.backGroundRow),
            //     fit: BoxFit.fitWidth),
          ),
          child: InkWell(
            onTap: onTap,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(iconPath,
                      color: iconPath == AssetsPath.groupChat
                          ? ColorManager.darkPink
                          : null,
                      scale: ConfigSize.defaultSize! * 0.5),
                  const Spacer(
                    flex: 1,
                  ),
                  SizedBox(
                    width: ConfigSize.defaultSize!*6.8,
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(fontSize: ConfigSize.defaultSize! * 1.2),
                    ),
                  ),

                  Spacer(
                    flex: (descriptiontitle != null) ? 2 : 10,
                  ),
                  SizedBox(
                    width: ConfigSize.defaultSize! * 2.5,
                    height: ConfigSize.defaultSize! * 2.5,
                    child: showIcon == null
                        ? const Icon(Icons.arrow_forward_ios)
                        : null,
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (descriptiontitle != null)
          Text(
            descriptiontitle!,
            style: TextStyle(
                fontSize: ConfigSize.defaultSize! * 1,
                color: ColorManager.whiteColor),
          ),
      ],
    );
  }
}
