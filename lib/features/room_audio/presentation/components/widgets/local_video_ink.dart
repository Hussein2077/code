import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/defines/media.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/uikit_service.dart';
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/pop_up_dialog.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';

class LocalVideoInkwell extends StatelessWidget {
  const LocalVideoInkwell({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        log('${ZegoUIKit.instance.getMediaTypeNotifier().value}ZegoUIKit.instance.getMediaTypeNotifier().value');
        log('${ZegoUIKit.instance.getMediaPlayStateNotifier().value} ZegoUIKit.instance.getMediaPlayStateNotifier()');
        if (ZegoUIKit.instance.getMediaTypeNotifier().value !=
            MediaType.PureAudio) {
          ZegoUIKit.instance.getMediaTypeNotifier().value=MediaType.Video;
          // RoomScreen.localVideoModeShow.value = true;
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (context) {
                return PopUpDialog(
                  headerText: StringManager.youHaveToStopMedia.tr(),
                  accpetText: () {
                    Navigator.pop(context);
                  },
                  accpettitle: StringManager.ok.tr(),
                );
              });
        }
      },
      child: Column(
        children: [
          Image.asset(
            AssetsPath.videoNewIcon,
            width: ConfigSize.defaultSize! * 5,
            height: ConfigSize.defaultSize! * 5,
          ),
          Text(StringManager.video.tr(),
              style: TextStyle(
                  fontSize: ConfigSize.defaultSize! + 2,
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600))
        ],
      ),
    );
  }
}
