import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/zego_uikit_prebuilt_live_audio_room.dart';

class TeamBlue extends StatelessWidget {
  const TeamBlue({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 25.zH, right: 0.zW, left: 25.zW, ),
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
