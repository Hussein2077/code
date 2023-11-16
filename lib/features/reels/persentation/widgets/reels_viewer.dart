import 'dart:developer';
import 'package:card_swiper/card_swiper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/home/presentation/component/create_live/reels/component/upload_reels/widgets/upload_video.dart';
import 'package:tik_chat_v2/features/reels/data/models/reel_model.dart';
import 'package:tik_chat_v2/features/reels/persentation/widgets/custom_show_case.dart';
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
  final Function(int, int)? onClickMoreBtn;

  /// function invoke when user click on follow btn
  final Function(String, bool)? onFollow;

  /// for change appbar title
  final String? appbarTitle;

  /// for show/hide appbar, by default true
  final bool showAppbar;

  /// for show/hide video progress indicator, by default true
  final bool showProgressIndicator;

  /// function invoke when user click on back btn
  final Function()? onClickBackArrow;

  // StartIndex
  final int? startIndex;

  static ReelModel? reelModel;

  // to know iam in user view or not
  final bool userView;
final bool isFromVideo;

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
    this.showProgressIndicator = true,
    this.startIndex,
    required this.userView, required this.isFromVideo,
  }) : super(key: key);

  @override
  State<ReelsViewer> createState() => _ReelsViewerState();
}

class _ReelsViewerState extends State<ReelsViewer> {
  SwiperController controller = SwiperController();
  final GlobalKey _one = GlobalKey();
  final GlobalKey _two = GlobalKey();
  final GlobalKey _three = GlobalKey();
bool isFirst=true;
  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((_) async{
      isFirst=await  Methods.instance.getShowCase();
      log('${isFirst}isFirst&&');
if(isFirst&&widget.isFromVideo) {
  ShowCaseWidget.of(context).startShowCase([_one, _two,_three]);
}

    });

    controller.index = widget.startIndex ?? 0;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if(widget.isFromVideo){
    //   Future.delayed(const Duration(seconds: 1), ()async {
    //     if(isFirst) {
    //     }
    //   });
    // }
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              // Handle the scroll event here
              if (notification is ScrollUpdateNotification) {
                // Scrolling
              } else if (notification is ScrollEndNotification) {
                if (kDebugMode) {
                  log('Scroll ended');
                }
                controller.notifyListeners();
              }
              return true;
            },
            child: SizedBox(
              child: Stack(
                children: [
                  //We need swiper for every content
                  SizedBox(
                    height: ConfigSize.screenHeight,
                    width: ConfigSize.screenWidth,
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
                          index: index,
                        );
                      },
                      controller: controller,
                      itemCount: widget.reelsList.length,
                      scrollDirection: Axis.vertical,
                      onIndexChanged: widget.onIndexChanged,
                    ),
                  ),
                  if  (widget.showAppbar)
                    Positioned(
                      right: ConfigSize.defaultSize! * 1.5,
                      top: ConfigSize.defaultSize! * 1.5,
                      child:  (isFirst&&widget.isFromVideo)? CustomShowcaseWidget(
                          globalKey: _one,
                          textInContainer: StringManager.tabToUpload.tr(),
                          child: const UploadVideo()):const UploadVideo(),

                      // InkWell(
                      //   onTap: () {
                      //     Navigator.pushNamed(context, Routes.uploadVideo);
                      //   },
                      //   child: Container(
                      //       width: ConfigSize.defaultSize! * 3,
                      //       height: ConfigSize.defaultSize! * 3,
                      //       decoration: BoxDecoration(
                      //           color: ColorManager.mainColor.withOpacity(0.5),
                      //           borderRadius: BorderRadius.circular(
                      //               ConfigSize.defaultSize! * 3)),
                      //       child: Icon(
                      //         Icons.add,
                      //         color: Colors.white,
                      //         size: ConfigSize.defaultSize! * 3,
                      //       )),
                      // ),
                    ),

                  if(isFirst&&widget.isFromVideo)
                  Positioned(
                    left: ConfigSize.screenWidth! * .5,
                    top: ConfigSize.screenHeight! * .5,
                    child: CustomShowcaseWidget(
                      globalKey: _two,
                      textInContainer:StringManager.swapToGo.tr() ,
                      child: const SizedBox(
                        height: 3,
                        width: 3,
                      ),
                    ),
                  ),
                  if(isFirst&&widget.isFromVideo)
                  Positioned(
                    left: ConfigSize.defaultSize!*3,
                    top: ConfigSize.screenHeight! * .55,
                    child: CustomShowcaseWidget(
                      globalKey: _three,
                      textInContainer:StringManager.tabToFollow.tr() ,
                      child: const SizedBox(
                        height: 3,
                        width: 3,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
