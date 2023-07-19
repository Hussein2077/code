

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/features/chat/persentation/widget/chat_tabs.dart';

import 'widget/chat_tabview.dart';

class ChatScreen extends StatefulWidget {

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>with TickerProviderStateMixin {
  late TabController chatController ; 
  @override
  void initState() {
    chatController = TabController(length: 2 , vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Theme.of(context).colorScheme.background,
body: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [


SizedBox(height: ConfigSize.defaultSize!*5,),
  ChatTabs(chatController: chatController,),
  SizedBox(height: ConfigSize.defaultSize!*2,),

  ChatTabView(chatController: chatController,)


],),

    );
  }
}