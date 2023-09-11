
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_reels/get_user_reels_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_reels/get_user_reels_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_reels/get_user_reels_state.dart';
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
    scrollController.addListener(scrollListener);

    
    super.initState();
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
