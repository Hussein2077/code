// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:flutter/material.dart';



// Project imports:
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/defines/message_defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/components/message/defines.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;

class ZegoInRoomMessageView extends StatefulWidget {
  final Stream<List<ZegoInRoomMessage>> stream;

  /// messages before stream broadcast
  final List<ZegoInRoomMessage> historyMessages;

  final ZegoInRoomMessageItemBuilder itemBuilder;

  final bool scrollable;
  final ScrollController? scrollController;
    final LayoutMode roomMode;
  final EnterRoomModel room;

  const ZegoInRoomMessageView({
    Key? key,
    required this.stream,
    required this.itemBuilder,
    this.scrollable = true,
    this.scrollController,
    this.historyMessages = const [],
    required this.room , 
    required this.roomMode , 
  }) : super(key: key);

  @override
  State<ZegoInRoomMessageView> createState() => _ZegoInRoomMessageViewState();
}

class _ZegoInRoomMessageViewState extends State<ZegoInRoomMessageView> {
  late ScrollController _scrollController;

  StreamSubscription<dynamic>? streamSubscription;
  var messagesNotifier = ValueNotifier<List<ZegoInRoomMessage>>([]);
    late ProfanityFilter filter;


  @override
  void initState() {
    super.initState();
        filter = ProfanityFilter.filterAdditionally(StringManager.arabicBadWords);


    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });

    _scrollController = widget.scrollController ?? ScrollController();
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
    messagesNotifier.value = widget.historyMessages;

    return  Directionality(
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
            valueListenable: RoomScreen.isPK,
            builder: (context,isShowPK,_){
              return ConstrainedBox(
                constraints: widget.roomMode == LayoutMode.hostTopCenter
                    ? isShowPK
                    ? BoxConstraints.loose(Size(600.r, 485.r))
                    : BoxConstraints.loose(Size(600.r, 550.r))
                    : BoxConstraints.loose(Size(600.r, 435.r)),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 50.w, height: 50.h, child: Image.asset(AssetsPath.iconApp)),
                          SizedBox(
                            width: 20.h,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10.r),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: ColorManager.roomComment.withOpacity(0.3),
                              ),
                              child: Text(

                                "${widget.room.roomRule}",
                                style: TextStyle(color: ColorManager.textRoomComment ,fontSize: 24.sp),
                                overflow: TextOverflow.fade,
                              ),

                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10.h,),
                      Row(
                        children: [
                          SizedBox(width: 50.w, height: 50.h, child: Image.asset(AssetsPath.roomIntroMessageIcon)),
                          SizedBox(
                            width: 20.h,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10.r),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: ColorManager.roomComment.withOpacity(0.3),
                              ),
                              child: Text(
                                "${StringManager.roomIntro.tr()} \n ${widget.room.roomIntro}",
                                style: TextStyle(color: ColorManager.textRoomComment2 ,fontSize: 24.sp),
                              ),
                            ),
                          )
                        ],
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
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
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }
}
