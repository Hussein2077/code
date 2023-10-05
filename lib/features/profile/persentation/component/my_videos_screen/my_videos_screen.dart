import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/my_videos_screen/widgets/reels_box.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_reels/get_user_reels_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_reels/get_user_reels_event.dart';

class MyVideosScreen extends StatefulWidget {
  final UserDataModel userDataModel;

  const MyVideosScreen({required this.userDataModel, super.key});

  @override
  State<MyVideosScreen> createState() => _MyVideosScreenState();
}

class _MyVideosScreenState extends State<MyVideosScreen> {
  late ScrollController scrollController ;
  @override
  void initState() {
               BlocProvider.of<GetUserReelsBloc>(context)
          .add(const GetUserReelEvent(id: null));
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, Routes.uploadReels);
          }, icon: Icon(Icons.add , color: Theme.of(context).colorScheme.primary, ))
        ],
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          StringManager.myVideos,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: ConfigSize.defaultSize! * 2 , ),
        ),
      ),
      body: ReelsBox(
          userDataModel: widget.userDataModel,
          scrollController: scrollController),
    );
  }

  void scrollListener() {

    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (widget.userDataModel.id == MyDataModel.getInstance().id) {
        BlocProvider.of<GetUserReelsBloc>(context)
            .add(const LoadMoreUserReelsEvent(id: null));
      } else {
        BlocProvider.of<GetUserReelsBloc>(context).add(
            LoadMoreUserReelsEvent(id: widget.userDataModel.id.toString()));
      }
    } else {}
  }
}
