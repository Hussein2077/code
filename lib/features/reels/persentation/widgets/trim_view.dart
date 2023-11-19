import 'dart:developer';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_height_plugin/keyboard_height_plugin.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/text_field.dart';
import 'package:tik_chat_v2/features/home/presentation/component/create_live/reels/component/upload_reels/widgets/chose_topic_dailog.dart';
import 'package:tik_chat_v2/features/home/presentation/component/create_live/reels/component/upload_reels/widgets/upload_video.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_upload_reel/upload_reels_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_upload_reel/upload_reels_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/widgets/reels_page.dart';

import 'trim/trim_viewer.dart';
import 'trim/trimmer.dart';
import 'trim/video_viewer.dart';





class TrimmerView extends StatefulWidget {
  final File file;
  static List<int> selectedIntrest = [];
  // static List<String> selectedTopics = [];
  static ValueNotifier<bool> hashtag = ValueNotifier<bool>(false);
  static bool showTextField = false ;

  TrimmerView({
    required this.file,
  });

  @override
  _TrimmerViewState createState() => _TrimmerViewState();
}

class _TrimmerViewState extends State<TrimmerView> {
  late TextEditingController reelsNameController;
  double _keyboardHeight = 0;
  final KeyboardHeightPlugin _keyboardHeightPlugin = KeyboardHeightPlugin();
  static ValueNotifier<bool> showTextFieldReel = ValueNotifier<bool>(false);

  @override
  void dispose() {
    showTextFieldReel.value=false;
    TrimmerView.selectedIntrest = [];
    reelsNameController.dispose();
    super.dispose();
  }

  final Trimmer _trimmer = Trimmer();

  double _startValue = 0.0;
  double _endValue = 0.0;

  bool _isPlaying = false;


  Future<String?> _saveVideo() async {


    String? _value;

    await _trimmer
        .saveTrimmedVideo(
            onSave: (s) async {
              log(s.toString()+"11111111");
              UploadVideoState.video = s ;
            },
            startValue: _startValue,
            endValue: _endValue)
        .then((value) {
      if(TrimmerView.selectedIntrest.isEmpty){
        final snackBar = SnackBar(
            content: Text(StringManager.oneHashtag.tr()));
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
      }else {
        final snackBar = SnackBar(
            content: Text(StringManager.loading.tr()));
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar,
        );
        Future.delayed(const Duration(seconds: 3), () async {
          BlocProvider.of<UploadReelsBloc>(context).add(
              UploadReelsEvent(
                  categories: TrimmerView.selectedIntrest,
                  description: reelsNameController.text.isEmpty? " " : reelsNameController.text,
                  reel: File(UploadVideoState.video!)));
          Navigator.pop(context);
        });


      }
    });
    return _value;
  }

  void _loadVideo() {
    _trimmer.loadVideo(videoFile: widget.file);
  }

  @override
  void initState() {
    // ReelsPage.isVideoPause.value = true;
    TrimmerView.showTextField = false ;
    reelsNameController = TextEditingController();

    _keyboardHeightPlugin.onKeyboardHeightChanged((double height) {

        if(height !=0 ){
          showTextFieldReel.value = true;

        }else {
          showTextFieldReel.value = false;

        }
        _keyboardHeight = height;



    });

    super.initState();
    _loadVideo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,

        body: Builder(builder: (context) {
          return Stack(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: VideoViewer(trimmer: _trimmer)),
              InkWell(
                onTap: ()async {
                  log("heeeeeeer");
                  bool playbackState = await _trimmer.videoPlaybackControl(
                    startValue: _startValue,
                    endValue: _endValue,
                  );
                  setState(() {
                    _isPlaying = playbackState;
                  });
                },
                child: Center(


                    child: _isPlaying
                        ? const Icon(
                      Icons.pause,
                      size: 80.0,
                      color: Colors.white,
                    )
                        : const Icon(
                      Icons.play_arrow,
                      size: 80.0,
                      color: Colors.white,
                    ),

                  ),
                ),

              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: ConfigSize.defaultSize! * 4.5),
                      child: Container(
                        decoration:   BoxDecoration(
                            shape: BoxShape.circle, color: Colors.black.withOpacity(0.5)),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                              size: ConfigSize.defaultSize! * 2.5,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: ConfigSize.defaultSize,
                    ),
                    Center(
                      child: Directionality(
                        textDirection: ui.TextDirection.ltr,
                        child: TrimViewer(
                          trimmer: _trimmer,
                          viewerHeight: 50.0,
                          viewerWidth: MediaQuery.of(context).size.width-20,
                          maxVideoLength: const Duration(minutes: 3),
                          onChangeStart: (value) => _startValue = value,
                          onChangeEnd: (value) => _endValue = value,
                          onChangePlaybackState: (value) =>
                              setState(() => _isPlaying = value),
                        ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        SizedBox(
                          width: ConfigSize.defaultSize! * 2,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: ConfigSize.defaultSize!),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(
                                  ConfigSize.defaultSize! * 2),
                              border: Border.all(color: Colors.white)),
                          width: MediaQuery.of(context).size.width - 100,
                          child: TextFieldWidget(
                              textColor: Colors.white,
                              controller: reelsNameController,
                              hintText: StringManager.videoDescription.tr()),
                        ),
                        SizedBox(
                          width: ConfigSize.defaultSize! * 2,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 23,
                          child: IconButton(
                              onPressed: () async {
                                await _saveVideo().then((outputPath) {
                                  // final snackBar = SnackBar(
                                  //     content: Text(StringManager.sucsses.tr()));
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   snackBar,
                                  // );
                                });
                              },
                              icon: const Icon(
                                Icons.send,
                                size: 26,
                                color: Colors.white,
                              )),
                        ),
                      ],
                    ),
                    ValueListenableBuilder<bool>(
                        valueListenable: showTextFieldReel,
                        builder: (context, isShow, _) {
                          if (isShow) {
                            return SizedBox(height:_keyboardHeight==0.0?0: _keyboardHeight-ConfigSize.defaultSize!*4);
                          } else {
                            return const SizedBox(
                              height: 0,
                            );
                          }
                        }),
                    Container(
                      color: Colors.black.withOpacity(0.6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: ConfigSize.defaultSize,
                          ),

                          ValueListenableBuilder<bool>(
                            valueListenable: TrimmerView.hashtag,
                            builder: (context, b, _) {

                              if(TrimmerView.selectedIntrest.isEmpty ){
                               return  reelRowWidget(
                                  context: context,
                                  icon: AssetsPath.hashTagIcon,
                                  title: StringManager.chooseTheTopic.tr(),
                                  widget: const ChooseTopicDailog(),
                                );
                              }else {
                              return  reelRowWidget(
                                  context: context,
                                  icon: AssetsPath.hashTagIcon,
                                  title: StringManager.topicHasBeenChosen.tr(),
                                  widget: const ChooseTopicDailog(),
                                );
                              }



                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),


            ],
          );
        })

        // Builder(
        //   builder: (context) => Center(
        //     child: Container(
        //       padding: const EdgeInsets.only(bottom: 30.0),
        //       color: Colors.black,
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         mainAxisSize: MainAxisSize.max,
        //         children: <Widget>[
        //           Center(
        //             child: Directionality(
        //               textDirection: ui.TextDirection.ltr,
        //               child: TrimViewer(
        //                 trimmer: _trimmer,
        //                 viewerHeight: 50.0,
        //                 viewerWidth: MediaQuery.of(context).size.width,
        //                 maxVideoLength: const Duration(minutes: 3),
        //                 onChangeStart: (value) => _startValue = value,
        //                 onChangeEnd: (value) => _endValue = value,
        //                 onChangePlaybackState: (value) =>
        //                     setState(() => _isPlaying = value),
        //               ),
        //             ),
        //           ),
        //           Visibility(
        //             visible: _progressVisibility,
        //             child: const LinearProgressIndicator(
        //               backgroundColor: Colors.red,
        //             ),
        //           ),
        //           // Expanded(
        //           //   child:
        //           // ),
        //           MainButton(
        //               width: ConfigSize.defaultSize! * 10,
        //               onTap: _progressVisibility
        //                   ? () {}
        //                   : () async {
        //                       await _saveVideo().then((outputPath) {
        //                         log(outputPath.toString());
        //                         final snackBar = SnackBar(
        //                             content: Text(StringManager.sucsses.tr()));
        //                         ScaffoldMessenger.of(context).showSnackBar(
        //                           snackBar,
        //                         );
        //                       });
        //                       // Navigator.pop(context);
        //                     },
        //               title: StringManager.save.tr()),
        //         SizedBox(height: ConfigSize.defaultSize!,),
        //           Container(
        //             padding: EdgeInsets.symmetric(
        //                 horizontal: ConfigSize.defaultSize!),
        //             decoration: BoxDecoration(
        //                 borderRadius:
        //                     BorderRadius.circular(ConfigSize.defaultSize! * 2),
        //                 border: Border.all(color: Colors.white)),
        //             width: MediaQuery.of(context).size.width - 50,
        //             child: TextFieldWidget(
        //                 textColor: Colors.white,
        //                 controller: reelsNameController,
        //                 hintText: StringManager.videoDescription.tr()),
        //           ),
        //           TextButton(
        //             child: _isPlaying
        //                 ? const Icon(
        //                     Icons.pause,
        //                     size: 80.0,
        //                     color: Colors.white,
        //                   )
        //                 : const Icon(
        //                     Icons.play_arrow,
        //                     size: 80.0,
        //                     color: Colors.white,
        //                   ),
        //             onPressed: () async {
        //               bool playbackState = await _trimmer.videoPlaybackControl(
        //                 startValue: _startValue,
        //                 endValue: _endValue,
        //               );
        //               setState(() {
        //                 _isPlaying = playbackState;
        //               });
        //             },
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        );
  }
}


Widget reelRowWidget(
    {required BuildContext context,
      required String icon,
      required String title,
      required Widget widget}) {
  return InkWell(
    onTap: () {
      bottomDailog(context: context, widget: widget);
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(ConfigSize.defaultSize! ),
        border: Border.all(color: Colors.black),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [

            Image.asset(
              icon,
              scale: 4,
            ),

            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),
            ),

          ],
        ),
      ),
    ),
  );
}