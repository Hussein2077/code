
import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/moment/presentation/componants/giftbox/moment_giftbox_screen.dart';
import 'package:tik_chat_v2/features/moment/presentation/componants/giftbox/widgets/Dailog_button.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_send_gift/moment_send_gift_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_send_gift/moment_send_gift_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_send_gift/moment_send_gift_state.dart';
import 'package:tik_chat_v2/features/moment/presentation/widgets/moment_bottom_bar.dart';
import 'package:tik_chat_v2/features/room_audio/data/data_sorce/remotly_data_source_room.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';




class MomtentGiftBottomBarBody extends StatefulWidget {
  static int numberOfGift = 1;
  final String momentId;
  MomtentGiftBottomBarBody({
    super.key,
    required this.momentId,
  });

  @override
  State<MomtentGiftBottomBarBody> createState() =>
      _MomtentGiftBottomBarBodyState();
}
class _MomtentGiftBottomBarBodyState extends State<MomtentGiftBottomBarBody>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    getUserCoins();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MomentSendGiftBloc, MomentSendGiftStates>(
        builder: (context, state) {
      return Directionality(
          textDirection: ui.TextDirection.ltr,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Spacer(
                flex: 1,
              ),
              InkWell(
                  onTap: () async {
                    //    String currentUserCoins = await getUserCoinsString();
                   // Navigator.pushNamed(context, Routes.wallet);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            ConfigSize.defaultSize! * 1.3),
                        color:  Colors.black87.withOpacity(0.2)
                    ),
                    padding: EdgeInsets.all(ConfigSize.defaultSize! * 0.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                ConfigSize.defaultSize! * 2.3),
                            child: Image.asset(
                              AssetsPath.goldCoinIcon,
                              width: ConfigSize.defaultSize! * 2.4,
                              height: ConfigSize.defaultSize! * 2.4,
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
                                  style:  TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                );
                              },
                            ),
                          ),
                          Icon(
                            CupertinoIcons.right_chevron,
                            color: Colors.white,
                            size: ConfigSize.defaultSize! * 1.4,
                          ),
                        ]),
                  )),
              const Spacer(
                flex: 10,
              ),
              Container(
                width: ConfigSize.defaultSize! * 16.2,
                height: ConfigSize.defaultSize! * 4,
                decoration: BoxDecoration(
                    border: Border.all(color: ColorManager.yellow),
                    borderRadius:
                        BorderRadius.circular(ConfigSize.defaultSize! * 1.4)),
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
                                    topLeft: Radius.circular(
                                        ConfigSize.defaultSize! * 1.2),
                                    bottomLeft: Radius.circular(
                                        ConfigSize.defaultSize! * 1.2))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  MomtentGiftBottomBarBody.numberOfGift
                                      .toString(),
                                  style:  const TextStyle(color: Colors.white,),
                                ),
                                 Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white

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
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(
                                      ConfigSize.defaultSize! * 1.2),
                                  bottomRight: Radius.circular(
                                      ConfigSize.defaultSize! * 1.2))),
                          child: InkWell(
                            onTap: () {
                              MomentBottomBarState.selectedMoment=int.parse(widget.momentId);
                              MomentBottomBarState.giftsNum=MomtentGiftBottomBarBody.numberOfGift;
                              BlocProvider.of<MomentSendGiftBloc>(context)
                                  .add(MomentSendGiftEvent(
                                momentId: widget.momentId,
                                giftNum: MomtentGiftBottomBarBody.numberOfGift,
                                giftId: MomentGiftboxScreen.momentGiftId,
                              ));

                            },
                            child: Center(
                              child: Text(
                                StringManager.send.tr(),
                                style:  TextStyle(
                                    color:  Colors.white,
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
          ));
    },
        listener: (context, state) {
      if (state is MomentSendGiftSucssesState) {
sucssesToast(context: context, title: StringManager.sucsses);
      }
       else if (state is MomentSEndGiftErrorState) {

        errorToast(context: context, title: state.errorMessage);
      }
    });
  }

  @override
  void dispose() {
    MomtentGiftBottomBarBody.numberOfGift = 1;

    super.dispose();
  }

  Widget sendDialog(BuildContext context) {
    return Container(
      height: ConfigSize.defaultSize! * 22.5,
      width: ConfigSize.defaultSize! * 9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 1.1),
          color: ColorManager.darkBlack.withOpacity(0.8),
          border: Border.all(color: ColorManager.gray.withOpacity(0.5))),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                MomtentGiftBottomBarBody.numberOfGift = 1;
              });

              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(2),
              child: Center(
                  child: Text(
                "1",
                style: TextStyle(
                    color: MomtentGiftBottomBarBody.numberOfGift == 1
                        ? ColorManager.yellow
                        : ColorManager.whiteColor),
              )),
            ),
          ),
          Divider(
            endIndent: 0,
            height: ConfigSize.defaultSize,
            color: ColorManager.gray,
          ),
          InkWell(
            onTap: () {
              setState(() {
                MomtentGiftBottomBarBody.numberOfGift = 5;
              });
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(2),
              child: Center(
                  child: Text(
                "5",
                style: TextStyle(
                    color: MomtentGiftBottomBarBody.numberOfGift == 5
                        ? ColorManager.yellow
                        : ColorManager.whiteColor),
              )),
            ),
          ),
          Divider(
            endIndent: 0,
            height: ConfigSize.defaultSize,
            color: ColorManager.gray,
          ),
          InkWell(
            onTap: () {
              setState(() {
                MomtentGiftBottomBarBody.numberOfGift = 9;
              });
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(2),
              child: Center(
                  child: Text(
                "9",
                style: TextStyle(
                    color: MomtentGiftBottomBarBody.numberOfGift == 9
                        ? ColorManager.yellow
                        : ColorManager.whiteColor),
              )),
            ),
          ),
          Divider(
            endIndent: 0,
            height: ConfigSize.defaultSize,
            color: ColorManager.gray,
          ),
          InkWell(
            onTap: () {
              setState(() {
                MomtentGiftBottomBarBody.numberOfGift = 99;
              });
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(2),
              child: Center(
                  child: Text(
                "99",
                style: TextStyle(
                    color: MomtentGiftBottomBarBody.numberOfGift == 99
                        ? ColorManager.yellow
                        : ColorManager.whiteColor),
              )),
            ),
          ),
          Divider(
            endIndent: 0,
            height: ConfigSize.defaultSize,
            color: ColorManager.gray,
          ),
          InkWell(
            onTap: () {
              setState(() {
                MomtentGiftBottomBarBody.numberOfGift = 999;
              });
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(2),
              child: Center(
                  child: Text(
                "999",
                style: TextStyle(
                    color: MomtentGiftBottomBarBody.numberOfGift == 999
                        ? ColorManager.yellow
                        : ColorManager.whiteColor),
              )),
            ),
          ),
          Divider(
            endIndent: 0,
            height: ConfigSize.defaultSize,
            color: ColorManager.gray,
          ),
          InkWell(
            onTap: () {
              setState(() {
                MomtentGiftBottomBarBody.numberOfGift = 9999;
              });
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(2),
              child: Center(
                  child: Text(
                "9999",
                style: TextStyle(
                    color: MomtentGiftBottomBarBody.numberOfGift == 9999
                        ? ColorManager.yellow
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

}
