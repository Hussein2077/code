

import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/reels/data/models/reel_model.dart';
import 'package:tik_chat_v2/features/reels/persentation/widgets/reels_page.dart';
import 'package:video_player/video_player.dart';

class ReelsViewer extends StatefulWidget {
  /// use reel model and provide list of reels, list contains reels object, object contains url and other parameters
  final List<ReelModel> reelsList;

  /// use to show/hide verified tick, by default true
  final bool showVerifiedTick;

  /// function invoke when user click on share btn and return reel url
  final Function(ReelModel)? onShare;

  /// function invoke when user click on like btn and return reel url
  final Function(int)? onLike;

  /// function invoke when user click on comment btn and return reel comment
  final Function(String)? onComment;


  /// function invoke when reel change and return current index
  final Function(int)? onIndexChanged;

  /// function invoke when user click on more options btn
  final Function(int,int)? onClickMoreBtn;

  /// function invoke when user click on follow btn
  final Function(String,bool)? onFollow;

  /// for change appbar title
  final String? appbarTitle;

  /// for show/hide appbar, by default true
  final bool showAppbar;

  /// for show/hide video progress indicator, by default true
  final bool showProgressIndicator;

  /// function invoke when user click on back btn
  final Function()? onClickBackArrow;

  // StartIndex 
  final int? startIndex ;

  static ReelModel? reelModel   ;

   // to know iam in user view or not
  final bool userView; 

   const ReelsViewer({
    Key? key,
    required this.reelsList,
    this.showVerifiedTick = true,
    this.onClickMoreBtn,
    this.onComment,
    this.onFollow,
    this.onLike,
    this.onShare,
    this.appbarTitle,
    this.showAppbar = true,
    this.onClickBackArrow,
    this.onIndexChanged,
    this.showProgressIndicator =true,
    this.startIndex ,
   required this.userView,
  }) : super(key: key);


  @override
  State<ReelsViewer> createState() => _ReelsViewerState();
}

class _ReelsViewerState extends State<ReelsViewer> {

  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  SwiperController controller = SwiperController();
  FileInfo? image ;

  @override
  void initState() {
    initializePlayer() ;
   controller.index = widget.startIndex??0;
    super.initState();
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child:NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
      // Handle the scroll event here
      if (notification is ScrollStartNotification) {
        // Scroll started
        if(kDebugMode){
          log('Scroll started');
        }
      }
      else if (notification is ScrollUpdateNotification) {
        // Scrolling
        if(kDebugMode){
          log('Scrolling');
        }
      }
      else if (notification is ScrollEndNotification) {
        if(kDebugMode) {
          log('Scroll ended');
        }
    //    ReelsPage.canPlayNow.value = true ;
        initializePlayer() ;
      }
      return true;
    },
    child:SizedBox(
          
          child: Stack(
            children: [
              //We need swiper for every content
            Padding(
                   padding: EdgeInsets.only(top: ConfigSize.defaultSize! * 0),
                   //padding: EdgeInsets.only(top: ConfigSize.defaultSize!*6.4),
                   child: Swiper(
                     itemBuilder: (BuildContext context, int index) {

                       return ReelsPage(
                         userView: widget.userView,
                         item: widget.reelsList[index],
                         onClickMoreBtn: widget.onClickMoreBtn,
                         onComment: widget.onComment,
                         onFollow: widget.onFollow,
                         onLike: widget.onLike,
                         onShare: widget.onShare,
                         showVerifiedTick: widget.showVerifiedTick,
                         swiperController: controller,
                         showProgressIndicator: widget.showProgressIndicator,
                         image: image,
                         videoPlayerController:_videoPlayerController ,
                         chewieController: _chewieController,

                       );
                     },
                     controller: controller,
                     itemCount: widget.reelsList.length,
                     scrollDirection: Axis.vertical,
                     onIndexChanged: widget.onIndexChanged,
                   ),
                 ),
              if (widget.showAppbar)
                Positioned(
                  right: ConfigSize.defaultSize!*1.5,
                  top: ConfigSize.defaultSize!*1.5,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.uploadReels);
                    },
                    child: Container(
                        width: ConfigSize.defaultSize! * 3,
                        height: ConfigSize.defaultSize! * 3,
                        decoration: BoxDecoration(
                            color: ColorManager.mainColor.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(
                                ConfigSize.defaultSize! * 3)),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: ConfigSize.defaultSize! * 3,
                        )),
                  ),
                )

            ],
          ),
        ),
      ),
    ));
  }


  Future initializePlayer() async {


    image =await  getIt<DefaultCacheManager>().getFileFromCache(ReelsViewer.reelModel?.img??'');

    final file = await getIt<DefaultCacheManager>().getFileFromCache(ReelsViewer.reelModel?.url??'');
    if(file?.file !=null){



      ReelsPage.isVideoPause.value = false ;
      _videoPlayerController = VideoPlayerController.file(file!.file);
      if(kDebugMode){
        log("in cache reels");
      }
    }else{
      if(kDebugMode){
        log((ReelsViewer.reelModel!.url.toString()));
        log("in network reels");
      }
      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(ReelsViewer.reelModel!.url!));
    }




    _videoPlayerController?.setLooping(true);

    try{
      await Future.wait([_videoPlayerController!.initialize()]).then((value) {
        ReelsPage.canPlayNow.value= false ;
      } );
    }catch(e){

      if(kDebugMode){
        log("error type : ${e.toString()}");
        log("error in reels path is :${Uri.parse(ReelsViewer.reelModel!.url!+'rr')}");
      }
      // widget.swiperController.next();
    }


    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      autoPlay: true,
      showControls: false,
      looping: true,
    );
    setState(() {});
    _videoPlayerController?.addListener(() {
      if (_videoPlayerController?.value.position ==
          _videoPlayerController?.value.duration) {// TODO add auto scroll as feature
        // widget.swiperController.next();
      }
      if (!ModalRoute.of(context)!.isCurrent) {
        _videoPlayerController?.pause();
        ReelsPage.isVideoPause.value = true;
      }


    });
  }
}
