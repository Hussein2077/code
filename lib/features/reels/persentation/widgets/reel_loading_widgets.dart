

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/my_videos_screen/widgets/reels_box.dart';
import 'package:tik_chat_v2/features/reels/persentation/reels_controller.dart';

class ReelLodaingWidget extends StatelessWidget {
  //final bool userView;
  final String reelId;
  final FileInfo? image ;
  const  ReelLodaingWidget(
      {  this.image  ,  required this.reelId,
       // required this.userView,
        super.key});

  @override
  Widget build(BuildContext context) {

    return
      // userView
      //   ? image!=null?Image.file(image!.file , fit: BoxFit.fitWidth,): ReelsBox.thumbnail[reelId] == null
      //       ? const LoadingWidget()
      //       : Image.memory(ReelsBox.thumbnail[reelId]!,
      //           fit: BoxFit.fitWidth)
      //   :
    image!=null?Image.file(image!.file , fit: BoxFit.fitWidth,):  ReelsController.thumbnail[reelId] == null
            ? const LoadingWidget()
            : Image.memory(ReelsController.thumbnail[reelId]!,
                fit: BoxFit.fitWidth);
  }
}
