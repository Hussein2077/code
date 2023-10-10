import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/enter_room_pass/save_password_room_screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/heaser_room/admins_room/admins_room_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/heaser_room/more_widget/back_ground/back_ground_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/heaser_room/more_widget/choose_mode/choose_mode_room.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/pk_functions.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/time_pk_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_events.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_states.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/uikit_service.dart';


class MoreDailogWidget extends StatefulWidget {
  final int roomId;
  final bool passwordStatus;
  final String ownerId;
  final Function() notifyRoom;
  final int modeRoom;
  final String userId;
  final Function() refreshRoom;

  const MoreDailogWidget(
      {required this.roomId,
      required this.notifyRoom,
      required this.ownerId,
      required this.userId,
      required this.modeRoom,
      required this.passwordStatus,
      required this.refreshRoom,
      Key? key})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  MoreDailogWidgetState createState() => MoreDailogWidgetState();
}

class MoreDailogWidgetState extends State<MoreDailogWidget> {
  // late bool roomIsLoked;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnRoomBloc, OnRoomStates>(

        builder: (context, state) {
      return Container(
        width: ConfigSize.screenWidth,
        height: ConfigSize.defaultSize! * ConfigSize.defaultSize! * 3,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(AppPadding.p20),
                topLeft: Radius.circular(AppPadding.p20))),
        padding: EdgeInsets.symmetric(vertical: ConfigSize.defaultSize!),
        child: RoomScreen.adminsInRoom.containsKey(widget.userId)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);

                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              StringManager.areYouSure.tr(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: AppPadding.p18),
                            ),
                            actions: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  width: ConfigSize.defaultSize! * 9.2,
                                  height: AppPadding.p26,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: ColorManager.mainColor),
                                  child: Text(
                                    StringManager.no.tr(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: AppPadding.p16,
                                        fontStyle: FontStyle.italic),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {

                                  Navigator.pop(context);
                                  clearChat();
                                },
                                child: Container(
                                  width: ConfigSize.defaultSize! * 9.2,
                                  height: AppPadding.p26,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: ColorManager.deepPurble),
                                  child: Text(
                                    StringManager.yes.tr(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: AppPadding.p16,
                                        fontStyle: FontStyle.italic),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image(
                            width: ConfigSize.defaultSize! * 6.9,
                            height: ConfigSize.defaultSize! * 6.9,
                            image:  const AssetImage(AssetsPath.broom)),
                        Text(StringManager.clearChat.tr(),
                            style: TextStyle(
                                fontSize: AppPadding.p12,
                                color: Colors.black,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.music,
                          arguments: MusicPramiter(
                              refresh: widget.refreshRoom,
                              ownerId: widget.ownerId));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image(
                            width: ConfigSize.defaultSize! * 6.9,
                            height: ConfigSize.defaultSize! * 6.9,
                            image: const AssetImage(AssetsPath.music)),
                        Text(StringManager.music.tr(),
                            style: TextStyle(
                                fontSize: AppPadding.p12,
                                color: Colors.black,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Spacer(
                        flex: 2,
                      ),
                      InkWell(
                        onTap: () {
                          if (RoomScreen.roomIsLoked) {
                            BlocProvider.of<OnRoomBloc>(context).add(
                                RemovePassRoomEvent(ownerId: widget.ownerId));

                            setState(() {
                              RoomScreen.roomIsLoked = false;
                            });
                          } else {
                            Navigator.pop(context);

                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                  insetPadding: EdgeInsets.symmetric(
                                      horizontal: ConfigSize.defaultSize!*2.9
                                  ),

                                  backgroundColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  contentPadding: const EdgeInsets.all(12),
                                  content: SaveRoomPasswordRoomScreen(
                                    ownerId: widget.roomId.toString(),
                                    myData: MyDataModel.getInstance(),
                                  )),
                            );
                          }
                        },
                        child: Column(
                          children: [
                            RoomScreen.roomIsLoked
                                ? Image(
                                    width: ConfigSize.defaultSize! * 6.9,
                                    height: ConfigSize.defaultSize! * 6.9,
                                    image: const AssetImage(AssetsPath.roomlocked),
                                  )
                                : Image(
                                    width: ConfigSize.defaultSize! * 6.9,
                                    height: ConfigSize.defaultSize! * 6.9,
                                    image: const AssetImage(AssetsPath.unLockRoom)),
                            SizedBox(
                              height: ConfigSize.defaultSize!,
                            ),
                            Text(StringManager.lock.tr(),
                                style: TextStyle(
                                    fontSize: AppPadding.p12,
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          showDialog<void>(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  StringManager.areYouSure.tr(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: AppPadding.p16),
                                ),
                                actions: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      width: ConfigSize.defaultSize! * 9.2,
                                      height: AppPadding.p26,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: ColorManager.lightGray
                                      ),
                                      child: Text(
                                        StringManager.no.tr(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: AppPadding.p16,
                                            fontStyle: FontStyle.italic),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                      clearChat();
                                    },
                                    child: Container(
                                      width: ConfigSize.defaultSize! * 9.2,
                                      height: AppPadding.p26,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: ColorManager.mainColor),
                                      child: Text(
                                        StringManager.yes.tr(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: AppPadding.p16,
                                            fontStyle: FontStyle.italic),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        },
                        child: Column(
                          children: [
                            Image(
                              width: ConfigSize.defaultSize! * 6.9,
                              height: ConfigSize.defaultSize! * 6.9,
                              image: const AssetImage(AssetsPath.broom),
                            ),
                            SizedBox(
                              height: ConfigSize.defaultSize!,
                            ),
                            Text(StringManager.clearChat.tr(),
                                style: TextStyle(
                                    fontSize: AppPadding.p12,
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          bottomDailog(
                              context: context,
                              widget: BackGround(ownerId:widget.ownerId , ));
                        },
                        child: Column(
                          children: [
                            Image(
                                width: ConfigSize.defaultSize! * 6.9,
                                height: ConfigSize.defaultSize! * 6.9,
                                image: const AssetImage(AssetsPath.paintTheme)),
                            SizedBox(
                              height: ConfigSize.defaultSize!,
                            ),
                            Text(StringManager.theme.tr(),
                                style: TextStyle(
                                    fontSize: AppPadding.p12,
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Spacer(
                        flex: 2,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          bottomDailog(
                              context: context,
                              widget:
                              ValueListenableBuilder(valueListenable: PkController.isPK,
                                  builder:(context,show,_){
                                return  ChooseModeRoom(
                                  ownerId: widget.ownerId,
                                  modeRoom: widget.modeRoom,
                                ) ;
                                  } )
                           );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image(
                              width: ConfigSize.defaultSize! * 5,
                              height: ConfigSize.defaultSize! * 5,
                              image:  const AssetImage(AssetsPath.chairIcon),
                            ),
                            SizedBox(
                              height: ConfigSize.defaultSize!,
                            ),
                            Text(
                              StringManager.modeChairs.tr(),
                              style: TextStyle(
                                  fontSize: AppPadding.p12,
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          bottomDailog(
                              context: context,
                              widget: AdminsRoomWidget(
                                userId: widget.userId,
                                ownerId: widget.ownerId,
                              ));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image(
                                width: ConfigSize.defaultSize! * 5,
                                height: ConfigSize.defaultSize! * 5,
                                image:  const AssetImage(AssetsPath.adminIcon)),
                            SizedBox(
                              height: ConfigSize.defaultSize!,
                            ),
                            Text(StringManager.admin.tr(),
                                style: TextStyle(
                                    fontSize: AppPadding.p12,
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, Routes.music,
                              arguments: MusicPramiter(
                                  refresh: widget.refreshRoom,
                                  ownerId: widget.ownerId));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image(
                                width: ConfigSize.defaultSize! * 6.9,
                                height: ConfigSize.defaultSize! * 6.9,
                                image: const AssetImage(AssetsPath.music)),
                            Text(StringManager.music.tr(),
                                style: TextStyle(
                                    fontSize: AppPadding.p12,
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                    ],
                  ),
                ],
              ),
      );
    },
        listener: (context, state) {
      if (state is UpdateRoomSucsseState) {
        setState(() {
          RoomScreen.roomIsLoked = true;
        });
      }
    }
    );
  }

  Future<void> stopPK() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(StringManager.chooseTimePK.tr()),
          content: const TimePKWidget(),
          actions: <Widget>[
            TextButton(
              child: Text(
                StringManager.cancle.tr(),
                style: const TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(StringManager.startBattle.tr(),
                  style: const TextStyle(color: Colors.black)),
              onPressed: () {
                widget.notifyRoom();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  Future<void> clearChat()async{
    RoomScreen.clearTimeNotifier.value =
        DateTime.now().millisecondsSinceEpoch;
    var mapInformation = {"messageContent":{
      "message":"removeChat",

    }} ;
    String map = jsonEncode(mapInformation);
    ZegoUIKit().sendInRoomCommand(map ,[]);

  }
}
