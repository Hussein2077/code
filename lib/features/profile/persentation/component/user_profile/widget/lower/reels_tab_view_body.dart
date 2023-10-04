
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/user_profile/widget/lower/lower_body.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_reels/get_user_reels_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_reels/get_user_reels_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/my_videos_screen/widgets/reels_box.dart';

class ReelsTabView extends StatefulWidget {
      final UserDataModel userDataModel ;


  const ReelsTabView({required this.userDataModel,  super.key});

  @override
  State<ReelsTabView> createState() => _ReelsTabViewState();
}

class _ReelsTabViewState extends State<ReelsTabView> {
    final ScrollController scrollController = ScrollController();
    @override
     void initState() {
    if(LowerProfileBody.getUserReels){
       BlocProvider.of<GetUserReelsBloc>(context)
          .add(GetUserReelEvent(id:  widget.userDataModel.id.toString()));
    }
     
    scrollController.addListener(scrollListener);

    
    super.initState();
  }
  @override
  void dispose() {
      LowerProfileBody.getUserReels = false ;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ReelsBox(userDataModel: widget.userDataModel,scrollController: scrollController, );

  }
   void scrollListener() {

    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
          if(widget.userDataModel.id == MyDataModel.getInstance().id ){
    BlocProvider.of<GetUserReelsBloc>(context)
          .add(const LoadMoreUserReelsEvent(id:  null));
          }else {
        BlocProvider.of<GetUserReelsBloc>(context)
          .add(LoadMoreUserReelsEvent(id:  widget.userDataModel.id.toString()));
          }
      
      
    } else {}
  }
}
