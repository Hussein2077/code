import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class TeamBlue extends StatelessWidget {
  const TeamBlue({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 25.h, right: 0.w, left: 25.w, bottom: 15.h),
        child: Container(
          width: ConfigSize.defaultSize! * 7.1,
          height: ConfigSize.defaultSize! * 7.1,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    AssetsPath.team2,
                  ))),
        ),
    );
  }
}
