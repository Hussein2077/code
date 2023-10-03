import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/view_music/view_music_screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/room_screen_controler.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/uikit_service.dart';




class MusicDialog extends StatefulWidget {
  static double currentSliderValue = 45;
  final void Function() refreshRoom ;
  final String ownerId ;
  final  int totalDuration  ;

  const MusicDialog({required this.refreshRoom,
    required this.ownerId, required this.totalDuration, Key? key}) : super(key: key);

  @override
  State<MusicDialog> createState() => _MusicDialogState();
}

class _MusicDialogState extends State<MusicDialog> {
late  bool isPlay  ;
double seeking = 0.0 ;
  @override
  void initState() {
    // TODO: implement initState
    isPlay =  MusicScreen.isPlaying.value ;

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
          padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize! ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  RoomScreen.musicesInRoom[MusicScreen.nowPlaying!].name
                      .toString(),
                  style: const TextStyle(color: Colors.white),overflow: TextOverflow.ellipsis,),
              SizedBox(
                height: ConfigSize.defaultSize! *  2.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(flex: 2,),
                  InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, Routes.music ,
                            arguments: MusicPramiter(refresh: widget.refreshRoom,
                            ownerId: widget.ownerId));
                      },
                      child: const Icon(
                        Icons.library_music_outlined,
                        color: Colors.white,
                      ) //player.hasPrevious ? player.seekToPrevious : null,
                  ),
                  SizedBox(
                    height: AppPadding.p10,
                    width: ConfigSize.defaultSize! * 17.4,
                    child: Slider(
                      autofocus: true,
                      activeColor: ColorManager.gold1,
                      min: 0,
                      max: 100,
                      value: MusicDialog.currentSliderValue,
                      onChanged: (double value) {
                        setState(() {
                          MusicDialog.currentSliderValue = value;
                          ZegoUIKit().setMediaVolume(MusicDialog.currentSliderValue.toInt()) ;

                        });
                      },
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                      onTap: () async {

                        if ((MusicScreen.nowPlaying! - 1) > -1) {
                          distroyMusic();

                          MusicScreen.nowPlaying = MusicScreen.nowPlaying! - 1;
                          loadMusice(
                              path: RoomScreen
                                  .musicesInRoom[MusicScreen.nowPlaying!]
                                  .uri);
                        } else {
                          distroyMusic();
                          MusicScreen.nowPlaying =
                              RoomScreen.musicesInRoom.length - 1;
                          loadMusice(
                              path: RoomScreen
                                  .musicesInRoom[MusicScreen.nowPlaying!].uri);
                        }
                        setState(() {
                          isPlay=true ;
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
                      onTap: () async{
                        if (isPlay) {
                        await  ZegoUIKit().pauseMedia() ;
                          setState(() {
                         //   RoomScreen.zegoMediaPlayer!.pause();

                            isPlay = false;
                          });
                        } else {
                          await  ZegoUIKit().resumeMedia() ;
                          setState(() {

                           // RoomScreen.zegoMediaPlayer!.resume();
                            isPlay= true;
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
                    onTap: ()  async{
                      // ZegoMediaPlayerState v  =      await    RoomScreen.zegoMediaPlayer!.getCurrentState() ;
                      // int e = await RoomScreen.zegoMediaPlayer!.getCurrentProgress() ;

                    },
                  ),
                  const Spacer(
                    flex: 2,
                  )
                ],
              ),
              SizedBox(
                height: ConfigSize.defaultSize! *  2.5,
              ),
              SizedBox(
                height: AppPadding.p10,
                width: ConfigSize.defaultSize! * 32,
                child: Slider(
                  autofocus: true,
                  activeColor: ColorManager.gold1,
                  min: 0,
                  max: widget.totalDuration.toDouble(),
                  value:seeking,
                  onChanged: (double value) {
                    setState(() {
                      seeking =value ;
                     log( seeking.toString()) ;
                    });
                  //  RoomScreen.zegoMediaPlayer!.seekTo(value.toInt());
                    ZegoUIKit().seekTo(value.toInt()) ;
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
