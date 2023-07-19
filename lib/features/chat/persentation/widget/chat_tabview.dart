

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/features/chat/persentation/widget/chat_body.dart';
import 'package:tik_chat_v2/features/chat/persentation/widget/friends_body.dart';

class ChatTabView extends StatelessWidget {
    final TabController chatController;

  const ChatTabView({required this.chatController ,  super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: 
    TabBarView(
      controller: chatController,
      children: [
        ChatBody(),
        FriendsBody()

    ],)
    );
  }
}