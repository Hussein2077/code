import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
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
            ? const LoadingWidget()
            : Image.memory(ReelsBox.thumbnail[reelId]!,
                fit: BoxFit.fitWidth)
        : ReelsScreenState.thumbnail[reelId] == null
            ? const LoadingWidget()
            : Image.memory(ReelsScreenState.thumbnail[reelId]!,
                fit: BoxFit.fitWidth);
  }
}
