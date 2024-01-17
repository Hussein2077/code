import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/pop_up_dialog.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/view_music/view_music_screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/room_screen_controler.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/defines/media.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/uikit_service.dart';

class MusicDialog extends StatefulWidget {
  final String ownerId;

  const MusicDialog({required this.ownerId, Key? key}) : super(key: key);

  @override
  State<MusicDialog> createState() => _MusicDialogState();
}

class _MusicDialogState extends State<MusicDialog> {
  late bool isPlay;

  @override
  void initState() {
    isPlay = MusicScreen.isPlaying.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ConfigSize.defaultSize! * 2),
      child: Container(
        height: ConfigSize.defaultSize! * 16,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppPadding.p20),
        ),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ValueListenableBuilder(
                valueListenable:
                    ZegoUIKit.instance.getMediaCurrentProgressNotifier(),
                builder: (BuildContext context, dynamic value, Widget? child) {
                  return Text(
                    MusicScreen.musicesInRoom[MusicScreen.nowPlaying!].name
                        .toString(),
                    style: const TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  );
                },
              ),
              SizedBox(
                height: ConfigSize.defaultSize! * 2.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      if (ZegoUIKit.instance.getMediaTypeNotifier().value ==
                          MediaType.PureAudio) {
                        Navigator.pushNamed(context, Routes.music,
                            arguments: MusicPramiter(ownerId: ownerId));
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return PopUpDialog(
                                headerText: StringManager.youHaveToStopVideo.tr(),
                                accpetText: () {
                                  Navigator.pop(context);
                                },
                                accpettitle: StringManager.ok.tr(),
                              );
                            });
                      }
                    },
                    child: Icon(
                      Icons.library_music_outlined,
                      color: Colors.white,
                      size: ConfigSize.defaultSize! * 2,
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable:
                        ZegoUIKit.instance.getMediaVolumeNotifier(),
                    builder: (BuildContext context, int value, Widget? child) {
                      return SizedBox(
                        height: AppPadding.p10,
                        width: ConfigSize.defaultSize! * 16,
                        child: Slider(
                          autofocus: true,
                          activeColor: ColorManager.gold1,
                          min: 0,
                          max: 100,
                          value: double.parse(value.toString()),
                          onChanged: (double sound) async {
                            ZegoUIKit.instance.setMediaVolume(sound.toInt());
                          },
                        ),
                      );
                    },
                  ),

                  InkWell(
                    onTap: () async {
                      setState(() {
                        MusicScreen.repeatMusic = !MusicScreen.repeatMusic;
                      });
                    },
                    child: Icon(
                      Icons.repeat,
                      color:
                          MusicScreen.repeatMusic ? Colors.black : Colors.white,
                      size: ConfigSize.defaultSize! * 2,
                    ),
                  ),

                  SizedBox(
                    width: ConfigSize.defaultSize!,
                  ),
                  InkWell(
                      onTap: () async {
                        if ((MusicScreen.nowPlaying! - 1) > -1) {
                          MusicScreen.nowPlaying = MusicScreen.nowPlaying! - 1;
                        } else {
                          MusicScreen.nowPlaying =
                              MusicScreen.musicesInRoom.length - 1;
                        }
                        distroyMusic();
                        loadMusice(
                            path: MusicScreen
                                .musicesInRoom[MusicScreen.nowPlaying!].uri,
                            repeat: MusicScreen.repeatMusic);
                        ZegoUIKit.instance
                            .getMediaCurrentProgressNotifier()
                            .value = 0;
                        setState(() {
                          isPlay = true;
                        });
                      },
                      child: const Icon(
                        Icons.skip_previous,
                        color: Colors.white,
                      ) //player.hasPrevious ? player.seekToPrevious : null,
                      ),
                  //todo refact that like zego code
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        if (isPlay) {
                          await ZegoUIKit.instance.pauseMedia();
                          setState(() {
                            isPlay = false;
                          });
                        } else {
                          await ZegoUIKit.instance.resumeMedia();
                          setState(() {
                            isPlay = true;
                          });
                        }
                      },
                      child: isPlay
                          ? const Icon(Icons.pause, color: Colors.white)
                          : const Icon(Icons.play_arrow, color: Colors.white),
                      //player.pause,
                    ),
                  ),
                  InkWell(
                    child: const Icon(Icons.skip_next, color: Colors.white),
                    onTap: () async {


                      if (MusicScreen.nowPlaying! + 1 ==
                          MusicScreen.musicesInRoom.length) {
                        MusicScreen.nowPlaying = 0;
                      } else if (MusicScreen.nowPlaying! + 1 <
                          MusicScreen.musicesInRoom.length) {
                        MusicScreen.nowPlaying = MusicScreen.nowPlaying! + 1;
                      }
                      distroyMusic();
                      loadMusice(
                          path: MusicScreen
                              .musicesInRoom[MusicScreen.nowPlaying!].uri,
                          repeat: MusicScreen.repeatMusic);
                      ZegoUIKit.instance
                          .getMediaCurrentProgressNotifier()
                          .value = 0;
                      setState(() {
                        isPlay = true;
                      });
                    },
                  ),
                  const Spacer(
                    flex: 2,
                  )
                ],
              ),
              SizedBox(
                height: ConfigSize.defaultSize! * 2.5,
              ),
              SizedBox(
                height: AppPadding.p10,
                width: ConfigSize.defaultSize! * 32,
                child: ValueListenableBuilder(
                  valueListenable:
                      ZegoUIKit.instance.getMediaCurrentProgressNotifier(),
                  builder:
                      (BuildContext context, dynamic value, Widget? child) {
                    int max = ZegoUIKit.instance.getMediaTotalDuration();
                    if (max > 0) {
                      return Slider(
                        autofocus: true,
                        activeColor: ColorManager.gold1,
                        min: 0,
                        max: max.toDouble(),
                        value: ZegoUIKit.instance
                            .getMediaCurrentProgress()
                            .toDouble(),
                        onChanged: (double value) async {
                          ZegoUIKit.instance.seekTo(value.toInt());
                        },
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
