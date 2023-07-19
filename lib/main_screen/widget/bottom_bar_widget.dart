

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/main_screen/widget/bottom_bar_icon.dart';

class BottomBarWidget extends StatelessWidget {
  final int currentIndex ; 
  final dynamic Function(int) onTap ; 
  const BottomBarWidget({required this.currentIndex , required this.onTap ,   super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
                            decoration:  BoxDecoration(
                              
                                boxShadow: const[
                                  BoxShadow(
                                      color: ColorManager.orang,
                                      spreadRadius: 0,
                                      blurRadius: 1),
                                ],
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(ConfigSize.defaultSize!*2.5),
                                    topRight: Radius.circular(ConfigSize.defaultSize!*2.5))),
                            child: ClipRRect(
                              borderRadius:  BorderRadius.only(
                                   topLeft: Radius.circular(ConfigSize.defaultSize!*2.5),
                                    topRight: Radius.circular(ConfigSize.defaultSize!*2.5)),
                              child: BottomNavigationBar(
                                backgroundColor: Colors.amber,
                                currentIndex: currentIndex,
                                onTap: (index) => onTap(index),
                                showSelectedLabels: true,
                                iconSize: ConfigSize.defaultSize!*3,
                                unselectedItemColor: Theme.of(context).colorScheme.primary,
                                unselectedIconTheme:
                                const IconThemeData(color: Colors.black),
                                showUnselectedLabels: true,
                                selectedItemColor: ColorManager.mainColor,
                                selectedLabelStyle: const TextStyle(
                                  color: ColorManager.mainColor,
                                ),
                                items: const[
                                  BottomNavigationBarItem(
                                      icon:  BottomIcon(icon: AssetsPath.unSelectedHomeIcon,),
                                      activeIcon:  BottomIcon(icon: AssetsPath.homeIcon,),
                                      label:StringManager.home,

                                      
                                      ),
                                      
                                              BottomNavigationBarItem(
                                      icon:  BottomIcon(icon: AssetsPath.unSelectedReelsIcon,),
                                      activeIcon:  BottomIcon(icon: AssetsPath.reelsIcon,),
                                      label:StringManager.reels,

                                      
                                      ),
                                               BottomNavigationBarItem(
                                      icon:  BottomIcon(icon: AssetsPath.unSelectedFollowingIcon,),
                                      activeIcon:  BottomIcon(icon: AssetsPath.followingIcon,),
                                      label:StringManager.follwoing,

                                      
                                      ),
                            
                                            BottomNavigationBarItem(
                                      icon:  BottomIcon(icon: AssetsPath.unSelectedChatIcon,),
                                      activeIcon:  BottomIcon(icon: AssetsPath.chatIcon,),
                                      label:StringManager.chat,

                                      
                                      ),
                                                    BottomNavigationBarItem(
                                      icon:  BottomIcon(icon: AssetsPath.unselectedprofileIcon,),
                                      activeIcon:  BottomIcon(icon: AssetsPath.profileIcon,),
                                      label:StringManager.profile,

                                      
                                      ),
                                ],
                              ),
                            ),
                          );
  }
}