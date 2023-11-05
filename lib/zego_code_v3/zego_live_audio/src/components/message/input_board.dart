// Flutter imports:
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';

// Package imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/zego_uikit.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/live_audio_room_inner_text.dart';

/// @nodoc
class ZegoInRoomMessageInputBoard extends ModalRoute<String> {
  ZegoInRoomMessageInputBoard({
   required  this.innerText,
    required this.roomData,
    required this.mention,
    this.rootNavigator = false,
  }) : super();

  final ZegoInnerText innerText;
  final EnterRoomModel roomData ;
  final bool rootNavigator;
   final String? mention ;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Color get barrierColor => ZegoUIKitDefaultTheme.viewBarrierColor;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.of(
                context,
                rootNavigator: rootNavigator,
              ).pop(),
              child: Container(color: Colors.transparent),
            ),
          ),
          ZegoInRoomMessageInput(
            placeHolder: innerText?.messageEmptyToast??'',
            backgroundColor: Colors.white,
            inputBackgroundColor: const Color(0xffF7F7F8),
            textColor: const Color(0xff1B1B1B),
            textHintColor: const Color(0xff1B1B1B).withOpacity(0.5),
            buttonColor: const Color(0xff0055FF),
            onSubmit: () {
              Navigator.of(
                context,
                rootNavigator: rootNavigator,
              ).pop();
            }, roomData:roomData,
            mention: mention,
          ),
        ],
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: child,
    );
  }
}
