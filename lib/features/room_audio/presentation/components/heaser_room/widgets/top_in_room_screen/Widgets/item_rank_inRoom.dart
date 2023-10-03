
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/home/data/model/user_top_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/heaser_room/widgets/top_in_room_screen/Widgets/user_room_row.dart';

class ItemRankInRoom extends StatelessWidget {
  final UserTopModel userTopMode ;


  const ItemRankInRoom({ required this.userTopMode,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserRoomRow(
          userTopMode: userTopMode,
        ),

        Divider(
          indent: ConfigSize.defaultSize! * 8,
          endIndent: 0,
          thickness: 1,
          height: ConfigSize.defaultSize! * 2,
          color: ColorManager.lightGray.withOpacity(0.2),
        )
      ],
    );
  }
}
