

import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/gifts/widgets/Gift_Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/gifts/widgets/gift_bottom_bar.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/gifts/widgets/gift_users.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/profile/widgets/gift_user_only.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_lucky_gift_banner/lucky_gift_banner_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_lucky_gift_banner/lucky_gift_banner_event.dart';

import '../../../../../../../core/utils/config_size.dart';



class LuckyCandy extends StatefulWidget {
  final EnterRoomModel roomData ;
  final AnimationController? luckGiftBannderController ;

  const LuckyCandy({
    this.luckGiftBannderController,
    required this.roomData, Key? key}) : super(key: key);

  @override
  _LuckyCandyState createState() => _LuckyCandyState();
}

class _LuckyCandyState extends State<LuckyCandy>with TickerProviderStateMixin {
  int compo = 1;
  Timer? timer;
  Timer? timerDuration;
  late final AnimationController animationController;
  double percent = 0;

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
    showWidget();
    super.initState();
  }
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
     
        InkWell(
          onTap: () {
            setState(() {
              if (timerDuration != null) {
                timerDuration!.cancel();
              }
              showWidget();
              percent = 0;
            });
          },
          child:Container(
            height: ConfigSize.screenHeight! * .1,
            width: ConfigSize.screenWidth! * .3,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [
                ColorManager.orang,
                ColorManager.whiteColor,
              ]),
              borderRadius:
              BorderRadius.circular(ConfigSize.defaultSize! * 1.5),
            ),
            child: Center(
              child: Text(
                StringManager.luckGiftSend.tr(),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  void showWidget() {
    sendGift(null);
    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer.periodic(const Duration(milliseconds:1 ), (timer) {
      setState(() {
        percent = percent + 0.0017;
      });
    });
    timerDuration = Timer(const Duration(milliseconds:2500 ), () {
     
        timer!.cancel();
        percent = 0;
        compo = 0;
        GiftBottomBar.typeCandy.value = TypeCandy.non;
       BlocProvider.of<LuckyGiftBannerBloc>(context).add(EndBannerEvent());

         widget.luckGiftBannderController!.reverse().then((value) {
           
          });
    RoomScreen.winCircularluckyGift.value = 0;
 
    });




    GiftBottomBar.typeCandy.value = TypeCandy.luckyCandy;


  }

  void sendGift(int? compoNum) {
     List<String> userSelected =[] ;
    // GiftUser.userSelected.entries.map((e) {
    //   return e.value.userId;
    // }).toList();
    GiftUser.userSelected.forEach((key, value) { 
      userSelected.add(value.userId);
    });
    String toUid = "";
    for (int i = 0; i < userSelected.length; i++) {
      toUid += '${userSelected[i].toString()},';
    }
    

    (userSelected.isEmpty && GiftUserOnly.userSelected == "")
        ? BlocProvider.of<LuckyGiftBannerBloc>(context).add(SendLuckyGiftEvent(
        ownerId: widget.roomData.ownerId.toString(),
        id: GiftScreen.giftId.toString(),
        toUid: "",
        num: GiftBottomBar.numberOfGift.toString(),
        ))
        :  BlocProvider.of<LuckyGiftBannerBloc>(context).add(SendLuckyGiftEvent(
        ownerId: widget.roomData.ownerId.toString(),
        id: GiftScreen.giftId.toString(),
        toUid: GiftUserOnly.userSelected == ""
            ? toUid.substring(0, toUid.length - 1)
            : GiftUserOnly.userSelected,
        num: GiftBottomBar.numberOfGift.toString(),
        ));


  }
}
