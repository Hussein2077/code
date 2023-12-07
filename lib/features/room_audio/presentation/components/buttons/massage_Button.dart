import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/message_count_comet_chat.dart';
import 'package:tik_chat_v2/core/widgets/message_count_notifecation.dart';
import 'package:tik_chat_v2/features/chat/user_chat/chat_page.dart';

class MassageButton extends StatelessWidget {
  final MyDataModel myDataModel;

  const MassageButton({required this.myDataModel, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          bottomDailog(
              context: context,
              widget: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorManager.gold, width: 1),
                    color: ColorManager.whiteColor,
                  ),
                  height: ConfigSize.defaultSize! * 65,
                  child: const ChatPage()));
        },
        child: ChatCountMessageCometChat(
          widget: Image.asset(
            AssetsPath.messages,
            width: AppPadding.p40,
            height: AppPadding.p40,
          ),
        ));
  }
}
