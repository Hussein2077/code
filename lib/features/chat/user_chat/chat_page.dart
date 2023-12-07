import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart' as cometchat;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

//import 'package:flutter_chat_ui_kit/flutter_chat_ui_kit.dart' as cometchat;
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/features/chat/user_chat/Logics/functions.dart';

import '../../../core/utils/config_size.dart';
import 'widgets/myprofile_property_row.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({key}) : super(key: key);

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

  static List<String> chatScreenTitles = [
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

  // cometchat.Typography _typography = fl.Typography.fromDefault(
  //     name: FontStyle(fontSize: 22, fontWeight: FontWeight.w400));
  final Palette _palette = const Palette(
      accent: PaletteModel(light: Colors.red, dark: Colors.green));
  final cometchat.Typography _typography = cometchat.Typography.fromDefault();

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


    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              // if(ModalRoute.of(context)!.canPop) const ArrowBack(color: ColorManager.darkBlack,),
              Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: ColorManager.mainColorList)
                ),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        StringManager.chat.tr(),
                        style: TextStyle(
                          color: ColorManager.darkBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: ConfigSize.defaultSize! * 1.2,
                        ),
                      ),
                    ),
                    SizedBox(
                        width: ConfigSize.screenWidth!-3,
                        height: ConfigSize.screenHeight!*.06,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 3,
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, i) {
                                return MyProfilPropertyRow(
                                  iconPath: chatScreenIcons[i],
                                  title: chatScreenTitles[i],
                                  onTap: chatScreenOntaps[i],
                                  showIcon: false,
                                  descriptiontitle: (i != 1)
                                      ? null
                                      : StringManager.officialAccount.tr(),
                                );
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Expanded(
          //   child: Container(
          //     decoration: Styles.friendsBox(),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Expanded(
          //           child: Padding(
          //             padding: const EdgeInsets.symmetric(horizontal: 12.0),
          //             child: StreamBuilder(
          //                 stream: firestore
          //                     .collection('Rooms')
          //                     .orderBy('last_message_time', descending: true)
          //                     .snapshots(),
          //                 builder:
          //                     (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //                   List data = !snapshot.hasData
          //                       ? []
          //                       : snapshot.data!.docs
          //                           .where((element) => element['users']
          //                               .toString()
          //                               .contains(FirebaseAuth
          //                                       .instance.currentUser?.uid ??
          //                                   ''))
          //                           .toList();
          //                   //  List data = data1.reversed.toList();
          //                   log(FirebaseAuth.instance.currentUser!.uid
          //                       .toString());
          //                   return ListView.builder(
          //                     // reverse: true,
          //                     itemCount: data.length,
          //                     padding: EdgeInsets.zero,
          //                     itemBuilder: (context, i) {
          //                       List users = data[i]['users'];
          //                       var friend = users.where((element) =>
          //                           element !=
          //                           FirebaseAuth.instance.currentUser?.uid);
          //                       var user = friend.isNotEmpty
          //                           ? friend.first
          //                           : users
          //                               .where((element) =>
          //                                   element ==
          //                                   FirebaseAuth
          //                                       .instance.currentUser!.uid)
          //                               .first;
          //                       return FutureBuilder(
          //                           future: firestore
          //                               .collection('Users')
          //                               .doc(user)
          //                               .get(),
          //                           builder: (context, AsyncSnapshot snap) {
          //                             if (data[i]['sent_by'] !=
          //                                     FirebaseAuth
          //                                         .instance.currentUser?.uid &&
          //                                 DateFormat('hh:mm:s a').format(data[i]
          //                                             ['last_message_time']
          //                                         .toDate()) ==
          //                                     DateFormat('hh:mm:s a')
          //                                         .format(DateTime.now())) {}
          //                             {}
          //                             return !snap.hasData
          //                                 ? Container()
          //                                 : ChatWidgets.card(
          //                                     unReadMessages: data[i]['unRead'],
          //                                     sentby: data[i]['sent_by'],
          //                                     cheakRead: data[i]['Read'],
          //                                     image: snap.data['image'],
          //                                     title: snap.data['name'],
          //                                     subtitle: data[i]['last_message'],
          //                                     time: DateFormat('hh:mm a')
          //                                         .format(data[i]
          //                                                 ['last_message_time']
          //                                             .toDate()),
          //                                     onTap: () async {
          //                                       Navigator.pushNamed(context,
          //                                           Routes.chatPageBody,
          //                                           arguments:
          //                                               ChatPageBodyPramiter(
          //                                             chatId: user,
          //                                             name: snap.data['name'],
          //                                             yayaId: snap.data['id'],
          //                                             image: snap.data['image'],
          //                                             notificationId: snap
          //                                                 .data['deviceToken'],
          //                                             myName: MyDataModel
          //                                                     .getInstance()
          //                                                 .name!,
          //                                             unReadMessages: data[i]
          //                                                 ['unRead'],
          //                                           ));
          //                                     },
          //                                     context: context,
          //                                   );
          //                           });
          //                     },
          //                   );
          //                 }),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 170,
              child: CometChatConversationsWithMessages(

                messageConfiguration: MessageConfiguration(

                ),
                conversationsConfiguration: const ConversationsConfiguration(
                    showBackButton: false, title: '', appBarOptions: [],

                ),
                theme:
                    CometChatTheme(palette: _palette, typography: _typography),
              )),
        ],
      ),
    );
  }
}
