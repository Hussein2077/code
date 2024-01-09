import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';

import '../../../../core/utils/config_size.dart';

class MyProfilPropertyRow extends StatelessWidget {
  final String iconPath;
  final String title;
  final Function() onTap;
  final int index;
  final bool? showIcon;

  const MyProfilPropertyRow(
      {super.key,
      required this.iconPath,
      required this.title,
      required this.onTap,
      this.showIcon, required this.index,
      });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: SizedBox(
           width: ConfigSize.screenWidth!-ConfigSize.defaultSize!*28,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              index==2?const Icon(Icons.notifications_active_rounded,color:ColorManager.whiteColor,):
              Image.asset(iconPath,
                  color: iconPath == AssetsPath.groupChat
                      ? ColorManager.darkPink
                      : null,
                  scale: ConfigSize.defaultSize! * 0.5),
              SizedBox(
                width: ConfigSize.defaultSize,
              ),
              SizedBox(

                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontSize: ConfigSize.defaultSize! * 1.25,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(
                width: ConfigSize.defaultSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
