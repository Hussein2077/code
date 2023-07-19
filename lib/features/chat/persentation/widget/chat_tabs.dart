import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';

class ChatTabs extends StatelessWidget {
  final TabController chatController;
  const ChatTabs({required this.chatController, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.6,
      child: TabBar(
          indicatorColor: ColorManager.orang,
         indicatorPadding:EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!*5) ,
          controller: chatController,
          tabs: [
            Text(
              StringManager.messages,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(StringManager.friends,
                style: Theme.of(context).textTheme.headlineLarge),
          ]),
    );
  }
}
