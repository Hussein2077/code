import 'dart:developer';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/utils/url_checker.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/user_profile/component/user_reel_viewr/widget/user_reel_loading_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/user_profile/user_profile.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/user_profile/component/user_reel_viewr/widget/user_screen_options.dart';
import 'package:tik_chat_v2/features/reels/data/models/reel_model.dart';
import 'package:tik_chat_v2/features/reels/persentation/components/like_icon.dart';
import 'package:tik_chat_v2/features/reels/persentation/reels_screen.dart';
import 'package:tik_chat_v2/main_screen/components/nav_bar/src/layout.dart';
import 'package:tik_chat_v2/main_screen/main_screen.dart';
import 'package:video_player/video_player.dart';


class UserReelsPage extends StatefulWidget {
  final ReelModel item;
  final bool showVerifiedTick;
  final Function(ReelModel)? onShare;
  final Function(int)? onLike;
  final Function(String)? onComment;
  final Function(int, int)? onClickMoreBtn;
  final Function(String, bool)? onFollow;
  final int reelIndex ;
  final PageController  pageController;
  final bool showProgressIndicator;
 // final bool userView;
  static bool isFirst = true;
  static ValueNotifier<bool> isVideoPause = ValueNotifier<bool>(false);


  UserReelsPage(
      {Key? key,
        required this.item,
        this.showVerifiedTick = true,
        this.onClickMoreBtn,
        this.onComment,
        this.onFollow,
        this.onLike,
        this.onShare,
        required this.reelIndex,
        this.showProgressIndicator = true,
        required this.pageController,
     //   required this.userView
      })
      : super(key: key);

  @override
  State<UserReelsPage> createState() => UserReelsPageState();
}

class UserReelsPageState extends State<UserReelsPage>
    with SingleTickerProviderStateMixin ,  WidgetsBindingObserver  {
  VideoPlayerController?   _videoPlayerController  ;
  ChewieController? _chewieController;
  FileInfo? image ;
  bool _liked = false;
  double? videoWidth;
  double? videoHeight;
  late final AnimationController _controller =
  AnimationController(
    duration: const Duration(milliseconds: 2000),
    vsync: this,
  )..repeat(reverse: false);
  late final Animation<Offset> _offsetAnimation =
  Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.0, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.bounceIn
    ,
  ));

  @override
  void initState() {
    super.initState();
    if (!UrlChecker.isImageUrl(widget.item.url!) &&
        UrlChecker.isValid(widget.item.url!)) {
      initializePlayer().then((value) {
        if(UserReelsPage.isFirst) {
          _videoPlayerController?.play() ;
          UserReelsPage.isFirst = false;
        }

      });
    }

    widget.pageController.addListener(() {
      if(widget.reelIndex == ReelsScreenState.currentIndex){
        _videoPlayerController?.play() ;
      }


    });

    WidgetsBinding.instance.addObserver(this);

  }


  Future initializePlayer() async {

    final file = await getIt<DefaultCacheManager>().getFileFromCache(widget.item.url!);
    final cachImage =  await getIt<DefaultCacheManager>().getFileFromCache(ConstentApi().getImage(widget.item.img! ));
    image = cachImage ;

    if(file?.file !=null){


      _videoPlayerController = VideoPlayerController.file(file!.file);
      if(kDebugMode){
        log("in cache reels");
      }
    }
    else{
      if(kDebugMode){
        log((widget.item.url!.toString()));
        log("in network reels");
      }
      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.item.url!));
    }




    _videoPlayerController?.setLooping(true);

    try{
      await Future.wait([_videoPlayerController!.initialize()]);
    }catch(e){
      if(kDebugMode){
        log("error in reels path is :${Uri.parse(widget.item.url!+'rr')}");
      }
      widget.pageController.nextPage(duration: const Duration(milliseconds: 100),
          curve:Curves.easeIn ) ;

    }


    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        showControls: false,
        looping: true,
        isLive:true
    );
    setState(() {});
    UserReelsPage.isVideoPause.addListener(() {
      if(UserReelsPage.isVideoPause.value && !(_videoPlayerController?.value.isPlaying??true)){
        _videoPlayerController?.play();
      }else if(UserReelsPage.isVideoPause.value){
        _videoPlayerController?.pause();
      }
    });
    _videoPlayerController?.addListener(() {
      //to handle close reel when make navigate
      if (MainScreen.canNotPlayOutOfReelMainScreen && BottomNavLayoutState.currentIndex !=1) {
        UserReelsPage.isVideoPause.value= true ;
      }



      if (_videoPlayerController?.value.position ==
          _videoPlayerController?.value.duration) {
        //TODO add auto scroll as feature
        // widget.swiperController.next();
      }

      if((_videoPlayerController?.value.isPlaying??false) &&
          UserReelsPage.isVideoPause.value){
        UserReelsPage.isVideoPause.value = false ;
      }

      if(!(_videoPlayerController?.value.isPlaying??true)&& !UserReelsPage.isVideoPause.value){
        if(widget.reelIndex == ReelsScreenState.currentIndex){
          _videoPlayerController?.play() ;
        }

      }



    });
  }

  @override
  void dispose() {

    _videoPlayerController?.dispose();

    if (_chewieController != null) {
      _chewieController!.dispose();
    }

    WidgetsBinding.instance.removeObserver(this);



    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);


    switch (state) {
      case AppLifecycleState.resumed:
        _videoPlayerController?.play();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      // case AppLifecycleState.hidden:
      // _videoPlayerController?.pause();
      // ReelsPage.isVideoPause.value =true;
        break;
    }
  }



  @override
  Widget build(BuildContext context) {

    return getVideoView();
  }

  Widget getVideoView(){
    return Stack(
      fit: StackFit.expand,
      children: [
        (_chewieController != null &&
            _chewieController!.videoPlayerController.value.isInitialized)
            ? SizedBox(
          width: MediaQuery.of(context).size.width ,
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
            onTap: () {
              setState(() {
                if (_videoPlayerController!.value.isPlaying) {
                  UserReelsPage.isVideoPause.value = true;
                }
                else{
                  UserReelsPage.isVideoPause.value = false;
                  _videoPlayerController?.play();
                }
              });
            },
            onHorizontalDragEnd: (DragEndDetails details){
              if(details.primaryVelocity!>0){
                UserReelsPage.isVideoPause.value = true;
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder:
                        (context, animation, secondaryAnimation) =>
                        SlideTransition(
                          position: _offsetAnimation,
                          child: UserProfile(
                            userId:
                            MyDataModel.getInstance().id.toString() ==
                                widget.item.userId.toString()
                                ? null
                                : widget.item.userId.toString(),
                          ),
                        ),
                  ),
                );
              }
            },

            child: Chewie(
              controller: _chewieController!,
            ),
          ),
        )

            : UserReelLodaingWidget(
          reelId: widget.item.id.toString(),
          image:image ,
        ),
        if (_liked)
          const Center(
            child: LikeIcon(),
          ),
        if (widget.showProgressIndicator )
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: VideoProgressIndicator(
              _videoPlayerController!,
              allowScrubbing: false,
              colors: const VideoProgressColors(
                backgroundColor: Colors.blueGrey,
                bufferedColor: Colors.blueGrey,
                playedColor: Colors.blueAccent,
              ),
            ),
          ),
        Positioned(
            right: ConfigSize.defaultSize!,
            bottom: 0,
            child: UserScreenOptions(
            //  userView: widget.userView,
              onClickMoreBtn: widget.onClickMoreBtn,
              onComment: widget.onComment,
              onFollow: widget.onFollow,
              onLike: widget.onLike,
              onShare: widget.onShare,
              showVerifiedTick: widget.showVerifiedTick,
              item: widget.item,
              isFollowed: widget.item.isFollow,
            )),
        ValueListenableBuilder(
            valueListenable: UserReelsPage.isVideoPause,
            builder: (context, ispause, _) {
              if (ispause&&!(_videoPlayerController?.value.isPlaying??true)) {
                return IgnorePointer(
                    child: Container(
                      color: Colors.grey.withOpacity(0.2),
                      alignment: Alignment.center,
                      child: Icon(
                        CupertinoIcons.play_fill,
                        size: ConfigSize.defaultSize! * 11.5,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ));
              } else {
                return const SizedBox();
              }
            }),
      ],
    );
  }
}