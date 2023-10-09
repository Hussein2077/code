import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class ContainerWithdrawal extends StatelessWidget {
  final String usd;
  final Widget? icon;
  final String? title ; 
  const ContainerWithdrawal({
    this.title,
    this.icon,
    super.key,
    required this.usd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 1.5),
          gradient: const LinearGradient(colors: ColorManager.mainColorList)),
      padding: EdgeInsets.all(ConfigSize.defaultSize! * 1.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Column(
          //   children: [
          //     Text( StringManager.diamond,
          //       style:Theme.of(context).textTheme.bodyLarge,),

          //     SizedBox(
          //       height: ConfigSize.defaultSize!*2.0,
          //     ),
          //     Row(
          //       children: [
          //         Image.asset(AssetsPath.gemStone,
          //             scale: 2.0),
          //         const SizedBox(
          //           width: 20,
          //         ),
          //         Text( usd,
          //           style:Theme.of(context).textTheme.bodyLarge,),
          //       ],
          //     )
          //   ],
          // ),
          // VerticalDivider(
          //   width: 2,
          //   thickness: 3,
          //   indent: 15,
          //   endIndent: 15,
          //   color:
          //   const Color(0xffA3A4A3).withOpacity(0.72),
          // ),
          SizedBox(
            width: ConfigSize.defaultSize! * 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "${title??StringManager.dolars.tr()} : $usd",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(
                  height: ConfigSize.defaultSize! * 1.0,
                ),
                icon == null
                    ? Row(
                        children: [
                          Image.asset(AssetsPath.circleDollar, scale: 1.0),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      )
                    : icon!
              ],
            ),
          ),
        ],
      ),
    );
  }
}
