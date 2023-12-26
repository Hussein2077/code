
import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/time_PK_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/profile/profile_room_body_controler.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/profile/user_porfile_in_room_body.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/profile/widgets/time_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_admin_room/admin_room_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_admin_room/admin_room_events.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_user_in_room/users_in_room_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_user_in_room/users_in_room_events.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_events.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/room_screen_controler.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/uikit_service.dart';

class SettingsButton extends StatefulWidget {
  final UserDataModel userData;
  final EnterRoomModel roomData;
  final LayoutMode layoutMode;
  final bool isOnMic;

  final bool myProfrile;

  final bool isAdminOrHost;

  const SettingsButton({
    required this.roomData,
    required this.userData,
    required this.layoutMode,
    required this.isAdminOrHost,
    required this.isOnMic,
    required this.myProfrile,
    super.key,
  });

  @override
  State<SettingsButton> createState() => _SettingsButtonState();
}

class _SettingsButtonState extends State<SettingsButton> {
  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      // if (!widget.myProfrile) StringManager.report.tr(),
      if (widget.userData.id != MyDataModel.getInstance().id &&
          widget.userData.id != widget.roomData.ownerId &&
          MyDataModel.getInstance().id == widget.roomData.ownerId)
        StringManager.admin.tr(),
      if (widget.isAdminOrHost)
        RoomScreen.banedUsers.containsKey(widget.userData.id.toString())
            ? StringManager.writeUnBan.tr()
            : StringManager.writeBan.tr(),
      if (widget.isAdminOrHost && widget.isOnMic == false)
        StringManager.inviteFriend.tr(),
      if(widget.isAdminOrHost)
        StringManager.block.tr(),
      if(widget.isAdminOrHost && widget.isOnMic && !RoomScreen.usersHasMute.contains(widget.userData.id.toString()))
        StringManager.muteMic.tr(),
      if(widget.isAdminOrHost && widget.isOnMic && RoomScreen.usersHasMute.contains(widget.userData.id.toString()))
        StringManager.unMuteMic.tr(),
    ];
    return Container(
      width: ConfigSize.defaultSize! * 8.0,
      height: ConfigSize.defaultSize! * 2.7,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize!),
          color: Colors.white.withOpacity(0.2)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Text(
            StringManager.settings.tr(),
            style: TextStyle(
              fontSize: ConfigSize.defaultSize! * 1.5,
              fontWeight: FontWeight.w500,
              color: ColorManager.gray,
            ),
            overflow: TextOverflow.fade,
          ),

          items: items.map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: ConfigSize.defaultSize! * 1.4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.fade,
                    ),
                  )).toList(),

          onChanged: (value) {
            if(value == StringManager.block.tr()){
              showTimeDialog(context);
            }
            if(value == StringManager.muteMic.tr() || value == StringManager.unMuteMic.tr()){
              if (RoomScreen.usersHasMute.contains(
                  widget.userData.id.toString())) {
                sendMuteUserMessage(
                    mute: false,
                    userId:
                    widget.userData.id.toString(),
                    ownerId: widget.roomData.ownerId
                        .toString());
              } else {
                if (!(widget.roomData.ownerId.toString() !=
                    MyDataModel.getInstance().id.toString() &&
                    RoomScreen.adminsInRoom.containsKey(
                        widget.userData.id
                            .toString()))) {
                  sendMuteUserMessage(
                      mute: true,
                      userId:
                      widget.userData.id.toString(),
                      ownerId: widget.roomData.ownerId
                          .toString());
                }
              }
            }
            if (value == StringManager.admin.tr()) {
              BlocProvider.of<AdminRoomBloc>(context).add(AddAdminEvent(
                  ownerId: widget.roomData.ownerId.toString(),
                  userId: widget.userData.id.toString()));
            }
            // if (value == StringManager.report.tr()) {
            //   repoertsAction(context: context, userData: widget.userData);
            // }
            if (value == StringManager.writeBan.tr()) {
              Navigator.pop(context);
              banFromWriteAction(
                  context: context,
                  userData: widget.userData,
                  roomData: widget.roomData);
            }
            if (value == StringManager.writeUnBan.tr()) {
              Navigator.pop(context);

              banFromWriteAction(
                  context: context,
                  userData: widget.userData,
                  roomData: widget.roomData);
            }
            if (value == StringManager.inviteFriend.tr()) {
              chooseSeatToInvatation(
                  widget.layoutMode,
                  context,
                  widget.roomData.ownerId.toString(),
                  widget.userData.id.toString());
            }
          },
          icon: Icon(Icons.settings, color: ColorManager.gray, size: ConfigSize.defaultSize! * 1.8),
          iconEnabledColor: Colors.white,
          iconDisabledColor: Colors.grey,
          buttonHeight: ConfigSize.defaultSize! * 1.8,
          buttonWidth: ConfigSize.defaultSize! * 70,
          buttonDecoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          itemHeight: ConfigSize.defaultSize! * 5,
          itemPadding: EdgeInsets.only(
              left: ConfigSize.defaultSize! * 1.8,
              right: ConfigSize.defaultSize! * 1.8),
          dropdownMaxHeight: ConfigSize.defaultSize! * 15,
          dropdownWidth: ConfigSize.defaultSize! * 13,
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: ColorManager.giftColors.withOpacity(0.3),
          ),
          scrollbarRadius: const Radius.circular(40),
          scrollbarThickness: 6,
          scrollbarAlwaysShow: true,
          offset: const Offset(-20, 0),
        ),
      ),
    );
  }

  Future<void> sendMuteUserMessage(
      {required bool mute,
        required String userId,
        required String ownerId}) async {
    if (mute) {
      ZegoUIKit.instance.turnMicrophoneOn(false, userID: userId);
      BlocProvider.of<OnRoomBloc>(context)
          .add(MuteUserMicEvent(userId: userId, ownerId: ownerId));
      RoomScreen.usersHasMute.add(userId);
      UserProfileInRoom.updatebuttomBar.value =
          UserProfileInRoom.updatebuttomBar.value + 1;
    } else {
      RoomScreen.usersHasMute.remove(userId);
      BlocProvider.of<OnRoomBloc>(context)
          .add(UnMuteUserMicEvent(userId: userId, ownerId: ownerId));
      UserProfileInRoom.updatebuttomBar.value =
          UserProfileInRoom.updatebuttomBar.value + 1;
    }
    var mapInformation = {
      "messageContent": {"message": "muteUser", 'mute': mute, 'id_user': userId}
    };
    String map = jsonEncode(mapInformation);
    ZegoUIKit.instance.sendInRoomCommand(map, []);
  }

  Future<void> showTimeDialog(BuildContext context ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white.withOpacity(0.90),
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(16.0), // Adjust the radius as needed
          ),
          title: Center(child: Text(StringManager.block.tr())),
          content: TimeWidget(userData: widget.userData, roomData: widget.roomData,),
        );
      },
    );
  }
}
