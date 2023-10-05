// Flutter imports:
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:flutter/material.dart';

// Package imports:


import '../../../../zego_uikit/zego_uikit.dart';

class ZegoInRoomMessageInputBoard extends ModalRoute<String> {
  final EnterRoomModel roomData ;
  final MyDataModel myDataModel ;
  String? mention ; 
  ZegoInRoomMessageInputBoard({this.mention ,  required this.roomData,required this.myDataModel}) : super();

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
              onTap: () => Navigator.pop(context),
              child: Container(color: Colors.transparent),
            ),
          ),
          ZegoInRoomMessageInput(
            mention: mention,
            backgroundColor: Colors.white,
            inputBackgroundColor: const Color(0xffF7F7F8),
            textColor: const Color(0xff1B1B1B),
            textHintColor: const Color(0xff1B1B1B).withOpacity(0.5),
            buttonColor: const Color(0xff0055FF),
            onSubmit: () {
              Navigator.pop(context);
            }, roomData:roomData,
            myData: myDataModel,
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
