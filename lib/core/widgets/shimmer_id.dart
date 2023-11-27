import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class ShimmerId extends StatelessWidget {
  final TextStyle? style;
  final String id;

  const ShimmerId({super.key,
    this.style,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: ConfigSize.defaultSize!*10.8,
      height: ConfigSize.defaultSize!*2.8,
      child: Stack(
        alignment: Alignment.center,
        children: [

          Shimmer(
            gradient: const LinearGradient(colors: ColorManager.goldList),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: ConfigSize.defaultSize! * 0.8,
              ),
              decoration:  BoxDecoration(

               borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 1),
                gradient:   const LinearGradient(colors: ColorManager.goldList),

              ),
            ),
          ),
          Text(
            'ID: $id',
            style: style ?? TextStyle(
                color: Colors.white
            ),
          ),
        ],
      ),
    );
  }
}
