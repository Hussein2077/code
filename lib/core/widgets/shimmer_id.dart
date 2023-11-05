import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';

class ShimmerId extends StatelessWidget {
  final TextStyle? style;
  final String id;

  const ShimmerId({super.key,
    this.style,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    Brightness currentBrightness = Theme.of(context).brightness;
    bool isDarkTheme = currentBrightness == Brightness.dark;
    return Shimmer.fromColors(
      period: const Duration(seconds:7 ),
      baseColor: ColorManager.shimmerGold1.withOpacity(0.9),
      highlightColor: isDarkTheme?ColorManager.darkBlack.withOpacity(0.5):ColorManager.whiteColor.withOpacity(0.5),
      child: Text(
        'ID: $id',
        style: style ?? Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}
