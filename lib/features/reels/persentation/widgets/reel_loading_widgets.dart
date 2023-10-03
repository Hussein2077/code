import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/my_videos_screen/widgets/reels_box.dart';
import 'package:tik_chat_v2/features/reels/persentation/reels_screen.dart';

class ReelLodaingWidget extends StatelessWidget {
  final bool userView;
  final String reelId;
  const ReelLodaingWidget(
      {required this.reelId, required this.userView, super.key});

  @override
  Widget build(BuildContext context) {
    
    return userView
        ? ReelsBox.thumbnail[reelId] == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  SizedBox(height: ConfigSize.defaultSize!),
                  Text(StringManager.loading.tr())
                ],
              )
            : Image.memory(ReelsBox.thumbnail[reelId]!,
                fit: BoxFit.fitWidth)
        : ReelsScreenState.thumbnail[reelId] == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  SizedBox(height: ConfigSize.defaultSize!),
                  Text(StringManager.loading.tr())
                ],
              )
            : Image.memory(ReelsScreenState.thumbnail[reelId]!,
                fit: BoxFit.fitWidth);
  }
}
