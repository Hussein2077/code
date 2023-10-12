import 'dart:developer';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/text_field.dart';
import 'package:tik_chat_v2/features/home/presentation/component/create_live/reels/component/upload_reels/widgets/upload_video.dart';
import 'package:video_trimmer/video_trimmer.dart';
import 'dart:ui' as ui;

class TrimmerView extends StatefulWidget {
  final File file;
    final TextEditingController reelsNameController;


  const TrimmerView({required this.file , required this.reelsNameController});

  @override
  _TrimmerViewState createState() => _TrimmerViewState();
}

class _TrimmerViewState extends State<TrimmerView> {
  
  final Trimmer _trimmer = Trimmer();

  double _startValue = 0.0;
  double _endValue = 0.0;

  bool _isPlaying = false;
  bool _progressVisibility = false;

  Future<String?> _saveVideo() async {
    setState(() {
      _progressVisibility = true;
    });

    String? _value;

    await _trimmer
        .saveTrimmedVideo(
          onSave: (s)async {
     UploadVideoState.video = s ; 
     Navigator.pop(context);
          },
          startValue: _startValue, endValue: _endValue)
        .then((value) {
      setState(() {
        _progressVisibility = false;
      
      });
    });
    return _value;
  }

  void _loadVideo() {
    _trimmer.loadVideo(videoFile: widget.file);
  }

  @override
  void initState() {
    widget.reelsNameController.clear();
    super.initState();

    _loadVideo();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading:  IconButton(
              onPressed: ()async{

                final videoInfo = FlutterVideoInfo();
                String videoFilePath = widget.file.path;
                var info = await videoInfo.getVideoInfo(videoFilePath);

                if(info!.duration!/60000 > 3.0){
                  final snackBar = SnackBar(
                      content: Text(StringManager.video_size_error.tr()));
                  ScaffoldMessenger.of(context).showSnackBar(
                    snackBar,
                  );
                }else{
                  UploadVideoState.video = widget.file.path;
                  Navigator.pop(context);
                }
            },
              icon:const Icon( Icons.arrow_back_ios))
         
        ),
        body: Builder(
          builder: (context) => Center(
            child: Container(
              padding: const EdgeInsets.only(bottom: 30.0),
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                       Container(
              padding:
                  EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(ConfigSize.defaultSize! * 2),
                  border: Border.all(color: Colors.white)),
              width: MediaQuery.of(context).size.width - 50,
              child: TextFieldWidget(
                  textColor: Colors.white,
                  controller: widget.reelsNameController,
                  hintText: StringManager.videoDescription.tr()),
            ),
                  Visibility(
                    visible: _progressVisibility,
                    child: const LinearProgressIndicator(
                      backgroundColor: Colors.red,
                    ),
                  ),
                  
     
                  Expanded(
                    child: VideoViewer(trimmer: _trimmer),
                  ),
                          MainButton(
                    width: ConfigSize.defaultSize!*10,
                    onTap:  _progressVisibility
                      ? (){}
                      : () async {
    
                       await   _saveVideo().then((outputPath) {
    
                            
                            log(outputPath.toString());
                            final snackBar = SnackBar(
                                content: Text(StringManager.sucsses.tr()));
                            ScaffoldMessenger.of(context).showSnackBar(
                              snackBar,
                            );
                          });
                          // Navigator.pop(context);
                        }, title: StringManager.save.tr()),
                  Center(
                    child: Directionality(
                      textDirection:  ui.TextDirection.ltr,
                      child: TrimViewer(
                        trimmer: _trimmer,
                        viewerHeight: 50.0,
                        viewerWidth: MediaQuery.of(context).size.width,
                        maxVideoLength: const Duration(minutes: 3),
                        onChangeStart: (value) => _startValue = value,
                        onChangeEnd: (value) => _endValue = value,
                        onChangePlaybackState: (value) =>
                            setState(() => _isPlaying = value),
                      ),
                    ),
                  ),
                  
                  TextButton(
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
                    onPressed: () async {
                      bool playbackState = await _trimmer.videoPlaybackControl(
                        startValue: _startValue,
                        endValue: _endValue,
                      );
                      setState(() {
                        _isPlaying = playbackState;
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}