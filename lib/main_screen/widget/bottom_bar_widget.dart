

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
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
                                items: [
                                  BottomNavigationBarItem(
                                      icon:  const BottomIcon(icon: AssetsPath.unSelectedHomeIcon,),
                                      activeIcon:  const BottomIcon(icon: AssetsPath.homeIcon,),
                                      label:StringManager.home.tr(),

                                      
                                      ),
                                      
                                              BottomNavigationBarItem(
                                      icon:  const BottomIcon(icon: AssetsPath.unSelectedReelsIcon,),
                                      activeIcon:  const BottomIcon(icon: AssetsPath.reelsIcon,),
                                      label:StringManager.reels.tr(),

                                      
                                      ),
                                               BottomNavigationBarItem(
                                      icon:  const BottomIcon(icon: AssetsPath.unSelectedFollowingIcon,),
                                      activeIcon:  const BottomIcon(icon: AssetsPath.followingIcon,),
                                      label:StringManager.follwoing.tr(),

                                      
                                      ),
                            
                                            BottomNavigationBarItem(
                                      icon:  const BottomIcon(icon: AssetsPath.unSelectedChatIcon,),
                                      activeIcon:  const BottomIcon(icon: AssetsPath.chatIcon,),
                                      label:StringManager.momentTab.tr(),

                                      
                                      ),
                                                    BottomNavigationBarItem(
                                      icon:  StreamBuilder(
                                          stream: FirebaseAuth.instance.authStateChanges(),

                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection('Rooms')
                                                  .orderBy('last_message_time', descending: true)
                                                  .snapshots(),
                                              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                List data = !snapshot.hasData
                                                ? []
                                                : snapshot.data!.docs
                                                    .where((element) => element['users']
                                                    .toString()
                                                    .contains(FirebaseAuth.instance.currentUser!.uid))
                                                    .toList();

                                                int totalMessages = 0;
                                                int temp = 0;
                                                for (int i = 0; i < data.length; i++) {
                                                if (data[i]['sent_by'] !=
                                                FirebaseAuth.instance.currentUser!.uid) {
                                                totalMessages = data[i]['unRead'];
                                                temp += totalMessages;
                                                }
                                                }
                                              return Stack(


                                                children: [
                                              if (temp != 0)

                                                Container(

                                              padding:const EdgeInsets.all(4),
                                                decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.red),

                                                ),

                                                  const BottomIcon(icon: AssetsPath.unselectedprofileIcon,),


                                                ],
                                              );
                                            }
                                          );
                                            }else  {
                                              return                                                   const BottomIcon(icon: AssetsPath.unselectedprofileIcon,);

                                          }
                                        }
                                      ),
                                      activeIcon:  const BottomIcon(icon: AssetsPath.profileIcon,),
                                      label:StringManager.profile.tr(),

                                      
                                      ),
                                ],
                              ),
                            ),
                          );
  }
}