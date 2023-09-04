import 'dart:developer';
import 'dart:io';

import 'package:card_swiper/card_swiper.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/url_checker.dart';
import 'package:tik_chat_v2/features/reels/data/models/reel_model.dart';
import 'package:tik_chat_v2/features/reels/persentation/reels_screen.dart';
import 'package:video_player/video_player.dart';
import '../components/like_icon.dart';
import '../components/screen_options.dart';
import 'package:path_provider/path_provider.dart';

class ReelsPage extends StatefulWidget {
  final ReelModel item;
  final bool showVerifiedTick;
  final Function(String)? onShare;
  final Function(int)? onLike;
  final Function(String)? onComment;
  final Function()? onClickMoreBtn;
  final Function()? onFollow;
  final SwiperController swiperController;
  final bool showProgressIndicator;
  const ReelsPage({
    Key? key,
    required this.item,
    this.showVerifiedTick = true,
    this.onClickMoreBtn,
    this.onComment,
    this.onFollow,
    this.onLike,
    this.onShare,
    this.showProgressIndicator = true,
    required this.swiperController,
  }) : super(key: key);

  @override
  State<ReelsPage> createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _liked = false;
  bool _onTouch = true;
  @override
  void initState() {
    super.initState();
    if (!UrlChecker.isImageUrl(widget.item.url!) &&
        UrlChecker.isValid(widget.item.url!)) {
      initializePlayer();
    }
  }

  Future initializePlayer() async {

       if(ReelsScreenState.cachedIdsReels.contains(widget.item.id)){
         if(kDebugMode){
           log("in cache reels");
         }
         Directory appDocDir = await getApplicationDocumentsDirectory();
         _videoPlayerController = VideoPlayerController.file(File('${appDocDir.path}/${widget.item.id}${StringManager.cachReelsKey}'));
       }else{
         _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.item.url!));
       }
       _videoPlayerController.setLooping(true);
    await Future.wait([_videoPlayerController.initialize()]);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      showControls: false,
      looping: true,
    );
    setState(() {});
    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.position ==
          _videoPlayerController.value.duration) {
        //TODO add auto scroll as feature
       // widget.swiperController.next();
      }
    });
  }

  @override
  void dispose() {

    _videoPlayerController.dispose();
    if (_chewieController != null) {
      _chewieController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getVideoView();
  }

  Widget getVideoView() {
    return  InkWell(
      onTap: (){
        setState(() {
          _videoPlayerController.value.isPlaying ?
          _videoPlayerController.pause() :
          _videoPlayerController.play();
        });
      },
      child:Stack(
        fit: StackFit.expand,
        children: [
          (_chewieController != null &&
              _chewieController!.videoPlayerController.value.isInitialized)
              ? FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: GestureDetector(
                onDoubleTap: () {
                  if (!widget.item.likeExists!) {
                    _liked = true;
                    if (widget.onLike != null) {
                      widget.onLike!(widget.item.id!);
                    }
                    setState(() {});
                  }
                },
                child: Chewie(
                  controller: _chewieController!,
                ),
              ),
            ),
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text('Loading...')
            ],
          ),
          if (_liked)
            const Center(
              child: LikeIcon(),
            ),
          if (widget.showProgressIndicator)
            Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: VideoProgressIndicator(
                _videoPlayerController,
                allowScrubbing: false,
                colors: const VideoProgressColors(
                  backgroundColor: Colors.blueGrey,
                  bufferedColor: Colors.blueGrey,
                  playedColor: Colors.blueAccent,
                ),
              ),
            ),
          ScreenOptions(
            onClickMoreBtn: widget.onClickMoreBtn,
            onComment: widget.onComment,
            onFollow: widget.onFollow,
            onLike: widget.onLike,
            onShare: widget.onShare,
            showVerifiedTick: widget.showVerifiedTick,
            item: widget.item,
          ),
          (_chewieController != null && _chewieController!.videoPlayerController.value.isInitialized&& false) ?
          Visibility(
              visible: _onTouch,
              child: Container(
                color: Colors.grey.withOpacity(0.5),
                alignment: Alignment.center,
                child: ElevatedButton(
                  //  shape: CircleBorder(side: BorderSide(color: Colors.white)),
                  child: Icon(_videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white,),
                  onPressed: () {
                    // _timer?.cancel();

                    // pause while video is playing, play while video is pausing
                    setState(() {
                      _videoPlayerController.value.isPlaying ?
                      _videoPlayerController.pause() :
                      _videoPlayerController.play();
                    });

                    // Auto dismiss overlay after 1 second
                    // _timer = Timer.periodic(Duration(milliseconds: 1000), (_) {
                    setState(() {
                      _onTouch = false;
                    });
                    // });
                  },
                ),
              )) :
          const SizedBox()
        ],
      ) ,
    )  ;
  }
}
