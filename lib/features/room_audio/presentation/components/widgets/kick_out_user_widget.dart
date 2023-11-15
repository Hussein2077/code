
// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';


class KickOutUserWidget extends StatelessWidget {
  final bool isKick ;
  Map<String, int> durationKickout;
  KickOutUserWidget({required this.durationKickout ,   required this.isKick , Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   AnimatedOpacity(
      opacity: isKick ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: Container(
        height: 50,
        width: 200,

        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        // ignore: sort_child_properties_last
        child: Center(
            child: Text(
              StringManager().bloc( durationKickout: durationKickout['durationKickout'].toString(),).toString().tr(),
              style: const TextStyle(color: ColorManager.whiteColor),
            )),

        decoration: (BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(20))),
      ),
    );
  }
}


