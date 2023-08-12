import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class PublicPriveteButton extends StatefulWidget {
  static   String lockedOrUn = StringManager.public;

  const PublicPriveteButton({super.key});

  @override
  State<PublicPriveteButton> createState() => _PublicPriveteButtonState();
}

class _PublicPriveteButtonState extends State<PublicPriveteButton> {
  final List<String> global = [StringManager.public, StringManager.private];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ConfigSize.defaultSize!*17,
      height: ConfigSize.defaultSize!*5,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(ConfigSize.defaultSize!) ,color: Colors.white.withOpacity(0.2)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Row(
            children: [
              const Image(image: AssetImage(AssetsPath.whiteGlobalIcon)),
              SizedBox(
                width: ConfigSize.defaultSize,
              ),
              Expanded(
                child: Text(
                  StringManager.public,
                  style: TextStyle(
                    fontSize: ConfigSize.defaultSize! * 1.8,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          items: global
              .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Row(
                    children: [
                      item == StringManager.public
                          ? const Image(image: AssetImage(AssetsPath.whiteGlobalIcon))
                          : const Image(image: AssetImage(AssetsPath.lock)),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        item,
                        style: TextStyle(
                          fontSize: ConfigSize.defaultSize! * 1.8,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  )))
              .toList(),
          value: PublicPriveteButton.lockedOrUn,
          onChanged: (value) {
            setState(() {
              PublicPriveteButton.lockedOrUn = value as String;
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
