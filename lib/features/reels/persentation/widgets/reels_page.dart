import 'dart:developer';
import 'package:card_swiper/card_swiper.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/utils/url_checker.dart';
import 'package:tik_chat_v2/features/reels/data/models/reel_model.dart';
import 'package:tik_chat_v2/features/reels/persentation/reels_screen.dart';
import 'package:video_player/video_player.dart';
import '../components/like_icon.dart';
import '../components/screen_options.dart';

class ReelsPage extends StatefulWidget {
  final ReelModel item;
  final bool showVerifiedTick;
  final Function(ReelModel)? onShare;
  final Function(int)? onLike;
  final Function(String)? onComment;
  final Function(int)? onClickMoreBtn;
  final Function(String,bool)? onFollow;
  final SwiperController swiperController;
  final bool showProgressIndicator;
    final bool? userView; 

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
    this.userView
  }) : super(key: key);

  @override
  State<ReelsPage> createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _liked = false;
  bool _isVideoPause = false;
  @override
  void initState() {
    super.initState();
    if (!UrlChecker.isImageUrl(widget.item.url!) &&
        UrlChecker.isValid(widget.item.url!)) {
      initializePlayer();
    }
  }

  Future initializePlayer() async {

       if(ReelsScreenState.mapCachedReels.containsKey(StringManager.cachReelsKey)){

         try{
           final file = await getIt<DefaultCacheManager>().getFileFromCache(widget.item.url!);
           if(file?.file !=null){
             _videoPlayerController = VideoPlayerController.file(file!.file);
             if(kDebugMode){
               log("in cache reels");
             }
           }else{
             if(kDebugMode){
               log("in network reels");
             }
             _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.item.url!));

           }

         }catch(e){
           if(kDebugMode){
             log("error in found cach video and paly in network reels");
           }
           _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.item.url!));

         }


       }else{
         if(kDebugMode){
           log("in network reels");
         }
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
    return  Stack(
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

         Positioned(
           right: 10,
             bottom: 0,
             child: ScreenOptions(
              userView: widget.userView,
           onClickMoreBtn: widget.onClickMoreBtn,
           onComment: widget.onComment,
           onFollow: widget.onFollow,
           onLike: widget.onLike,
           onShare: widget.onShare,
           showVerifiedTick: widget.showVerifiedTick,
           item: widget.item,
           isFollowed:widget.item.isFollow,
         )) ,
          if(_isVideoPause)
        Container(
             color: Colors.grey.withOpacity(0.2),
             alignment: Alignment.center,
             child:  Icon(CupertinoIcons.play_fill,size: ConfigSize.defaultSize!*11.5,color: Colors.white.withOpacity(0.7),),
           ) ,
         Align(
           alignment: Alignment.center,
           child: InkWell(

    onTap: (){
    setState(() {
    if (_videoPlayerController.value.isPlaying){
    _videoPlayerController.pause() ;
    _isVideoPause = true ;
    }else{
    _isVideoPause = false ;
    _videoPlayerController.play() ;
    }
    });
    },
    child:SizedBox(
      width: ConfigSize.screenWidth!*0.6,
      height: ConfigSize.screenHeight!*0.6,
    ) ,
    ) ,
         )
        ],
      ) ;
  }
}
