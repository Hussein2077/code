// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/pk_functions.dart';

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


  StreamSubscription<dynamic>? streamSubscription;
  var messagesNotifier = ValueNotifier<List<ZegoInRoomMessage>>([]);
  late ProfanityFilter filter;

  @override
  void initState() {
    super.initState();

    filter = ProfanityFilter.filterAdditionally(StringManager.arabicBadWords);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });

    scrollController = widget.scrollController ?? ScrollController();
    streamSubscription = widget.stream.listen(onMessageUpdate);
  }

  @override
  void dispose() {
    super.dispose();

    messagesNotifier.value = [];
    streamSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
   // messagesNotifier.value = widget.historyMessages;
    return Directionality(
        textDirection: ui.TextDirection.rtl,
        child: ValueListenableBuilder<List<ZegoInRoomMessage>>(
          valueListenable: messagesNotifier,
          builder: (context, messageList, child) {
            //todo  add value lester here
            return  MediaQuery.removePadding(
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
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: [
                            Row(
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
                                      "${widget.room.roomRule}",
                                      style: TextStyle(color: ColorManager.textRoomComment ,fontSize: 24.zSP),
                                    ),

                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 10.zH,),
                            Row(
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
                                      "${StringManager.roomIntro.tr()} \n ${widget.room.roomIntro}",
                                      style: TextStyle(color: ColorManager.textRoomComment2 ,fontSize: 24.zSP),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              // controller: _scrollController,
                              physics: const NeverScrollableScrollPhysics(),
                              // widget.scrollable ? null : const NeverScrollableScrollPhysics(),
                              itemCount: messageList.length,
                              itemBuilder: (context, index) {
                                final message = messageList[index];
                                if (filter.hasProfanity(message.message)) {
                                  message.message = filter.censor(message.message);
                                }

                                return widget.itemBuilder.call(context, message, {});
                              },
                            ),
                          ],
                        ),
                      ),
                    ) ;
                  } ,
                )
            );
          },
        ));
  }

  void onMessageUpdate(List<ZegoInRoomMessage> messages) {
    messagesNotifier.value = messages;

    Future.delayed(const Duration(milliseconds: 100), () {
      if (messagesNotifier.value.isEmpty) {
        return;
      }
      if (ZegoInRoomMessageViewState.scrollController.position.maxScrollExtent - ZegoInRoomMessageViewState.scrollController.position.pixels < 270.zH ) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }

    });
  }
}
