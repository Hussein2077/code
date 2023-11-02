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
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/message_count_notifecation.dart';




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
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: ColorManager.whiteColor,
                  ),
                  height: 500,
                  //TODO change that
                  child: ChatPage()));
        },
        child:  MessageCountNotifcation(widget:                  Image.asset(AssetsPath.messages,width:  AppPadding.p40,height: AppPadding.p40,),);
  }
}
