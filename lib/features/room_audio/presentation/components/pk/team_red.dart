
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class TeamRed extends StatelessWidget {
  const TeamRed({super.key});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ConfigSize.defaultSize! * 2.0, left: ConfigSize.defaultSize! * 1.2),
      child: Container(
        width: ConfigSize.defaultSize! * 7.1,
        height: ConfigSize.defaultSize! * 7.1,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  AssetsPath.team1,
                ))),
      ),
    );
  }
}
