
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/room_screen_controler.dart';
import 'package:get/get.dart';


class ChatCountMessageCometChat extends StatefulWidget {
  final Widget widget ;

 const ChatCountMessageCometChat({required this.widget ,  super.key});

  @override
  State<ChatCountMessageCometChat> createState() => _ChatCountMessageCometChatState();
}

class _ChatCountMessageCometChatState extends State<ChatCountMessageCometChat> {
  late  CometChatConversationsController _controller ;

  @override
  void initState() {
    _controller = CometChatConversationsController(
      conversationsBuilderProtocol:
      UIConversationsBuilder(
        ConversationsRequestBuilder(),
      ), theme: null, );
    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: _controller,
      global: false,
      dispose: (GetBuilderState<CometChatConversationsController> state) =>
          state.controller?.onClose(),
      builder: (CometChatConversationsController value) {
        value.context = context;

        if (value.isLoading){
          return            widget.widget ;

        }else {

        }
        int unreadCount = 0 ;
          for (int i = 0 ; i <value.list.length ; i++){
            unreadCount = unreadCount + (value.list[i].unreadMessageCount??0) ;
          }

          return Stack(children: [
            widget.widget ,
            CometChatBadge(
              count:unreadCount,
              style: BadgeStyle(
                width:  ConfigSize.defaultSize!*1.7,
                height:  ConfigSize.defaultSize!*1.7,
                background: Colors.red,
                borderRadius: 24,
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              )


          )],) ;

      },
    );


  }
}




