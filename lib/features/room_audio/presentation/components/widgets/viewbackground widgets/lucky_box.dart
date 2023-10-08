// ignore_for_file: must_be_immutable

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/lucky_box/widgets/dialog_lucky_box.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/lucky_box/widgets/error_luck_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_lucky_boxes/luck_boxes_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_lucky_boxes/luck_boxes_states.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/room_screen_controler.dart';

class LuckyBox extends StatelessWidget {

  StreamController<List<LuckyBoxData>> luckyBoxRemovecontroller;
  LuckyBox({super.key, required this.luckyBoxRemovecontroller});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LuckyBoxesBloc, LuckyBoxesStates>(
        builder: (context, state) {
          return Positioned(
            top: ConfigSize.defaultSize! * 10.4,
            child: InkWell(
                onTap: () {
                  showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (BuildContext context) {
                        if (RoomScreen.luckyBoxes.isEmpty) {
                          RoomScreen.updateLuckyBox.value =
                              RoomScreen.updateLuckyBox.value + 1;
                          return Center(
                              child: Container(
                                height: ConfigSize.defaultSize! * 46.2,
                                width: ConfigSize.defaultSize! * 23,
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: ColorManager.mainColorList),
                                    borderRadius:
                                    BorderRadius.circular(AppPadding.p20)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: AppPadding.p8),
                                child: const ErrorLuckWidget(
                                  isNotLucky: true,
                                ),
                              ));
                        } else {
                          return AlertDialog(
                            backgroundColor: Colors.transparent,
                            contentPadding: EdgeInsets.zero,
                            content: DialogLuckyBox(
                              coins: RoomScreen
                                  .luckyBoxes[RoomScreen.luckyBoxes.length - 1]
                                  .coinns,
                              luckyBoxId: RoomScreen
                                  .luckyBoxes[RoomScreen.luckyBoxes.length - 1]
                                  .boxId,
                              ownerBoxId: RoomScreen
                                  .luckyBoxes[RoomScreen.luckyBoxes.length - 1]
                                  .ownerBoxId,
                              ownerBoxName: RoomScreen
                                  .luckyBoxes[RoomScreen.luckyBoxes.length - 1]
                                  .ownerName,
                              removeController: luckyBoxRemovecontroller,
                              typeLuckyBox: RoomScreen
                                  .luckyBoxes[RoomScreen.luckyBoxes.length - 1]
                                  .typeLuckyBox,
                              remTime: SetTimerLuckyBox.remTimeSuperBox,
                              ownerImage: RoomScreen
                                  .luckyBoxes[RoomScreen.luckyBoxes.length - 1]
                                  .ownerImage,
                              uid: RoomScreen
                                  .luckyBoxes[RoomScreen.luckyBoxes.length - 1]
                                  .uId,
                            ),
                          );
                        }
                      });
                  // BlocProvider.of<LuckyBoxesBloc>(context)
                  //     .add(PickupBoxesEvent(boxId: boxId)) ;
                },
                child: Stack(
                  children: [
                    Image.asset(
                      AssetsPath.luckybox2,
                      width: ConfigSize.defaultSize! * 7,
                      height: ConfigSize.defaultSize! * 7,
                    ),
                    Positioned(
                      top: AppPadding.p40,
                      right: AppPadding.p10,
                      child: Badge.count(
                          count: RoomScreen.luckyBoxes.length,
                          isLabelVisible: RoomScreen.luckyBoxes.length != 1),
                    )
                  ],
                )),
          );
        },
        listener: (context, state) {});
  }
}
