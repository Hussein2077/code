import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/my_videos_screen/widgets/reels_box.dart';
import 'package:tik_chat_v2/features/reels/data/models/reel_model.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class UserReelsController {

  static get getInstance => UserReelsController();
  static ValueNotifier<bool> follow = ValueNotifier<bool>(false);
  static Map<String, Uint8List> thumbnail = {};
  static Map<String, bool> likedVideos = {};
  static Map<String, int> likedVideoCount = {};
  static Map<String, bool> followingMap = {};

  void likesMap(List<ReelModel> reels,) {
    for (int i = 0; i < reels.length; i++) {
      likedVideos.putIfAbsent(reels[i].id.toString(), () => reels[i].likeExists!);
    }
  }

  void likesCountMap(List<ReelModel> reels) {
    for (int i = 0; i < reels.length; i++) {
      likedVideoCount.putIfAbsent(reels[i].id.toString(), () => reels[i].likeNum!);
    }
  }

  void changeLikeCount(String id) {
    if (likedVideos[id] == true) {
      likedVideoCount[id] = likedVideoCount[id]! + 1;
    } else {
      likedVideoCount[id] = likedVideoCount[id]! - 1;
    }
  }

  Future<Uint8List?> getVideoThumbnail(String videoUrl) async {
    final uint8list = await VideoThumbnail.thumbnailData(
      video: videoUrl,
      imageFormat: ImageFormat.JPEG,
      // maxHeight: 300,
      //     maxWidth: 300,
      quality: 70,
    );

    return uint8list;
  }

  void followMap(List<ReelModel> reels) {
    for (int i = 0; i < reels.length; i++) {
      followingMap.putIfAbsent(reels[i].userId.toString(), () => reels[i].isFollow!);
    }
  }

  void likesUserMap(List<ReelModel> reels,) {
    for (int i = 0; i < reels.length; i++) {
      ReelsBox.likedVideos.putIfAbsent(reels[i].id.toString(), () => reels[i].likeExists!);
    }
  }

  void likesCountUserMap(List<ReelModel> reels) {
    for (int i = 0; i < reels.length; i++) {
      ReelsBox.likedVideoCount.putIfAbsent(reels[i].id.toString(), () => reels[i].likeNum!);
    }
  }

  void changeLikeUserCount(String id) {
    if (ReelsBox.likedVideos[id] == true) {
      ReelsBox.likedVideoCount[id] = ReelsBox.likedVideoCount[id]! + 1;
    } else {
      ReelsBox.likedVideoCount[id] = ReelsBox.likedVideoCount[id]! - 1;
    }
  }
}
