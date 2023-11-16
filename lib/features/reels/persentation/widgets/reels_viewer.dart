

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/home/presentation/component/create_live/reels/component/upload_reels/widgets/upload_video.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_reels/get_user_reels_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_reels/get_user_reels_event.dart';
import 'package:tik_chat_v2/features/reels/data/models/reel_model.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reels/get_reels_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reels/get_reels_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/reels_screen.dart';
import 'package:tik_chat_v2/features/reels/persentation/widgets/reels_page.dart';
import 'package:tik_chat_v2/main_screen/main_screen.dart';


class ReelsViewer extends StatefulWidget {

  //user data of reel owner
  final UserDataModel? userData ;
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
     this.userData ,
    this.showVerifiedTick = true,
    this.onClickMoreBtn,
    this.onComment,
    this.onFollow,
    this.onLike,
    this.onShare,
    this.appbarTitle,
    this.showAppbar = true,
    this.onClickBackArrow,
    this.showProgressIndicator =true,
    this.startIndex ,
   required this.userView,
  }) : super(key: key);


  @override
  State<ReelsViewer> createState() => _ReelsViewerState();
}

class _ReelsViewerState extends State<ReelsViewer> {

  late  PageController  pageController ;


  @override
  void initState() {
    pageController = PageController(
        initialPage:widget.startIndex??0
    );
    super.initState();
  }


  @override
  void dispose() {
    MainScreen.canNotPlayOutOfReelMainScreen = true ;
    pageController.dispose() ;
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SizedBox(

          child: Stack(
            children: [
              //We need swiper for every content
               SizedBox(
              height:ConfigSize.screenHeight ,
              width: ConfigSize.screenWidth,
              child:PageView.builder(
                  itemBuilder: (BuildContext context, int index){
                        return ReelsPage(
                          userView: widget.userView,
                          item: widget.reelsList[index],
                          onClickMoreBtn: widget.onClickMoreBtn,
                          onComment: widget.onComment,
                          onFollow: widget.onFollow,
                          onLike: widget.onLike,
                          onShare: widget.onShare,
                          showVerifiedTick: widget.showVerifiedTick,
                         // swiperController: controller,
                          showProgressIndicator: widget.showProgressIndicator,
                          reelIndex: index,
                          pageController: pageController,
                        );
                  },
                itemCount:widget.reelsList.length ,
                scrollDirection:Axis.vertical ,
                onPageChanged: (int value){
                  ReelsScreenState.currentIndex = value ;
                  pageController.notifyListeners();
                  if(widget.userView){
                    if (widget.reelsList.length - value < 5){
                      if (widget.userData!.id ==
                          MyDataModel.getInstance().id) {
                        BlocProvider.of<GetUserReelsBloc>(context)
                            .add(const LoadMoreUserReelsEvent(id: null));
                      } else {
                        BlocProvider.of<GetUserReelsBloc>(context).add(
                            LoadMoreUserReelsEvent(
                                id: widget.userData!.id.toString()));
                      }
                    }
                  }else{
                    if (widget.reelsList.length - value == 4) {
                      BlocProvider.of<GetReelsBloc>(context)
                          .add(LoadMoreReelsEvent());
                    }

                  }



                },
                controller: pageController
                ,
              )

            ),

              if (widget.showAppbar)
                Positioned(
                  right: ConfigSize.defaultSize!*1.5,
                  top: ConfigSize.defaultSize!*1.5,
                  child:const UploadVideo()

                )

            ],
          ),
        ),

    )
    );
  }


}
