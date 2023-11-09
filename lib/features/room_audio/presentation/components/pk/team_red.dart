
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class TeamRed extends StatelessWidget {
  const TeamRed({super.key});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 35.h, left: 25.w),
      child: Container(
        width: ConfigSize.defaultSize! * 8.2,
        height: ConfigSize.defaultSize! * 8.2,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  AssetsPath.team1,
                ))),
      ),
    );
  }
}
