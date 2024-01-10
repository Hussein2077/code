import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/view_music/view_music_screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/room_screen_controler.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/uikit_service.dart';

class MusicDialog extends StatefulWidget {
  final String ownerId;

  const MusicDialog({required this.ownerId, Key? key}) : super(key: key);

  @override
  State<MusicDialog> createState() => _MusicDialogState();
}

class _MusicDialogState extends State<MusicDialog> {
  late bool isPlay;
  late bool repeat = false;

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
                      Navigator.pushNamed(context, Routes.music,
                          arguments: MusicPramiter(ownerId: widget.ownerId));
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
                          onChanged: (double value) async {
                            ZegoUIKit.instance.setMediaVolume(value.toInt());
                          },
                        ),
                      );
                    },
                  ),

                  InkWell(
                    onTap: () async {
                      setState(() {
                        repeat = !repeat;
                      });
                    },
                    child: Icon(
                      Icons.repeat,
                      color: repeat ? Colors.black : Colors.white,
                      size: ConfigSize.defaultSize! * 2,
                    ),
                  ),

                  SizedBox(
                    width: ConfigSize.defaultSize!,
                  ),

                  InkWell(
                    onTap: () async {
                      if ((MusicScreen.nowPlaying! - 1) > -1) {
                        distroyMusic();
                        MusicScreen.nowPlaying = MusicScreen.nowPlaying! - 1;
                        loadMusice(
                            path: MusicScreen
                                .musicesInRoom[MusicScreen.nowPlaying!].uri,
                            repeat: repeat);
                      } else {
                        distroyMusic();
                        MusicScreen.nowPlaying =
                            MusicScreen.musicesInRoom.length - 1;
                        loadMusice(
                            path: MusicScreen
                                .musicesInRoom[MusicScreen.nowPlaying!].uri,
                            repeat: repeat);
                      }
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
                    ),
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
                    ),
                  ),
                  InkWell(
                    child: const Icon(Icons.skip_next, color: Colors.white),
                    onTap: () async {
                      if ((MusicScreen.nowPlaying! + 1) >=
                          MusicScreen.musicesInRoom.length) {
                        distroyMusic();
                        MusicScreen.nowPlaying = 0;
                        loadMusice(
                            path: MusicScreen
                                .musicesInRoom[MusicScreen.nowPlaying!].uri,
                            repeat: repeat);
                      } else {
                        distroyMusic();
                        MusicScreen.nowPlaying = MusicScreen.nowPlaying! + 1;
                        loadMusice(
                            path: MusicScreen
                                .musicesInRoom[MusicScreen.nowPlaying!].uri,
                            repeat: repeat);
                      }
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
                    return Slider(
                      autofocus: true,
                      activeColor: ColorManager.gold1,
                      min: 0,
                      max:
                          ZegoUIKit.instance.getMediaTotalDuration().toDouble(),
                      value: ZegoUIKit.instance
                          .getMediaCurrentProgress()
                          .toDouble(),
                      onChanged: (double value) async {
                        ZegoUIKit.instance.seekTo(value.toInt());
                      },
                    );
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
