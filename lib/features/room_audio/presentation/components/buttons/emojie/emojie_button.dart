import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
 
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/emojie/emojie_widget.dart';



class EmoijeButton extends StatelessWidget {
  final String userId ;
  final String roomId ;
  const EmoijeButton({required this.userId ,required this.roomId, super.key});

@override
Widget build(BuildContext context) {
  return InkWell(
    onTap: () {
      bottomDailog(context: context, widget:  EmojieWidget( userId:  userId, roomId:  roomId,));
    },
    child:   Image.asset(AssetsPath.emojie,width: ConfigSize.defaultSize!*4,height: ConfigSize.defaultSize!*4)


  );
}
}
