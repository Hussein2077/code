

import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/features/chat/persentation/chat_screen.dart';
import 'package:tik_chat_v2/features/following/persentation/following_live_screen.dart';
import 'package:tik_chat_v2/features/home/presentation/home_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/profile_screen.dart';
import 'package:tik_chat_v2/features/reels/persentation/reels_screen.dart';


import 'widget/bottom_bar_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
   static int initPage = 0 ;

}

class _MainScreenState extends State<MainScreen> {
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
    body:  BottomNavLayout(
    
                          pages: [
                                (_) => const HomeScreen(),

                                (_) => const ReelsScreen(), 
                                (_) => const FollowingLiveScreen(),
                                (_) => const ChatScreen(),
                                                                (_) => const ProfileScreen(),

                          ],
                          bottomNavigationBar: (currentIndex, onTap) => BottomBarWidget(currentIndex: currentIndex, onTap: onTap,),
                          savePageState: true,
                          lazyLoadPages: true,
                          // StandardPageStack, ReorderToFrontExceptFirstPageStack, NoPageStack, FirstAndLastPageStack
                          pageStack: ReorderToFrontPageStack(initialPage:MainScreen.initPage),
                          extendBody: false,
                          resizeToAvoidBottomInset: true,
                          pageTransitionData: null,
                        ),


    );
  }
}