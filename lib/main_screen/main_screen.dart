import 'dart:developer';

import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/features/chat/persentation/chat_screen.dart';
import 'package:tik_chat_v2/features/following/persentation/following_live_screen.dart';
import 'package:tik_chat_v2/features/home/presentation/home_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/profile_screen.dart';
import 'package:tik_chat_v2/features/reels/persentation/reels_screen.dart';

import 'widget/bottom_bar_widget.dart';

class MainScreen extends StatefulWidget {
  final bool? isChachGift ;
  final bool? isCachFrame ;
  final bool? isCachExtra ;
  final bool? isCachEntro ;
  final bool? isCachEmojie ;
  final bool? isUpdate ;

  const MainScreen({
  this.isCachFrame,
  this.isUpdate,
  this.isCachExtra,
  this.isChachGift,
  this.isCachEntro,
  this.isCachEmojie,
  super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
  static int initPage = 0;
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {

    Methods().KeepUserLogin(KeepInLogin: true);
    listenToInternet();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BottomNavLayout(
        pages: [
          (_) => HomeScreen(
            isCachExtra: widget.isCachExtra,
            isCachFrame: widget.isCachFrame,
            isChachGift: widget.isChachGift,
            isUpdate: widget.isUpdate,
            isCachEmojie: widget.isCachEmojie,
            isCachEntro: widget.isCachEntro,
          ),
          (_) => const ReelsScreen(),
          (_) => const FollowingLiveScreen(),
          (_) => const ChatScreen(),
          (_) => const ProfileScreen(),
        ],
        bottomNavigationBar: (currentIndex, onTap) => BottomBarWidget(
          currentIndex: currentIndex,
          onTap: onTap,
        ),
        savePageState: true,
        lazyLoadPages: true,
        pageStack: ReorderToFrontPageStack(initialPage: MainScreen.initPage),
        extendBody: false,
        resizeToAvoidBottomInset: true,
        pageTransitionData: null,
      ),
    );
  }

  listenToInternet() {
    Connectivity().onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.wifi ||
          event == ConnectivityResult.mobile) {
        log("Connectivity");
        //todo add all main evens here
        BlocProvider.of<GetMyDataBloc>(context).add(GetMyDataEvent());
      } else if (event == ConnectivityResult.none) {
        // todo show dialog or toast here
      }
    });
  }
}
