import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/dynamic_link.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/follow_manger/bloc/follow_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/follow_manger/bloc/follow_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reels/get_reels_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reels/get_reels_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reels/get_reels_state.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_make_reel_like/make_reel_like_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_make_reel_like/make_reel_like_event.dart';
import 'package:tik_chat_v2/features/reels/persentation/widgets/reels_viewer.dart';
import 'package:tik_chat_v2/main_screen/main_screen.dart';

class ReelsScreen extends StatefulWidget {
  
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => ReelsScreenState();
}

class ReelsScreenState extends State<ReelsScreen> {
 static List<int> likedVideos = [];
 static Map<String,dynamic> mapCachedReels  = {};

  @override
  void initState() {
    likedVideos = [];
    if(MainScreen.initPage ==1){
      BlocProvider.of<GetReelsBloc>(context).add(GetReelsEvent(reelId:MainScreen.reelId));
    }else{
      BlocProvider.of<GetReelsBloc>(context).add(GetReelsEvent());
    }

    initCachingReels();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<GetReelsBloc, GetReelsState>(
      builder: (context, state) {
        if(state is GetReelsSucssesState){
       return ReelsViewer(
          reelsList: state.data!,
          appbarTitle: StringManager.reels,
          onShare: (reel) {
            DynamicLinkProvider().showReelLink(
                reelId: reel.id!,
              reelImage: reel.userImage!,
            ).then((value) {
              Share.share(value);
            });
            log('Shared reel url ==> ${reel.id}');
          },
          onLike: (id) {
       BlocProvider.of<MakeReelLikeBloc>(context).add(MakeReelLikeEvent(reelId: id.toString()));

            setState(() {
              likedVideos.add(id);
            });
           
          },
          onFollow: (userId, isFollow) {
            log("tttttttttttttttt");
            if(isFollow){
              BlocProvider.of<FollowBloc>(context).add(UnFollowEvent(userId: userId));
            }else{
              BlocProvider.of<FollowBloc>(context).add(FollowEvent(userId: userId));
            }

          },
          onComment: (comment) {
            log('Comment on reel ==> $comment');
          },
          onClickMoreBtn: () {
            log('======> Clicked on more option <======');
          },
          onClickBackArrow: () {
            log('======> Clicked on back arrow <======');
          },
          onIndexChanged: (index) {
          if(state.data!.length-index<5){
            BlocProvider.of<GetReelsBloc>(context).add(LoadMoreReelsEvent());
          }
          log(state.data!.length.toString());
            log('======> Current Index ======> $index <========');
          },
          showProgressIndicator: false,
          showVerifiedTick: false,
          showAppbar: true,
        );
        }else if (state is GetReelsLoadingState){
          return const LoadingWidget();
        }else if (state is GetReelsErrorState){
          return CustomErrorWidget(message: state.errorMassage);
        }else {
      return    CustomErrorWidget(message: StringManager.unexcepectedError.tr());
        }
   
      },
    ));
  }

Future<void>  initCachingReels() async{

  Map<String,dynamic> cachedReels = await Methods().getCachingReels();
  mapCachedReels =cachedReels ;

}

}
