import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/gifts/widgets/gift_bottom_bar.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/lucky_gift/widgets/lucky_candy.dart';

class LuckyGiftSendButtonInRoom extends StatelessWidget {
  const LuckyGiftSendButtonInRoom({super.key, required this.room,required this.luckGiftBannderController});
  final EnterRoomModel room;
 final AnimationController luckGiftBannderController;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TypeCandy>(
        valueListenable: GiftBottomBar.typeCandy,
        builder: (BuildContext context, TypeCandy typeCabdy, _) {
          if (typeCabdy == TypeCandy.luckyCandy) {
            return LuckyCandy(
                roomData: room,
                luckGiftBannderController: luckGiftBannderController);
          } else {
            return const IgnorePointer(child: SizedBox());
          }
        });
  }
}
