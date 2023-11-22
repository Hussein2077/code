

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/gift_history_manger/gift_history_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/gift_history_manger/gift_history_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_reels/get_user_reels_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_reels/get_user_reels_event.dart';

import 'profile_tab_view_body.dart';
import 'profile_tabs.dart';
import 'reels_tab_view_body.dart';


class LowerProfileBody extends StatefulWidget {
    final UserDataModel userDataModel ;
     final bool myProfile; 
     static bool getUserReels = true ; 

  const LowerProfileBody({required this.myProfile ,  required this.userDataModel ,  super.key});

  @override
  State<LowerProfileBody> createState() => _LowerProfileBodyState();
}

class _LowerProfileBodyState extends State<LowerProfileBody> with TickerProviderStateMixin {
  late TabController profileController ; 
  @override
  void initState() {
    LowerProfileBody.getUserReels = true ; 
        BlocProvider.of<GiftHistoryBloc>(context).add(GetGiftHistory(id: widget.userDataModel.id.toString()));


    profileController = TabController(length: 2, vsync: this);
    if(!widget.myProfile){
      profileController.index=1;
    }
    super.initState();
  }
  @override
  void didChangeDependencies() {
    BlocProvider.of<GetUserReelsBloc>(context).add(const InitialReelEvent());
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: ConfigSize.defaultSize!*2,),
      ProfileTabs(profileController: profileController,),
            SizedBox(height: ConfigSize.defaultSize!*2,),

      SizedBox(
        height: MediaQuery.of(context).size.height/2.4,
        child: TabBarView(
          controller: profileController,
           children: [
            ProfileTabViewBody(userDataModel:widget.userDataModel),
            ReelsTabView(userDataModel: widget.userDataModel,)
        ]),
      ),
    ],);
  }
}