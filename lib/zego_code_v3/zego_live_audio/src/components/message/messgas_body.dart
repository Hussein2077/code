

import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/message/defines.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/message/message_view.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/screen_util/core/size_extension.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/defines/message.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/defines/user.dart';

class MessagesBody extends StatefulWidget {

  final Stream<List<ZegoInRoomMessage>> stream;
  final ZegoInRoomMessageItemBuilder itemBuilder;
  final List<ZegoInRoomMessage> historyMessages;
  final ScrollController scrollController;
  final EnterRoomModel room;

  const MessagesBody({Key? key,
    required this.stream,
    required this.itemBuilder,
    required this.historyMessages,
    required this.scrollController,
    required this.room
  }) : super(key: key);

  @override
  _MessagesBodyState createState() => _MessagesBodyState();
}

class _MessagesBodyState extends State<MessagesBody> {
  //todo update that
  List<ZegoInRoomMessage> messagesNotifier = [
    ZegoInRoomMessage(user: ZegoUIKitUser(name: '',id: '-1',) , message: 'pp'   ,   timestamp: -1  ,  messageID: 1 ),
    ZegoInRoomMessage(user: ZegoUIKitUser(name: '',id: '-2',) , message: 'ppuu' ,   timestamp: -2  ,  messageID:4  )
  ];
  StreamSubscription<dynamic>? streamSubscription;


  @override
  void initState() {
    streamSubscription = widget.stream.listen(onMessageUpdate);
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();

    messagesNotifier.clear();
    streamSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      shrinkWrap: true,
      controller:widget.scrollController,
      itemCount: messagesNotifier.length,
      itemBuilder: (context, index) {
        if(index == 0){
          return Row(
            children: [
              SizedBox(width: 50.zW, height: 50.zH, child: Image.asset(AssetsPath.iconApp)),
              SizedBox(
                width: 10.zW,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10.zR),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.zR),
                    color: ColorManager.roomComment.withOpacity(0.3),
                  ),
                  child: Text(
                    overflow: TextOverflow.visible,
                    "${widget.room.roomRule}",
                    style: TextStyle(color: ColorManager.textRoomComment ,fontSize: 24.zSP),
                  ),

                ),
              )
            ],
          );
        }else if (index == 1){
          return Padding(padding: EdgeInsets.symmetric(
          vertical:   20.zR
          ),
          child: Row(
            children: [
              SizedBox(width: 50.zW, height: 50.zH,
                  child: Image.asset(AssetsPath.roomIntroMessageIcon)),
              SizedBox(
                width: 10.zW,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10.zR),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.zR),
                    color: ColorManager.roomComment.withOpacity(0.3),
                  ),
                  child: Text(
                    overflow: TextOverflow.visible,
                    "${StringManager.roomIntro.tr()} \n ${widget.room.roomIntro}",
                    style: TextStyle(color: ColorManager.textRoomComment2 ,fontSize: 24.zSP),
                  ),
                ),
              )
            ],
          ),
          ) ;
        }else{
          return widget.itemBuilder.call(context, messagesNotifier[index],{});
        }},
    );

  }


  void onMessageUpdate(List<ZegoInRoomMessage> messages) {
    messages.insertAll(0, [
      ZegoInRoomMessage(user: ZegoUIKitUser(name: '',id: '-1',),message: 'dumy', timestamp: -1 ,messageID: -1),
      ZegoInRoomMessage(user: ZegoUIKitUser(name: '',id: '-2',),message: 'dumy2', timestamp: -2 ,messageID: -4)
    ]);
    messagesNotifier = messages;


    Future.delayed(const Duration(milliseconds: 100), () {
      if (messagesNotifier.isEmpty) {
        return;
      }
      setState(() {

      });
      if (ZegoInRoomMessageViewState.scrollController.position.maxScrollExtent -
          ZegoInRoomMessageViewState.scrollController.position.pixels < 400.zH ) {
        widget.scrollController.jumpTo(widget.scrollController.position.maxScrollExtent);
      }
    });
  }
}
