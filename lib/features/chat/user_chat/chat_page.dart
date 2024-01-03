import 'dart:developer';

import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart' as cometchat;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/profile_room_model.dart';

//import 'package:flutter_chat_ui_kit/flutter_chat_ui_kit.dart' as cometchat;
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/widgets/chat-ui.dart';
import 'package:tik_chat_v2/features/chat/user_chat/chat_theme_integration.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/room_screen_controler.dart';
import '../../../core/model/user_data_model.dart';
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

        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: ColorManager.mainColorList)
            ),
            child: Column(
              children: [
                SizedBox(
                  height: ConfigSize.screenHeight! * .020,
                ),
                Center(
                  child: Text(
                    StringManager.chat.tr(),
                    style: TextStyle(
                      color: ColorManager.darkBlack,
                      fontWeight: FontWeight.bold,
                      fontSize: ConfigSize.defaultSize! * 1.5,
                    ),
                  ),
                ),

                SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: ConfigSize.screenHeight! * .05,
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

                            );
                          }),
                    ],
                  ),
                ),

              ],
            ),
          ),
          ChatThemeIntegration.disableChat ?

          Expanded(child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(StringManager.chatWillBeAvailable.tr()),
                Text(StringManager.stayTuned.tr()),
              ],),
          )) :

          Expanded(

              child: CometChatConversationsWithMessages(
                messageConfiguration: MessageConfiguration(
                    messageListConfiguration: (MessageListConfiguration(

                        showAvatar: true,
                        theme: CometChatTheme(
                            palette: ChatUi().palette,
                            typography: ChatUi().typography)
                    )),
                    messageHeaderConfiguration: MessageHeaderConfiguration(

                      appBarOptions: (user, group, context) {
                        return [
                          IconButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, Routes.profileChatDetails,
                                    arguments: UserDataModel(name: user!.name,
                                        id: int.parse(user.uid),
                                        profile: ProfileRoomModel(
                                            image: user.avatar)));
                              },
                              icon: const Icon(Icons.more_horiz)),
                        ];
                      },
                      backButton: (context) {
                        return IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios));
                      },
                      avatarStyle: const AvatarStyle(
                        height: 0,
                        width: 0,

                      ),

                      messageHeaderStyle: MessageHeaderStyle(
                        height: ConfigSize.defaultSize! * 6,
                        backButtonIconTint: ColorManager.darkBlack,
                        typingIndicatorTextStyle: const TextStyle(
                          color: ColorManager.darkBlack,
                        ),
                      ),

                    )
                ),
                conversationsConfiguration: ConversationsConfiguration(

                    theme: CometChatTheme(
                        palette: Palette(
                          accent: PaletteModel(light: Theme
                              .of(context)
                              .colorScheme
                              .primary, dark: Colors.white),
                        ), typography: ChatUi().typography

                    ),

                    badgeStyle: BadgeStyle(
                        background: Colors.red,
                        textStyle: TextStyle(
                            fontSize: ConfigSize.defaultSize! * 1.3)),
                    dateStyle: DateStyle(
                        border: Border.all(color: Colors.transparent),
                        background: Colors.transparent

                    ),

                    conversationsStyle: ConversationsStyle(
                      background: Theme
                          .of(context)
                          .colorScheme
                          .background,
                    ),

                    showBackButton: false,
                    title: '',
                    appBarOptions: []),
                // theme:
                //     CometChatTheme(palette: _palette, typography: _typography),
              )),


        ],
      ),
    );
  }
}
