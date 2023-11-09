import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui' as ui;
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/moment/presentation/componants/giftbox/widgets/Dailog_button.dart';
import 'package:tik_chat_v2/features/room_audio/data/data_sorce/remotly_data_source_room.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/gifts/widgets/Gift_Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/gifts/widgets/gift_users.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/gifts/widgets/normal_candy.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/profile/widgets/gift_user_only.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/send_gift_manger/send_gift_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/send_gift_manger/send_gift_events.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/send_gift_manger/send_gift_states.dart';

class GiftBottomBar extends StatefulWidget {
  GiftBottomBar(
  {
  required this.roomData,
  super.key});

final EnterRoomModel roomData;

static int numberOfGift = 1;
static TypeGift typeGift =TypeGift.normal ;
static ValueNotifier<TypeCandy>  typeCandy = ValueNotifier(TypeCandy.non);

@override
State<GiftBottomBar> createState() => _GiftBottomBarState();
}

class _GiftBottomBarState extends State<GiftBottomBar>  {

  @override
  void initState() {
    super.initState();
    getUserCoins();
  }

  @override
  void dispose() {
    GiftUserOnly.userSelected = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendGiftBloc, SendGiftStates>(
        builder: (context, state) {
          return Directionality(
              textDirection: ui.TextDirection.ltr,
              child: Padding(
                padding: EdgeInsets.only(bottom: ConfigSize.defaultSize!*2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Spacer(
                      flex: 1,
                    ),
                    InkWell(
                        onTap: () async {
                          //    String currentUserCoins = await getUserCoinsString();
                          Navigator.pushNamed(context, Routes.coins,arguments: MyDataModel.getInstance().uuid  );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(ConfigSize.defaultSize!*1.3),
                              color: Colors.black87.withOpacity(0.8)),
                          padding: const EdgeInsets.all(3),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(ConfigSize.defaultSize!*2.3),
                                  child: Image.asset(
                                    AssetsPath.goldCoin,
                                    width: ConfigSize.defaultSize!*2.4,
                                    height: ConfigSize.defaultSize!*2.4,
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
                                            color: ColorManager.whiteColor,
                                            fontWeight: FontWeight.w600),
                                      );
                                    },
                                  ),
                                ),
                                Icon(
                                  CupertinoIcons.right_chevron,
                                  color: ColorManager.whiteColor,
                                  size: ConfigSize.defaultSize!*1.4,
                                ),
                              ]),
                        )),
                    const Spacer(
                      flex: 10,
                    ),
                    ValueListenableBuilder<TypeCandy>(
                        valueListenable: GiftBottomBar.typeCandy,
                        builder:(BuildContext context, TypeCandy typeCabdy, _){
                          if(typeCabdy == TypeCandy.normalCandy){
                            return NormalCandy(sendGift:sendGift) ;
                          }// else if (typeCabdy == TypeCandy.luckyCandy) {
                          //   return LuckyCandy(sendGift: sendGift) ;
                          // }
                          else {
                            return Container(
                              width: ConfigSize.defaultSize! * 16.2,
                              height:  ConfigSize.defaultSize! * 4,
                              decoration: BoxDecoration(
                                  border: Border.all(color: ColorManager.orang),
                                  borderRadius:
                                  BorderRadius.circular( ConfigSize.defaultSize! * 1.4)),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: () {
                                          dailogbutton(context, sendDialog(context));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                  Radius.circular(ConfigSize.defaultSize! * 1.2),
                                                  bottomLeft: Radius.circular(
                                                      ConfigSize.defaultSize! * 1.2))),
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
                                            //  border: Border.all(color: AppColor.mainColor),
                                            borderRadius: BorderRadius.only(
                                                topRight:
                                                Radius.circular(ConfigSize.defaultSize! * 1.2),
                                                bottomRight:
                                                Radius.circular(ConfigSize.defaultSize! * 1.2))),
                                        child: InkWell(
                                          onTap:() {
                                            if(GiftBottomBar.typeGift == TypeGift.lucky){
                                              GiftBottomBar.typeCandy.value =TypeCandy.luckyCandy ;
                                              Navigator.pop(context);
                                            }else {
                                              GiftBottomBar.typeCandy.value =TypeCandy.normalCandy ;

                                            }


                                          },
                                          child: Center(
                                            child: Text(
                                              StringManager.send.tr(),
                                              style: const TextStyle(
                                                  color: ColorManager.whiteColor,
                                                  fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ) ;
                          }
                        } ),

                    const Spacer(
                      flex: 1,
                    )
                  ],
                ),
              ));
        }, listener: (_, state) {
      if (state is SuccessSendGiftStates) {
      }
      else if (state is ErrorSendGiftStates) {
        errorToast(context: context, title: state.errorMessage.tr()) ;
      }
    });
  }

  Widget sendDialog(BuildContext context) {
    return Container(
      height: ConfigSize.screenHeight! * .25,
      width: ConfigSize.defaultSize! * 9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize!*1.1),
          color: Colors.black.withOpacity(0.8),
          border: Border.all(color: ColorManager.gray.withOpacity(0.5))),
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
                            : ColorManager.whiteColor),
                  )),
            ),
          ),
          Divider(
            endIndent: 0,
            height: ConfigSize.defaultSize,
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
                            : ColorManager.whiteColor),
                  )),
            ),
          ),
          Divider(
            endIndent: 0,
            height: ConfigSize.defaultSize,
            color: ColorManager.lightGray,
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
                            : ColorManager.whiteColor),
                  )),
            ),
          ),
          Divider(
            endIndent: 0,
            height: ConfigSize.defaultSize,
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
                            : ColorManager.whiteColor),
                  )),
            ),
          ),
          Divider(
            endIndent: 0,
            height: ConfigSize.defaultSize,
            color: ColorManager.lightGray,
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
                            : ColorManager.whiteColor),
                  )),
            ),
          ),
          Divider(
            endIndent: 0,
            height: ConfigSize.defaultSize,
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
                            : ColorManager.whiteColor),
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
    List<String> userSelected =[] ;

    GiftUser.userSelected.forEach((key, value) {
      userSelected.add(value.userId);
    });
    String toUid = "";
    for (int i = 0; i < userSelected.length; i++) {
      toUid += '${userSelected[i].toString()},';
    }

    (userSelected.isEmpty && GiftUserOnly.userSelected == "")
        ? BlocProvider.of<SendGiftBloc>(context).add(SendGiftesEvent(
        ownerId: widget.roomData.ownerId.toString(),
        id: GiftScreen.giftId.toString(),
        toUid: "",
        num:
        GiftBottomBar.numberOfGift.toString(),
        toZego: "1"))
        : compoNum != null
        ? BlocProvider.of<SendGiftBloc>(context).add(SendGiftesEvent(
        ownerId: widget.roomData.ownerId.toString(),
        id: GiftScreen.giftId.toString(),
        toUid: GiftUserOnly.userSelected == ""
            ? toUid.substring(0, toUid.length - 1)
            : GiftUserOnly.userSelected,
        num:(compoNum*GiftBottomBar.numberOfGift).toString(),
        toZego: "1"))
        : BlocProvider.of<SendGiftBloc>(context).add(SendGiftesEvent(
        ownerId: widget.roomData.ownerId.toString(),
        id: GiftScreen.giftId.toString(),
        toUid: GiftUserOnly.userSelected == ""
            ? toUid.substring(0, toUid.length - 1)
            : GiftUserOnly.userSelected,
        num:
        GiftBottomBar.numberOfGift.toString(),
        toZego: "1"));

  }
}
