// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/pk_functions.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/components/message/messgas_body.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/message/defines.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/screen_util/core/size_extension.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/services.dart';
import 'dart:ui' as ui;

/// @nodoc
class ZegoInRoomMessageView extends StatefulWidget {
  final Stream<List<ZegoInRoomMessage>> stream;

  /// messages before stream broadcast
  final List<ZegoInRoomMessage> historyMessages;

  final ZegoInRoomMessageItemBuilder itemBuilder;

  final bool scrollable;
  final ScrollController? scrollController;
  final EnterRoomModel room ;

  const ZegoInRoomMessageView({
    Key? key,
    required this.stream,
    required this.itemBuilder,
    this.scrollable = true,
    this.scrollController,
    required this.room,
    this.historyMessages = const [],
  }) : super(key: key);

  @override
  State<ZegoInRoomMessageView> createState() => ZegoInRoomMessageViewState();
}

/// @nodoc
class ZegoInRoomMessageViewState extends State<ZegoInRoomMessageView> {
  static ScrollController scrollController = ScrollController();
  late ProfanityFilter filter;

  @override
  void initState() {
    super.initState();

    filter = ProfanityFilter.filterAdditionally(StringManager.arabicBadWords);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });

    scrollController = widget.scrollController ?? ScrollController();
  }


  @override
  Widget build(BuildContext context) {
   // messagesNotifier.value = widget.historyMessages;
    return Directionality(
        textDirection: ui.TextDirection.rtl,
        child:  MediaQuery.removePadding(
                context: context,
                removeTop: true,
                removeBottom: true,
                child: ValueListenableBuilder(
                  valueListenable: PkController.isPK,
                  builder: (context,isShowPK,_){

                    return ConstrainedBox(
                      constraints: RoomScreen.layoutMode ==
                          LayoutMode.hostTopCenter
                          ? isShowPK
                          ? BoxConstraints.loose(Size(
                        650.zR, 485.zR,
                    ))
                          : BoxConstraints.loose(Size(650.zR, 550.zR,))
                          : BoxConstraints.loose(Size(650.zR, 435.zR,)),
                      child: MessagesBody(stream: widget.stream,itemBuilder: widget.itemBuilder,
                        historyMessages: widget.historyMessages, scrollController: scrollController,
                        room: widget.room,)


                      // SingleChildScrollView(
                      //   controller: scrollController,
                      //   child: Column(
                      //     children: [
                      //       Row(
                      //         children: [
                      //           SizedBox(width: 50.zW, height: 50.zH, child: Image.asset(AssetsPath.iconApp)),
                      //           SizedBox(
                      //             width: 10.zW,
                      //           ),
                      //           Expanded(
                      //             child: Container(
                      //               padding: EdgeInsets.all(10.zR),
                      //               decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(20.zR),
                      //                 color: ColorManager.roomComment.withOpacity(0.3),
                      //               ),
                      //               child: Text(
                      //                 overflow: TextOverflow.visible,
                      //                 "${widget.room.roomRule}",
                      //                 style: TextStyle(color: ColorManager.textRoomComment ,fontSize: 24.zSP),
                      //               ),
                      //
                      //             ),
                      //           )
                      //         ],
                      //       ),
                      //       SizedBox(height: 10.zH,),
                      //       Row(
                      //         children: [
                      //           SizedBox(width: 50.zW, height: 50.zH,
                      //               child: Image.asset(AssetsPath.roomIntroMessageIcon)),
                      //           SizedBox(
                      //             width: 10.zW,
                      //           ),
                      //           Expanded(
                      //             child: Container(
                      //               padding: EdgeInsets.all(10.zR),
                      //               decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(20.zR),
                      //                 color: ColorManager.roomComment.withOpacity(0.3),
                      //               ),
                      //               child: Text(
                      //                 overflow: TextOverflow.visible,
                      //                 "${StringManager.roomIntro.tr()} \n ${widget.room.roomIntro}",
                      //                 style: TextStyle(color: ColorManager.textRoomComment2 ,fontSize: 24.zSP),
                      //               ),
                      //             ),
                      //           )
                      //         ],
                      //       ),
                      //       ListView.builder(
                      //         shrinkWrap: true,
                      //         // controller: _scrollController,
                      //         physics: const NeverScrollableScrollPhysics(),
                      //         // widget.scrollable ? null : const NeverScrollableScrollPhysics(),
                      //         itemCount: messageList.length,
                      //         itemBuilder: (context, index) {
                      //           final message = messageList[index];
                      //           if (filter.hasProfanity(message.message)) {
                      //             message.message = filter.censor(message.message);
                      //           }
                      //
                      //           return widget.itemBuilder.call(context, message, {});
                      //         },
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ) ;
                  } ,
                )
            ));
  }


}
