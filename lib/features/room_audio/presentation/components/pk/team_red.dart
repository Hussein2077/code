import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/zego_uikit_prebuilt_live_audio_room.dart';

class TeamRed extends StatelessWidget {
  const TeamRed({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
        width: ConfigSize.defaultSize! * 15,
        height: ConfigSize.defaultSize! * 15,
        margin: EdgeInsets.only(top: 20.zH, left:10.zW),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  AssetsPath.team1,
                ),
            fit: BoxFit.contain
            ),

        ),
      );
  }
}
