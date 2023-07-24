

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/user_info_row.dart';

class FFFVScreen extends StatelessWidget {
  final String title ;
  const FFFVScreen({required this.title,  super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:Column(children: [
      SizedBox(height: ConfigSize.defaultSize!*3.2,),
      HeaderWithOnlyTitle(title: title),
      Expanded(
        child: ListView.builder(
          itemCount: 10,
          itemExtent: 80,
          itemBuilder: (context , index){
         return  UserInfoRow(userData: OwnerDataModel(), endIcon: Icon(Icons.arrow_forward_ios , color: Theme.of(context).colorScheme.primary, size: ConfigSize.defaultSize!*2,),);
        }),
      )

    ],) ,);
  }
}