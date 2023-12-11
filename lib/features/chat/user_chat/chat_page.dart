import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart' as cometchat;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//import 'package:flutter_chat_ui_kit/flutter_chat_ui_kit.dart' as cometchat;
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/chat_auth_manager/log_in_chat/login_chat_state.dart';

import '../../../core/utils/config_size.dart';
import '../../auth/presentation/manager/chat_auth_manager/log_in_chat/login_chat_bloc.dart';
import 'widgets/myprofile_property_row.dart';

class ChatPage extends StatefulWidget {

  const ChatPage({key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {

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


    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
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

                Expanded(

    child: const CometChatConversationsWithMessages(



    conversationsConfiguration: ConversationsConfiguration(




    showBackButton: false, title: '', appBarOptions: []),
    // theme:
    //     CometChatTheme(palette: _palette, typography: _typography),
    )),





        ],
      ),
    );
  }
}
