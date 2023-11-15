import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/profile/profile_room_body_controler.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_admin_room/admin_room_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_admin_room/admin_room_events.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/room_screen_controler.dart';

class SettingsButton extends StatefulWidget {
  final UserDataModel userData;
  final EnterRoomModel roomData;
  final LayoutMode layoutMode;
  final bool isOnMic;

  final bool myProfrile;

  final bool isAdminOrHost;

  const SettingsButton(
      {required this.roomData,
      required this.userData,
      required this.layoutMode,
      required this.isAdminOrHost,
      required this.isOnMic,
      required this.myProfrile,
      super.key});

  @override
  State<SettingsButton> createState() => _SettingsButtonState();
}

class _SettingsButtonState extends State<SettingsButton> {
  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      StringManager.mention.tr(),
      if (!widget.myProfrile) StringManager.reports.tr(),
      if (widget.userData.id == widget.roomData.ownerId) StringManager.admin.tr(),
      if (widget.isAdminOrHost)
        RoomScreen.banedUsers.containsKey(widget.userData.id.toString())
            ? StringManager.writeUnBan.tr()
            : StringManager.writeBan.tr(),
      if (widget.isAdminOrHost && widget.isOnMic == false)
        StringManager.inviteFriend.tr(),
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

          items: items
              .map((item) => DropdownMenuItem(
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
                  ))
              .toList(),
          // value:RoomTypeButton.roomType ,
          onChanged: (value) {
            if (value == StringManager.mention.tr()) {
              mentionAction(
                  context: context,
                  roomData: widget.roomData,
                  userData: widget.userData);
            }

            if (value == StringManager.admin.tr()) {
              BlocProvider.of<AdminRoomBloc>(context).add(AddAdminEvent(
                  ownerId: widget.roomData.ownerId.toString(),
                  userId: widget.userData.id.toString()));
            }
            if (value == StringManager.reports.tr()) {
              repoertsAction(context: context, userData: widget.userData);
            }
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
          icon: Icon(Icons.settings,
              color: ColorManager.gray, size: ConfigSize.defaultSize! * 1.8),

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
}
