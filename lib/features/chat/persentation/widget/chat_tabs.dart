import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

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
              StringManager.messages.tr(),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(StringManager.friends.tr(),
                style: Theme.of(context).textTheme.headlineLarge),
          ]),
    );
  }
}
