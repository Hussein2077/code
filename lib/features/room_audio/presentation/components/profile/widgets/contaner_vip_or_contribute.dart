import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class ContainerVipOrContribute extends StatelessWidget {
  final dynamic level;
  final String vipOrContribute;
  final String icons;
  final double? sizeOfIcon;
  final Color colors;
  final Color colorText;
  const ContainerVipOrContribute({super.key,
    required this.level,
    required this.vipOrContribute,
    required this.icons,
    required this.colors,
    required this.colorText,
    this.sizeOfIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: ConfigSize.defaultSize! * 0.4,
        horizontal: ConfigSize.defaultSize! * 0.4,
      ),

      decoration: BoxDecoration(
          color:colors,
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 1.5)),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children:  [
              Text(vipOrContribute,
                  style:  TextStyle(color: colorText,fontSize:ConfigSize.defaultSize!*1.2 )),
               Text(level,
                  style:  TextStyle(color: colorText,fontSize:ConfigSize.defaultSize!*1.2)),
            ],
          ),
          SizedBox(width: ConfigSize.defaultSize! * 0.7),
          Image.asset(icons,
              scale: sizeOfIcon ?? ConfigSize.defaultSize! * 0.35),
        ],
      ),
    );
  }
}
