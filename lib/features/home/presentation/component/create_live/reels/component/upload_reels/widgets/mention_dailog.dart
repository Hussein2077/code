import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/user_info_row.dart';

class MentionDailog extends StatelessWidget {
  const MentionDailog({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Scaffold(
        body: ListView.builder(
            itemExtent: 70,
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return UserInfoRow(
                userData: UserDataModel(),
                endIcon: MainButton(
                  onTap: () {},
                  title: StringManager.mention,
                  titleSize: ConfigSize.defaultSize! * 1.6,
                  width: ConfigSize.defaultSize! * 8,
                  height: ConfigSize.defaultSize! * 3,
                ),
              );
            }),
      ),
    );
  }
}
