

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
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


   // to know iam in user view or not
  final bool? userView; 

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
    this.userView,
  }) : super(key: key);

  @override
  State<ReelsViewer> createState() => _ReelsViewerState();
}

class _ReelsViewerState extends State<ReelsViewer> {
  SwiperController controller = SwiperController();

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
      backgroundColor: Colors.black26,
      body: SafeArea(
        child: SizedBox(
          
          child: Stack(
            children: [
              //We need swiper for every content
              Padding(
                padding: EdgeInsets.only(top: ConfigSize.defaultSize!*6.4),
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
                    );
                  },
                  controller: controller,
                  itemCount: widget.reelsList.length,
                  scrollDirection: Axis.vertical,
                  onIndexChanged: widget.onIndexChanged,
                ),
              ),
              if (widget.showAppbar)
                Container(
                  height: ConfigSize.defaultSize!*6.4,
                  color: Colors.black26,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
        
                      SizedBox(
                        width: ConfigSize.defaultSize!*2.4,
                      ),
        
        
                      Text(
                        widget.appbarTitle ?? 'Reels View',
                        style:  TextStyle(
                          fontSize: ConfigSize.defaultSize!*2.2,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                        ),
                      ),
        
        
                    IconButton(onPressed: (){
                       Navigator.pushNamed(context, Routes.uploadReels);
                    }, icon: Icon(Icons.add , color: Colors.white, size: ConfigSize.defaultSize!*3,))
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
