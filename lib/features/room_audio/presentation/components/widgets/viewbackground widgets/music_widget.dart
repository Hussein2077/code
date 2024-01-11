// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'package:awesome_ripple_animation/awesome_ripple_animation.dart';
import 'package:draggable_float_widget/draggable_float_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/view_music/dialog_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/view_music/view_music_screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/room_screen_controler.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/defines/media.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/uikit_service.dart';

class MusicWidget extends StatelessWidget {
  EnterRoomModel room;
  AnimationController controllerMusice;
  static bool isIPlayerMedia = false;
  MusicWidget({super.key, required this.room, required this.controllerMusice});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<MediaPlayState>(
        valueListenable: ZegoUIKit.instance.getMediaPlayStateNotifier(),
        builder: (context, state, _) {
          log('state:${state.toString()}');
          switch (state) {
            case MediaPlayState.NoPlay:
              return const SizedBox();
            case MediaPlayState.Playing:
            case MediaPlayState.Pausing:
              return MusicWidget.isIPlayerMedia
                  ? DraggableFloatWidget(
                      config: DraggableFloatWidgetBaseConfig(
                        initPositionYInTop: false,
                        initPositionYMarginBorder:
                            ConfigSize.screenHeight! - 300,
                        borderTopContainTopBar: true,
                        borderBottom: 30,
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                  backgroundColor: ColorManager.mainColor,
                                  child: MusicDialog(
                                    ownerId: room.ownerId.toString(),
                                  ));
                            });
                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: RippleAnimation(
                                repeat: true,
                                color: ColorManager.mainColor,
                                minRadius: 30,
                                ripplesCount: 6,
                                child: RotationTransition(
                                    turns: controllerMusice,
                                    child: Container(
                                        height: ConfigSize.defaultSize! * 7,
                                        width: ConfigSize.defaultSize! * 7,
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.circular(
                                                ConfigSize.defaultSize! * 7),
                                            image: const DecorationImage(
                                                fit: BoxFit.fitWidth,
                                                image: AssetImage(
                                                    AssetsPath.music)))))),
                          ),
                          GestureDetector(
                            onTap: () {
                              distroyMusic();
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color:
                                        ColorManager.mainColor.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20)),
                                padding: const EdgeInsets.all(4),
                                child: Icon(
                                  CupertinoIcons.clear,
                                  color: Colors.white,
                                  size: AppPadding.p14,
                                )),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox();
            case MediaPlayState.PlayEnded:
              if (MusicWidget.isIPlayerMedia) {
                if ((MusicScreen.nowPlaying! + 1) >=
                    MusicScreen.musicesInRoom.length) {
                  distroyMusic();
                  MusicScreen.nowPlaying = 0;
                  loadMusice(
                      path: MusicScreen
                          .musicesInRoom[MusicScreen.nowPlaying!].uri,
                      repeat: false);
                  ZegoUIKit.instance.getMediaCurrentProgressNotifier().value =
                      0;
                } else {
                  distroyMusic();
                  MusicScreen.nowPlaying = MusicScreen.nowPlaying! + 1;
                  loadMusice(
                      path: MusicScreen
                          .musicesInRoom[MusicScreen.nowPlaying!].uri,
                      repeat: false);
                  ZegoUIKit.instance.getMediaCurrentProgressNotifier().value =
                      0;
                }
              }
              return MusicWidget.isIPlayerMedia
                  ? DraggableFloatWidget(
                      config: DraggableFloatWidgetBaseConfig(
                        initPositionYInTop: false,
                        initPositionYMarginBorder:
                            ConfigSize.screenHeight! - 300,
                        borderTopContainTopBar: true,
                        borderBottom: 30,
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                  backgroundColor: ColorManager.mainColor,
                                  child: MusicDialog(
                                    ownerId: room.ownerId.toString(),
                                  ));
                            });
                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: RippleAnimation(
                                repeat: true,
                                color: ColorManager.mainColor,
                                minRadius: 30,
                                ripplesCount: 6,
                                child: RotationTransition(
                                    turns: controllerMusice,
                                    child: Container(
                                        height: ConfigSize.defaultSize! * 7,
                                        width: ConfigSize.defaultSize! * 7,
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.circular(
                                                ConfigSize.defaultSize! * 7),
                                            image: const DecorationImage(
                                                fit: BoxFit.fitWidth,
                                                image: AssetImage(
                                                    AssetsPath.music)))))),
                          ),
                          GestureDetector(
                            onTap: () {
                              distroyMusic();
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color:
                                        ColorManager.mainColor.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20)),
                                padding: const EdgeInsets.all(4),
                                child: Icon(
                                  CupertinoIcons.clear,
                                  color: Colors.white,
                                  size: AppPadding.p14,
                                )),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox();
            case MediaPlayState.LoadReady:
              if (MusicWidget.isIPlayerMedia) {
                if ((MusicScreen.nowPlaying! + 1) >=
                    MusicScreen.musicesInRoom.length) {
                  distroyMusic();
                  MusicScreen.nowPlaying = 0;
                  loadMusice(
                      path: MusicScreen
                          .musicesInRoom[MusicScreen.nowPlaying!].uri,
                      repeat: false);
                  ZegoUIKit.instance.getMediaCurrentProgressNotifier().value =
                      0;
                } else {
                  distroyMusic();
                  MusicScreen.nowPlaying = MusicScreen.nowPlaying! + 1;
                  loadMusice(
                      path: MusicScreen
                          .musicesInRoom[MusicScreen.nowPlaying!].uri,
                      repeat: false);
                  ZegoUIKit.instance.getMediaCurrentProgressNotifier().value =
                      0;
                }
              }
              return MusicWidget.isIPlayerMedia
                  ? DraggableFloatWidget(
                      config: DraggableFloatWidgetBaseConfig(
                        initPositionYInTop: false,
                        initPositionYMarginBorder:
                            ConfigSize.screenHeight! - 300,
                        borderTopContainTopBar: true,
                        borderBottom: 30,
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                  backgroundColor: ColorManager.mainColor,
                                  child: MusicDialog(
                                    ownerId: room.ownerId.toString(),
                                  ));
                            });
                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: RippleAnimation(
                                repeat: true,
                                color: ColorManager.mainColor,
                                minRadius: 30,
                                ripplesCount: 6,
                                child: RotationTransition(
                                    turns: controllerMusice,
                                    child: Container(
                                        height: ConfigSize.defaultSize! * 7,
                                        width: ConfigSize.defaultSize! * 7,
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.circular(
                                                ConfigSize.defaultSize! * 7),
                                            image: const DecorationImage(
                                                fit: BoxFit.fitWidth,
                                                image: AssetImage(
                                                    AssetsPath.music)))))),
                          ),
                          GestureDetector(
                            onTap: () {
                              distroyMusic();
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color:
                                        ColorManager.mainColor.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20)),
                                padding: const EdgeInsets.all(4),
                                child: Icon(
                                  CupertinoIcons.clear,
                                  color: Colors.white,
                                  size: AppPadding.p14,
                                )),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox();
          }
        });
  }
}
