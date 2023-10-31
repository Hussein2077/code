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
    return Shimmer.fromColors(
      baseColor: ColorManager.shimmerGold1.withOpacity(0.9),
      highlightColor: ColorManager.whiteColor.withOpacity(0.5),
      child: Text(
        'ID: $id',
        style: style ?? Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}
