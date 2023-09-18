

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manager_user_in_room/users_in_room_bloc.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manager_user_in_room/users_in_room_events.dart';


class BlockButton extends StatefulWidget {
final UserDataModel userData;
  final EnterRoomModel roomData; 
  
   const BlockButton({
    required this.userData,
    required this.roomData,
    super.key});

  @override
  State<BlockButton> createState() => _BlockButtonState();
}

class _BlockButtonState extends State<BlockButton> {
    final List<String> items = [
 StringManager.fiveMin.tr(),
    StringManager.fiftyMin.tr(),
    StringManager.thirtyMin.tr(),
    StringManager.sixtyMin.tr(),
    StringManager.twenyFourMin.tr()
  ];
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return     Container(
                        width: ConfigSize.defaultSize! * 6.0,
                        height: ConfigSize.defaultSize! * 2.7,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(ConfigSize.defaultSize!),
                            color: Colors.white.withOpacity(0.2)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Text(
                              StringManager.block.tr(),
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
                                 Navigator.pop(context);
                                                if (value ==
                                                    StringManager.fiveMin
                                                        .tr()) {
                                                  BlocProvider.of<UsersInRoomBloc>(
                                                          context)
                                                      .add(kickoutUser(
                                                          ownerId: widget.roomData
                                                              .ownerId
                                                              .toString(),
                                                          userId: widget.userData.id
                                                              .toString(),
                                                          minutes: "5"));
                                                } else if (value ==
                                                    StringManager.fiftyMin
                                                        .tr()) {
                                                  BlocProvider.of<UsersInRoomBloc>(
                                                          context)
                                                      .add(kickoutUser(
                                                          ownerId: widget.roomData
                                                              .ownerId
                                                              .toString(),
                                                          userId: widget.userData.id
                                                              .toString(),
                                                          minutes: "15"));
                                                } else if (value ==
                                                    StringManager.thirtyMin
                                                        .tr()) {
                                                  BlocProvider.of<UsersInRoomBloc>(
                                                          context)
                                                      .add(kickoutUser(
                                                          ownerId: widget.roomData
                                                              .ownerId
                                                              .toString(),
                                                          userId: widget.userData.id
                                                              .toString(),
                                                          minutes: "30"));
                                                } else if (value ==
                                                    StringManager.sixtyMin
                                                        .tr()) {
                                                  BlocProvider.of<UsersInRoomBloc>(
                                                          context)
                                                      .add(kickoutUser(
                                                          ownerId: widget.roomData
                                                              .ownerId
                                                              .toString(),
                                                          userId: widget.userData.id
                                                              .toString(),
                                                          minutes: "60"));
                                                } else if (value ==
                                                    StringManager.twenyFourMin
                                                        .tr()) {
                                                  BlocProvider.of<UsersInRoomBloc>(
                                                          context)
                                                      .add(kickoutUser(
                                                          ownerId: widget.roomData
                                                              .ownerId
                                                              .toString(),
                                                          userId: widget.userData.id
                                                              .toString(),
                                                          minutes: "1440"));
                                                }
                            },
                            icon: Icon(Icons.block_flipped,
                                color: ColorManager.gray,
                                size: ConfigSize.defaultSize! * 1.8),
                
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
                            dropdownWidth: ConfigSize.defaultSize! * 10,
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