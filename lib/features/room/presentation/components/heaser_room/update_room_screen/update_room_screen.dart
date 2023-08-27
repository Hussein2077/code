import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

import '../../../../../../core/resource_manger/string_manager.dart';

class UpdateRoomScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ConfigSize.defaultSize! * 50,
      width: ConfigSize.screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            StringManager.roomSetting.tr(),
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          Container(
            width: ConfigSize.screenWidth,
            child: Column(
              children: [
                Spacer(
                  flex: 5,
                ),
                Text(
                  StringManager.roomName.tr(),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                Spacer(
                  flex: 1,
                ),
                TextField(
                    decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: ColorManager.gray.withOpacity(0.4),
                )),
                Spacer(
                  flex: 2,
                ),
                Text(
                  StringManager.roomIntro.tr(),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                Spacer(
                  flex: 1,
                ),
                TextField(
                    decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: ColorManager.gray.withOpacity(0.4),
                )),
                Spacer(
                  flex: 5,
                ),
              ],
            ),
          ),
          Spacer(
            flex: 5,
          ),
        ],
      ),
    );
  }
}
