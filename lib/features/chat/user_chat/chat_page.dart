
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/widgets/arrow_back.dart';
import 'package:tik_chat_v2/features/chat/user_chat/Logics/functions.dart';
import 'package:tik_chat_v2/features/chat/user_chat/comps/styles.dart';
import 'package:tik_chat_v2/features/chat/user_chat/comps/widgets.dart';

import '../../../core/utils/config_size.dart';
import 'widgets/myprofile_property_row.dart';



class ChatPage extends StatefulWidget {


  const ChatPage({ key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    Functions.updateAvailability();
    Functions.addFireBaseId();
    super.initState();
  }
  static  List<String> chatScreenTitles = [
    StringManager.groupChat.tr(),
    StringManager.appTeam.tr(),
    StringManager.system.tr(),
  ];
  static const List<String> chatScreenIcons = [
    AssetsPath.groupChat,
    AssetsPath.tikTeam,
    AssetsPath.system,
  ];

  final firestore = FirebaseFirestore.instance;
  bool open = false;

  @override
  Widget build(BuildContext context) {
    List<Function()> chatScreenOntaps = [
      () {
        Navigator.pushNamed(context, Routes.groupChatScreen);
      },
      () {
        Navigator.pushNamed(context, Routes.messages);
      },
      () {
        Navigator.pushNamed(context, Routes.systemmessages);
      },
    ];
    Brightness currentBrightness = Theme.of(context).brightness;
    bool isDarkTheme = currentBrightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:  [
                if(ModalRoute.of(context)!.canPop) const ArrowBack(color: ColorManager.darkBlack,),
                Text(StringManager.chat.tr(),
                  style: TextStyle(
                    color: ColorManager.darkBlack,
                    fontWeight: FontWeight.bold,
                    fontSize:  ConfigSize.defaultSize!*2.5,
                  ),
                ),
              ],
            ),
            SizedBox(height: ConfigSize.defaultSize,),

            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, i) {
                  return MyProfilPropertyRow(
                    iconPath: chatScreenIcons[i],
                    title: chatScreenTitles[i],
                    onTap: chatScreenOntaps[i],
                    showIcon: false,
                    descriptiontitle: (i!=1)?null   :  StringManager.officialAccount.tr(),
                  );
                }),



            Expanded(
              child: Container(

                margin: const EdgeInsets.only(top: 10),
                decoration: Styles.friendsBox(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 12.0),
                        child: StreamBuilder(
                            stream: firestore
                                .collection('Rooms')
                                .orderBy('last_message_time',
                                descending: true)
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              List data = !snapshot.hasData
                              ? []
                              : snapshot.data!.docs
                                  .where((element) => element['users']
                                  .toString()
                                  .contains(FirebaseAuth
                                  .instance.currentUser?.uid??''))
                                  .toList();
                              //  List data = data1.reversed.toList();
                              log(FirebaseAuth
                                  .instance.currentUser!.uid.toString());
                              return ListView.builder(
                              // reverse: true,
                              itemCount: data.length,
                              itemBuilder: (context, i) {
                              List users = data[i]['users'];
                              var friend = users.where((element) =>
                              element !=
                              FirebaseAuth.instance.currentUser?.uid);
                              var user = friend.isNotEmpty
                              ? friend.first
                                  : users
                                  .where((element) =>
                              element ==
                              FirebaseAuth.instance
                                  .currentUser!.uid)
                                  .first;
                              return FutureBuilder(
                              future: firestore
                                  .collection('Users')
                                  .doc(user)
                                  .get(),
                              builder:
                              (context, AsyncSnapshot snap) {
                              if (data[i]['sent_by'] !=
                              FirebaseAuth.instance
                                  .currentUser?.uid &&
                              DateFormat('hh:mm:s a').format(
                              data[i]['last_message_time']
                                  .toDate()) ==
                              DateFormat('hh:mm:s a')
                                  .format(
                              DateTime.now())) {
                              print("${DateFormat('hh:mm:s a')
                                  .format(data[i][
                              'last_message_time']
                                  .toDate())}xxxxxxxxxx${DateFormat('hh:mm:s a')
                                  .format(DateTime.now())}");
                              }
                              {}
                              return !snap.hasData
                              ? Container()
                                  : ChatWidgets.card(
                              unReadMessages: data[i]
                              ['unRead'],
                              sentby: data[i]['sent_by'],
                              cheakRead: data[i]['Read'],
                              image: snap.data['image'],
                              title: snap.data['name'],
                              subtitle: data[i]
                              ['last_message'],
                              time: DateFormat('hh:mm a')
                                  .format(data[i][
                              'last_message_time']
                                  .toDate()),
                              onTap: () async {
                              Navigator.pushNamed(
                              context,
                              Routes.chatPageBody,
                              arguments:
                              ChatPageBodyPramiter(
                              chatId: user,
                              name: snap
                                  .data['name'],
                              yayaId:
                              snap.data['id'],
                              image: snap
                                  .data['image'],
                              notificationId: snap
                                  .data[
                              'deviceToken'],
                              myName: MyDataModel.getInstance()
                                  .name!,
                              unReadMessages:
                              data[i]
                              ['unRead'],
                              ));
                              },
                                context: context,
                              );
                              });
                              },
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
