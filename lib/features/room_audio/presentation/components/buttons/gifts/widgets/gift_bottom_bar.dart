import 'dart:async';
import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui' as ui;

import 'package:percent_indicator/percent_indicator.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
 
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/room_audio/data/data_sorce/remotly_data_source_room.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/gifts/widgets/Gift_Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/gifts/widgets/gift_users.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/send_gift_manger/send_gift_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/send_gift_manger/send_gift_events.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/send_gift_manger/send_gift_states.dart';

class GiftBottomBar extends StatefulWidget {
  GiftBottomBar(
      {required this.myDataModel, required this.roomData, super.key});

final  MyDataModel myDataModel;
final  EnterRoomModel roomData;

  static int numberOfGift = 1;
  int compo = 0;

  @override
  State<GiftBottomBar> createState() => _GiftBottomBarState();
}

class _GiftBottomBarState extends State<GiftBottomBar> with TickerProviderStateMixin {
  Timer? timer;
  Timer? timerDuration;
  late final AnimationController animationController;
  double percent = 0;

  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
    getUserCoins();
  }



  void showWidget() {

    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer.periodic(const Duration(milliseconds:1 ), (timer) {
      setState(() {
        percent = percent + 0.0017;
      });
    });
    timerDuration = Timer(const Duration(milliseconds:2500 ), () {
      setState(() {
        if (widget.compo != 0) {
          sendGift(widget.compo);
        }
        timer!.cancel();
        percent = 0;
        widget.compo = 0;
        isVisible = false;
      });
    });



    setState(() {
      isVisible = true;
    });


  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendGiftBloc, SendGiftStates>(
        builder: (context, state) {
      return Directionality(
          textDirection: ui.TextDirection.ltr,
          child: Padding(
            padding: EdgeInsets.only(bottom: AppPadding.p16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Spacer(
                  flex: 1,
                ),
                InkWell(
                    onTap: () async {
                  //    String currentUserCoins = await getUserCoinsString();
                      //TODO make this screen if does not exists and pass this value

                    // Navigator.pushNamed(context, Routes.charchingCoinsForUsers);
                      Navigator.pushNamed(context, Routes.coins,arguments: widget.myDataModel.uuid  );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppPadding.p12),
                          color: Colors.black87.withOpacity(0.8)),
                      padding: const EdgeInsets.all(3),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(AppPadding.p20),
                              child: Image.asset(
                                AssetsPath.goldCoinIcon,
                                width: AppPadding.p20,
                                height: AppPadding.p20,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: ValueListenableBuilder<String>(
                                valueListenable: RoomScreen.myCoins,
                                builder: (context, myCoins, _) {
                                  return Text(
                                    myCoins,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  );
                                },
                              ),
                            ),
                            Icon(
                              CupertinoIcons.right_chevron,
                              color: Colors.white,
                              size: AppPadding.p16,
                            ),
                          ]),
                    )),
                const Spacer(
                  flex: 10,
                ),
                isVisible
                    ? Row(
                        children: [
                          if (widget.compo != 0)
                            Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(
                                      text: 'Compo X  ',
                                      style: TextStyle(color: Colors.white)),
                                  TextSpan(
                                      text: widget.compo.toString(),
                                      style: const TextStyle(color: Colors.yellow)),
                                ],
                              ),
                            ),
                          SizedBox(
                            width: ConfigSize.defaultSize! * 2,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (timerDuration != null) {
                                  timerDuration!.cancel();
                                }
                                showWidget();
                                percent = 0;
                                widget.compo++;
                              });
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                RotationTransition(

                                  turns: animationController,
                                  child: Container(
                                    width: ConfigSize.defaultSize! *7.8,
                                    height: ConfigSize.defaultSize! * 7.8,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,

                                        image: DecorationImage(
                                            image: AssetImage(
                                              AssetsPath.sweetCandy,
                                            ),
                                            fit: BoxFit.fill)),
                                  ),
                                ),
                                CircularPercentIndicator(
                                  radius: ConfigSize.defaultSize! * 3.4,
                                  lineWidth: 3,
                                  animation: true,
                                  curve: Curves.ease,
                                  animateFromLastPercent: true,
                                  addAutomaticKeepAlive: true,
                                  percent: percent<1?percent:1,
                                  backgroundColor: Colors.grey,
                                  progressColor: Colors.yellow,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Container(
                        width: ConfigSize.defaultSize! * 16.2,
                        height: AppPadding.p30,
                        decoration: BoxDecoration(
                            border: Border.all(color: ColorManager.mainColor),
                            borderRadius:
                                BorderRadius.circular(AppPadding.p14)),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    bottomDailog(context: context ,widget:sendDialog(context) );


                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft:
                                                Radius.circular(AppPadding.p12),
                                            bottomLeft: Radius.circular(
                                                AppPadding.p12))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          GiftBottomBar.numberOfGift.toString(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        const Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: ColorManager.mainColorList),
                                      //  border: Border.all(color: ColorManager.mainColor),
                                      borderRadius: BorderRadius.only(
                                          topRight:
                                              Radius.circular(AppPadding.p12),
                                          bottomRight:
                                              Radius.circular(AppPadding.p12))),
                                  child: InkWell(
                                    onTap: () {
                                      showWidget();

                                      sendGift(null);
                                    },
                                    child: Center(
                                      child: Text(
                                        StringManager.send.tr(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                const Spacer(
                  flex: 1,
                )
              ],
            ),
          ));
    }, listener: (_, state) {
      if (state is SuccessSendGiftStates) {
      } else if (state is ErrorSendGiftStates) {
        errorToast(context:context , title: state.errorMessage);
      }
    });
  }

  @override
  void dispose() {
    //GiftUserOnly.userSelected = "";
    GiftUser.userSelected.clear();
    GiftBottomBar.numberOfGift = 1;
    animationController.dispose();
    super.dispose();
  }

  Widget sendDialog(BuildContext context) {
    return Container(
      height: ConfigSize.defaultSize! * 20.5,
      width: ConfigSize.defaultSize! * 9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppPadding.p10),
          color: Colors.black.withOpacity(0.8),
          border: Border.all(color: ColorManager.lightGray.withOpacity(0.5))),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                GiftBottomBar.numberOfGift = 1;
              });

              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(2),
              child: Center(
                  child: Text(
                "1",
                style: TextStyle(
                    color: GiftBottomBar.numberOfGift == 1
                        ? ColorManager.mainColor
                        : Colors.white),
              )),
            ),
          ),
          Divider(
            endIndent: 0,
            height: AppPadding.p8,
            color: ColorManager.lightGray,
          ),
          InkWell(
            onTap: () {
              setState(() {
                GiftBottomBar.numberOfGift = 5;
              });
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(2),
              child: Center(
                  child: Text(
                "5",
                style: TextStyle(
                    color: GiftBottomBar.numberOfGift == 5
                        ? ColorManager.mainColor
                        : Colors.white),
              )),
            ),
          ),
          Divider(
            endIndent: 0,
            height: AppPadding.p8,
            color:ColorManager.lightGray,
          ),
          InkWell(
            onTap: () {
              setState(() {
                GiftBottomBar.numberOfGift = 9;
              });
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(2),
              child: Center(
                  child: Text(
                "9",
                style: TextStyle(
                    color: GiftBottomBar.numberOfGift == 9
                        ? ColorManager.mainColor
                        : Colors.white),
              )),
            ),
          ),
          Divider(
            endIndent: 0,
            height: AppPadding.p8,
            color: ColorManager.lightGray,
          ),
          InkWell(
            onTap: () {
              setState(() {
                GiftBottomBar.numberOfGift = 99;
              });
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(2),
              child: Center(
                  child: Text(
                "99",
                style: TextStyle(
                    color: GiftBottomBar.numberOfGift == 99
                        ? ColorManager.mainColor
                        : Colors.white),
              )),
            ),
          ),
          Divider(
            endIndent: 0,
            height: AppPadding.p8,
            color:ColorManager.lightGray,
          ),
          InkWell(
            onTap: () {
              setState(() {
                GiftBottomBar.numberOfGift = 999;
              });
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(2),
              child: Center(
                  child: Text(
                "999",
                style: TextStyle(
                    color: GiftBottomBar.numberOfGift == 999
                        ? ColorManager.mainColor
                        : Colors.white),
              )),
            ),
          ),
          Divider(
            endIndent: 0,
            height: AppPadding.p8,
            color: ColorManager.lightGray,
          ),
          InkWell(
            onTap: () {
              setState(() {
                GiftBottomBar.numberOfGift = 9999;
              });
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(2),
              child: Center(
                  child: Text(
                "9999",
                style: TextStyle(
                    color: GiftBottomBar.numberOfGift == 9999
                        ? ColorManager.mainColor
                        : Colors.white),
              )),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> getUserCoins() async {
    final result = await RemotlyDataSourceRoom().getConfigKey(null);
    RoomScreen.myCoins.value = result.userCoin.toString();
    return result.userCoin.toString();
  }

  Future<String> getUserCoinsString() async {
    final result = await RemotlyDataSourceRoom().getConfigKey(null);
    RoomScreen.myCoins.value = result.userCoinString ?? '';
    return result.userCoinString ?? '';
  }

  void sendGift(int? compoNum) {
    List<String> userSelected = GiftUser.userSelected.entries.map((e) {
      return e.value.userId;
    }).toList();
    String toUid = "";
    for (int i = 0; i < userSelected.length; i++) {
      toUid += '${userSelected[i].toString()},';
    }
//    log(toUid.toString());

    (userSelected.isEmpty && /*GiftUserOnly.userSelected == ""*/ true)
        ? BlocProvider.of<SendGiftBloc>(context).add(SendGiftesEvent(
            ownerId: widget.roomData.ownerId.toString(),
            id: GiftScreen.giftId.toString(),
            toUid: "",
            num: GiftBottomBar.numberOfGift.toString(),
            toZego: "1"))
        : compoNum != null
            ? BlocProvider.of<SendGiftBloc>(context).add(SendGiftesEvent(
                ownerId: widget.roomData.ownerId.toString(),
                id: GiftScreen.giftId.toString(),
                toUid:
               /* GiftUserOnly.userSelected == "" ?*/
                toUid.substring(0, toUid.length - 1)
                  //  : GiftUserOnly.userSelected
            ,
                num: compoNum.toString(),
                toZego: "1"))
            : BlocProvider.of<SendGiftBloc>(context).add(SendGiftesEvent(
                ownerId: widget.roomData.ownerId.toString(),
                id: GiftScreen.giftId.toString(),
                toUid:
                //GiftUserOnly.userSelected == "" ?
                toUid.substring(0, toUid.length - 1)
                  //  : GiftUserOnly.userSelected
        ,
                num: GiftBottomBar.numberOfGift.toString(),
                toZego: "1"));
    if(kDebugMode){
    //  log("GiftUserOnly.userSelected" + GiftUserOnly.userSelected);
      log("GiftUser.userSelected${GiftUser.userSelected}");
      log("GiftBottomBar.numberOfGift${ GiftBottomBar.numberOfGift.toString()}");
      log("Owner ID"+ widget.roomData.ownerId.toString(),);
      log("ID Gift"+ GiftScreen.giftId.toString(),);
      log("ID Gift"+ GiftScreen.giftId.toString(),);
      log("u id"+toUid.substring(0, toUid.length - 1));
    }

  }
}
