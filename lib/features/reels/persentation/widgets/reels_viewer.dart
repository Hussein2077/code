

import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/reels/data/models/reel_model.dart';
import 'package:tik_chat_v2/features/reels/persentation/widgets/reels_page.dart';


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

  SwiperController controller = SwiperController();
   bool isPlay = true ;

  @override
  void initState() {
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
        child: // InViewNotifierList(
        //   scrollDirection: Axis.vertical,
        //   //  initialInViewIds: ['0'],
        //   isInViewPortCondition:
        //       (double deltaTop, double deltaBottom, double viewPortDimension) {
        //     log("deltaTop:${deltaTop}");
        //     log('deltaBottom : ${deltaBottom}');
        //     if(deltaTop < (0.5 * viewPortDimension) &&
        //         deltaBottom > (0.5 * viewPortDimension)){
        //       log("ttttttttt");
        //     }
        //
        //     return deltaTop < (0.5 * viewPortDimension) &&
        //         deltaBottom > (0.5 * viewPortDimension);
        //   },
        //   builder: (BuildContext context,index){
        //     final InViewState? inViewState =
        //     InViewNotifierList.of(context);
        //     inViewState?.addContext(context: context, id: '$index');
        //     return Container(
        //       width: double.infinity,
        //       height: ConfigSize.screenHeight!-150,
        //       alignment: Alignment.center,
        //       margin:  const EdgeInsets.symmetric(vertical: 10.0),
        //       child: AnimatedBuilder(
        //             animation: inViewState!,
        //             builder: (context, child)  {
        //               return  ReelsPage(
        //                 userView: widget.userView,
        //                 item: widget.reelsList[index],
        //                 onClickMoreBtn: widget.onClickMoreBtn,
        //                 onComment: widget.onComment,
        //                 onFollow: widget.onFollow,
        //                 onLike: widget.onLike,
        //                 onShare: widget.onShare,
        //                 showVerifiedTick: widget.showVerifiedTick,
        //                 swiperController: controller,
        //                 showProgressIndicator: widget.showProgressIndicator,
        //                 play: inViewState.inView('$index')
        //
        //               )  ;
        //             },
        //
        //
        //       ),
        //     ) ;
        //   },
        //   itemCount: 3,
        //
        // )
        NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
      // Handle the scroll event here
      if (notification is ScrollStartNotification) {
        // Scroll started
        if(kDebugMode){
          log('Scroll started');
        }
      }
      else if (notification is ScrollUpdateNotification) {
      log("notification ${notification.metrics.axis}");
      log("notification xd ${notification.dragDetails?.delta.dx}");
      log("notification xy ${notification.dragDetails?.delta.dy}");


        // Scrolling
      }
      else if (notification is ScrollEndNotification) {
        if(kDebugMode) {
          log('Scroll ended');
        }
        ReelsPage.videoPlayerController?.play();


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
                         play: isPlay,

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


}
