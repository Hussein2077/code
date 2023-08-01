import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class RoomTypeButton extends StatefulWidget {
  static   String? roomType;

  const RoomTypeButton({super.key});

  @override
  State<RoomTypeButton> createState() => _RoomTypeButtonState();
}

class _RoomTypeButtonState extends State<RoomTypeButton> {
  final List<String> global = ["sadasd", "dasgfg" , "gfdgsdfh", "gdskj"];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ConfigSize.defaultSize!*17,
      height: ConfigSize.defaultSize!*5,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(ConfigSize.defaultSize!) ,color: Colors.white.withOpacity(0.2)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Text(
            "asdasdasd",
            style: TextStyle(
              fontSize: ConfigSize.defaultSize! * 1.8,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          items: global
              .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child :    Text(
                        item,
                        style: TextStyle(
                          fontSize: ConfigSize.defaultSize! * 1.8,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),))
              .toList(),
          value: RoomTypeButton.roomType,
          onChanged: (value) {
            setState(() {
              RoomTypeButton.roomType = value as String;
            });
          },
          icon: const Icon(
            Icons.keyboard_arrow_down,
          ),
          iconSize: ConfigSize.defaultSize! * 1.8,
          iconEnabledColor: Colors.white,
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
  }
}
