import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/create_room_manager/create_room_bloc.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/create_room_manager/create_room_states.dart';
import 'package:tik_chat_v2/features/room/data/model/all_main_classes_model.dart';

class RoomTypeButton extends StatefulWidget {
  static AllMainClassesModel?  roomType  ;
final String? roomTypeName;
  const RoomTypeButton({ this.roomTypeName,super.key});

  @override
  State<RoomTypeButton> createState() => _RoomTypeButtonState();
}

class _RoomTypeButtonState extends State<RoomTypeButton> {
   List<AllMainClassesModel> global = [];

  @override
  Widget build(BuildContext context) {
  return  BlocBuilder<CreateRoomBloc,CreateRoomStates>(
      builder: (context,state){
        switch(state.typesRoomState){
          case RequestState.loaded:
            global = state.typesRoom;
            return Container(
              width: ConfigSize.defaultSize! * 17,
              height: ConfigSize.defaultSize! * 5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ConfigSize.defaultSize!),
                  color: Theme.of(context).colorScheme!.secondary),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Text(
                  ( RoomTypeButton.roomType?.name ==null)?
                   widget.roomTypeName?? StringManager.chooseTyeps.tr():RoomTypeButton.roomType!.name,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: ConfigSize.defaultSize! * 1.8,
                          fontWeight: FontWeight.bold,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  items: global
                      .map((item) => DropdownMenuItem<AllMainClassesModel>(
                    value: item,
                    child :Text(
                      item.name,
                      style:



                      Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: ConfigSize.defaultSize! * 1.8,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),)).toList(),
                  // value:RoomTypeButton.roomType ,
                  onChanged: (value) {
                    setState(() {
                      AllMainClassesModel allMainClassesModel = value as AllMainClassesModel ;
                      RoomTypeButton.roomType = allMainClassesModel;
                    });
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                  ),
                  iconSize: ConfigSize.defaultSize! * 1.8,
                  iconEnabledColor:
                  Theme.of(context).colorScheme.primary,
                  iconDisabledColor: Colors.grey,
                  buttonHeight: ConfigSize.defaultSize! * 1.8,
                  buttonWidth: ConfigSize.defaultSize! * 170,
                  buttonPadding: EdgeInsets.only(
                      left: ConfigSize.defaultSize!, right: ConfigSize.defaultSize!),
                  buttonDecoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  itemHeight: ConfigSize.defaultSize! * 5,
                  itemPadding: EdgeInsets.only(
                      left: ConfigSize.defaultSize! * 1.8,
                      right: ConfigSize.defaultSize! * 1.8),
                  dropdownMaxHeight: ConfigSize.defaultSize! * 15,
                  dropdownWidth: ConfigSize.defaultSize! * 18,
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: ColorManager.lightGray.withOpacity(0.5),
                  ),
                  scrollbarRadius: const Radius.circular(40),
                  scrollbarThickness: 6,
                  scrollbarAlwaysShow: true,
                  offset: const Offset(-20, 0),
                ),
              ),
            );
          case RequestState.loading:
          case RequestState.error:
          return const SizedBox();
        }




      },
    ) ;

  }
}
