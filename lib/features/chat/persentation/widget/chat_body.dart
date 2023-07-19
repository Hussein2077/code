import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/features/chat/persentation/widget/chat_user_row.dart';

// ignore: must_be_immutable
class ChatBody extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  ChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
          width: MediaQuery.of(context).size.width - 50,
          height: ConfigSize.defaultSize! * 5,
          decoration: BoxDecoration(
              color: ColorManager.lightGray,
              borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 2)),
          child: Row(children: [
            Image.asset(
              AssetsPath.graySearchIcon,
              scale: 2.5,
            ),
            SizedBox(
              width: ConfigSize.defaultSize,
            ),
            SizedBox(
              width: ConfigSize.defaultSize! * 27,
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: StringManager.search,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
              ),
            )
          ]),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: ConfigSize.defaultSize! * 2),
                    child: const ChatUserRow());
              }),
        )
      ],
    );
  }
}
