import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/dynamic_link.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

import 'profile_row_item.dart';

class Card2 extends StatelessWidget {
  final bool isDarkTheme;
  final MyDataModel myData;

  const Card2({required this.isDarkTheme, required this.myData, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width - 30,
        //height: ConfigSize.defaultSize! * 20,
        decoration: BoxDecoration(
            color: isDarkTheme ? Colors.grey.withOpacity(0.3) : Colors.white,
            borderRadius: BorderRadius.circular(ConfigSize.defaultSize!)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ProfileRowItem(
              title: StringManager.games.tr(),
              image: AssetsPath.gamesIcon,
              onTap: () => Navigator.pushNamed(context, Routes.games),
            ),
            if (StringManager.userType[1]! ||
                StringManager.userType[2]! ||
                StringManager.userType[4]! ||
                StringManager.userType[6]!)
              ProfileRowItem(
                title: StringManager.agency.tr(),
                image: AssetsPath.agencyIcon,
                onTap: () => Navigator.pushNamed(context, Routes.agencyScreen,
                    arguments: myData),
              ),
                    if (StringManager.userType[3]! || StringManager.userType[6]!)
              ProfileRowItem(
                title: StringManager.chargingFromTheSystem.tr(),
                image: AssetsPath.agencyIcon,
                onTap: () => Navigator.pushNamed(context, Routes.charchingCoinsForUsers,
                    arguments: myData),
              ),
            StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),

                builder: (context, snapshot){
                  if(snapshot.hasData) {
                    return StreamBuilder(
                  stream:  FirebaseFirestore.instance
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

                        ProfileRowItem(
                          title: StringManager.chat.tr(),
                          image: AssetsPath.chatIcon,
                          onTap: () => Navigator.pushNamed(context, Routes.chatScreen),
                        ),
                        if(temp!=0)
                        Container(
                        padding:const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red),
                      child: Text(
                      '${temp}',
                      style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                      ),
                      )
                      ],
                    );
                  }
                );
                  }else {
               return     ProfileRowItem(
                      title: StringManager.chat.tr(),
                      image: AssetsPath.chatIcon,

                    );
                  }
              }
            ),
            ProfileRowItem(
              title: StringManager.family.tr(),
              image: AssetsPath.familyIcon,
              onTap: () => Navigator.pushNamed(context, Routes.familyRanking),
            ),
            /* const ProfileRowItem(
              title: StringManager.rechargeHistory,
              image: AssetsPath.rechargeHistoryIcon,
            ),*/

            ProfileRowItem(
              title: StringManager.income.tr(),
              image: AssetsPath.incomeIcon,
              onTap: () => Navigator.pushNamed(context, Routes.incomeScreen),
            ),
            //  ProfileRowItem(
            //   title: StringManager.inviteFriend.tr(),
            //   image: AssetsPath.inviteFriendsIcon,
            //    onTap: (){
            //
            //      DynamicLinkProvider().creatInvetaionUserLink(
            //         userId: myData.id!,
            //          userImage: myData.profile!.image!)
            //          .then((value) {
            //        Share.share(value);
            //      });
            //    },
            // ),
          ],
        ));
  }
}
