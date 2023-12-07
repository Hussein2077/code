import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class FixedTargetCard extends StatelessWidget {
  final String mainTitle;
  final String target;
  final double width;

  const FixedTargetCard(
      {super.key,
      required this.mainTitle,
      required this.width,
      required this.target});

  @override
  Widget build(BuildContext context) {
   // double percent =( int.parse(target)/int.parse(subTitle))*100;
    Brightness currentBrightness = Theme.of(context).brightness;
    bool isDarkTheme = currentBrightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 10,
          child: Container(
            width: width,
            decoration: BoxDecoration(
              border: isDarkTheme
                  ? Border.all(
                      style: BorderStyle.solid,
                      color: ColorManager.mainColor,
                    )
                  : null,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(
                vertical: ConfigSize.defaultSize! * 1,
                horizontal: ConfigSize.defaultSize! * 1.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$mainTitle : ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: ColorManager.mainColor),
                ),
                SizedBox(
                  height: ConfigSize.defaultSize! * 0.4,
                ),
                Text(
                  target,
                  style: const TextStyle(color: ColorManager.gray),
                ),

              ],
            ),
          ),
        ),
        // Row(
        //   children: [
        //     Text(
        //       StringManager.youHaveReached.tr(),
        //       style: Theme.of(context)
        //           .textTheme
        //           .bodyMedium,
        //     ),
        //     Text(
        //      '${percent.toString()} %',
        //       style: Theme.of(context)
        //           .textTheme
        //           .bodyMedium!
        //           .copyWith(color: ColorManager.mainColor),
        //     ),
        //   ],
        // )
      ],
    );
  }
}
