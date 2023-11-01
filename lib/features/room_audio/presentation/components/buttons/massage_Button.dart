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
                  child: SizedBox()));
        },
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Rooms')
                .orderBy('last_message_time', descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              List data = !snapshot.hasData
                  ? []
                  : snapshot.data!.docs
                      .where((element) => element['users']
                          .toString()
                          .contains(FirebaseAuth.instance.currentUser?.uid??''))
                      .toList();

              int totalMessages = 0;
              int temp = 0;
              for (int i = 0; i < data.length; i++) {
                if (data[i]['sent_by'] !=
                    FirebaseAuth.instance.currentUser?.uid) {
                  totalMessages = data[i]['unRead'];
                  temp += totalMessages;
                }
              }

              return Stack(
                children: [
                  Image.asset(AssetsPath.messages,width:  AppPadding.p40,height: AppPadding.p40,),
                  if (temp != 0)
                    Container(
                       padding:const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red),
                      child: Text(
                        '${temp}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                ],
              );
            }));
  }
}
