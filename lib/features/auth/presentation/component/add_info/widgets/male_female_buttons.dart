import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';

class MaleFemaleButtons extends StatefulWidget {
  const MaleFemaleButtons({super.key});

  @override
  State<MaleFemaleButtons> createState() => _MaleFemaleButtonsState();
}

class _MaleFemaleButtonsState extends State<MaleFemaleButtons> {
  String selectedGender = "male";
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            selectedGender = "male";
            setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(
                color: selectedGender == "male"
                    ? ColorManager.lightBlue
                    : ColorManager.lightGray,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(ConfigSize.defaultSize! * 3),
                  topLeft: Radius.circular(ConfigSize.defaultSize! * 3),
                )),
            width: (MediaQuery.of(context).size.width - 50) / 2,
            height: ConfigSize.defaultSize! * 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  StringManager.male,
                  style: TextStyle(
                      color: selectedGender == "male"
                          ? ColorManager.blue
                          : Colors.grey,
                      fontSize: ConfigSize.defaultSize! * 1.8),
                ),
                SizedBox(
                  width: ConfigSize.defaultSize,
                ),
                Image.asset(selectedGender == "male"
                    ? AssetsPath.maleIcon
                    : AssetsPath.unSelectedMaleIcon)
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            selectedGender = "female";
            setState(() {});
          },
          child: Container(
            width: (MediaQuery.of(context).size.width - 50) / 2,
            height: ConfigSize.defaultSize! * 6,
            decoration: BoxDecoration(
              color: selectedGender == "female"
                  ? ColorManager.lightPink
                  : ColorManager.lightGray,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(ConfigSize.defaultSize! * 3),
                topRight: Radius.circular(ConfigSize.defaultSize! * 3),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  StringManager.female,
                  style: TextStyle(
                      color: selectedGender == "female"
                          ? ColorManager.pink
                          : Colors.grey,
                      fontSize: ConfigSize.defaultSize! * 1.8),
                ),
                SizedBox(
                  width: ConfigSize.defaultSize,
                ),
                Image.asset(selectedGender == "female"
                    ? AssetsPath.femaleIcon
                    : AssetsPath.unSelectedFemaleIcon)
              ],
            ),
          ),
        )
      ],
    );
  }
}
