import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/gifts/widgets/Gift_Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/gifts/widgets/gift_bottom_bar.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/gifts/widgets/gift_users.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/gifts/widgets/gift_user_only.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_lucky_gift_banner/lucky_gift_banner_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_lucky_gift_banner/lucky_gift_banner_event.dart';
import 'package:tik_chat_v2/main.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/uikit_service.dart';
import '../../../../../../../core/utils/config_size.dart';



class LuckyCandy extends StatefulWidget {
  final EnterRoomModel roomData ;
  final AnimationController? luckGiftBannderController ;

  const LuckyCandy({
    this.luckGiftBannderController,
    required this.roomData, Key? key}) : super(key: key);
  static ValueNotifier<int> winCircularluckyGift = ValueNotifier<int>(0);
  static int winCounter = 0;
  static String recieverName = "";

  @override
  _LuckyCandyState createState() => _LuckyCandyState();
}

class _LuckyCandyState extends State<LuckyCandy>with TickerProviderStateMixin {
  int compo = 1;
  Timer? timer;
  Timer? timerDuration;
  late final AnimationController animationController;
  ValueNotifier<double> percentNotifier = ValueNotifier<double>(0.0);

  double percent = 0;

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
    timer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
      percentNotifier.value += 0.0017;
    });
    sendGift();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        onTap: () {
          sendGift();
          percentNotifier.value =  0;
        },
        child:Container(
          decoration: BoxDecoration(
            gradient:   const LinearGradient(colors: ColorManager.mainColorList),
            borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 5),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [

              Center(
                child: Text(
                  StringManager.luckGiftSend.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white),
                ),
              ),
              ValueListenableBuilder<double>(
                  valueListenable: percentNotifier,
                  builder: (context, percent, child)  {
                    if(percent >= 1){
                      endAllLuckyGift();
                    }
                    return CircularPercentIndicator(
                      radius: ConfigSize.defaultSize! * 3.4,
                      lineWidth: 3,
                      animation: true,
                      curve: Curves.ease,
                      animateFromLastPercent: true,
                      addAutomaticKeepAlive: true,
                      percent: percent<1?percent:1,
                      backgroundColor: Colors.grey,
                      progressColor: Colors.yellow,
                    );
                  }
              ),
            ],
          ),
        ),
      );

  }


  void endAllLuckyGift(){

    if (timer != null) {
      timer!.cancel();
    }
    compo = 0;



    widget.luckGiftBannderController!.reverse().then((value) {
        BlocProvider.of<LuckyGiftBannerBloc>(navigatorKey.currentContext!).add(EndBannerEvent()) ;
    }
        );
    Future.delayed(const Duration(seconds: 1),()=>GiftBottomBar.typeCandy.value = TypeCandy.non);
    Future.delayed(const Duration(seconds: 1),()=>LuckyCandy.winCircularluckyGift.value = 0);
    if(LuckyCandy.winCounter != 0) ZegoUIKit().sendInRoomMessage("${StringManager.luckyGiftMessage.tr()} ${LuckyCandy.winCounter} ${StringManager.to.tr()} ${LuckyCandy.recieverName}",);
    LuckyCandy.winCounter = 0;

  }

  void sendGift() {
    List<String> userSelected =[] ;
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