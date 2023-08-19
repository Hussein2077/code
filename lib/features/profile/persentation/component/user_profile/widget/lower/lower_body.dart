

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/gift_history_manger/gift_history_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/gift_history_manger/gift_history_event.dart';
import 'profile_tab_view_body.dart';
import 'profile_tabs.dart';
import 'reels_tab_view_body.dart';


class LowerProfileBody extends StatefulWidget {
    final UserDataModel userDataModel ;
     final bool myProfile; 

  const LowerProfileBody({required this.myProfile ,  required this.userDataModel ,  super.key});

  @override
  State<LowerProfileBody> createState() => _LowerProfileBodyState();
}

class _LowerProfileBodyState extends State<LowerProfileBody> with TickerProviderStateMixin {
  late TabController profileController ; 
  @override
  void initState() {
        BlocProvider.of<GiftHistoryBloc>(context).add(GetGiftHistory(id: widget.userDataModel.id.toString()));

    profileController = TabController(length: 2, vsync: this);
    super.initState();
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
            const ReelsTabView()
      
        ]),
      ),
    ],);
  }
}