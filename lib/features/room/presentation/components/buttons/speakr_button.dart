
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/uikit_service.dart';




class SpeakerButton extends StatefulWidget {
  SpeakerButton({super.key});
  @override
  State<SpeakerButton> createState() => _SpeakerButtonState();
}


class _SpeakerButtonState extends State<SpeakerButton> {
  bool mute = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: (() {

          if(mute){
            ZegoUIKit().startPlayAllAudioVideo() ;
          }else{
            ZegoUIKit().stopPlayAllAudioVideo();
          }

          setState(() {
            mute = !mute;
          });
        }),
        child: mute
              ? Image.asset(AssetsPath.muteLocal,width:  AppPadding.p40,height: AppPadding.p40)
              : Image.asset(AssetsPath.soundLocal,width:  AppPadding.p40,height: AppPadding.p40),
        );
  }


}
