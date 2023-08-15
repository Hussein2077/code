

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room/presentation/components/buttons/emojie/emojie_page_view.dart';


class EmojieWidget extends StatelessWidget {
  final String userId ;
  final String roomId ;
  const EmojieWidget({required this.roomId,required this.userId , Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
        height: ConfigSize.defaultSize! * 29,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(ConfigSize.defaultSize!-2),
                topLeft: Radius.circular(ConfigSize.defaultSize!-2)),
            color: ColorManager.deepBlue),
        padding: EdgeInsets.symmetric(vertical:ConfigSize.defaultSize!+2),
        child:  EmojiePageView(numberOfPages: 1 , userId: userId, roomId: roomId,));
  }
}
