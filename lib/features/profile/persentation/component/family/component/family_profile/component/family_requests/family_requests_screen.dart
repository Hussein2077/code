

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/user_info_row.dart';

class FamilyRequestsScreen extends StatelessWidget {
  const FamilyRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(children: [
        SizedBox(height: ConfigSize.defaultSize!*3,),
        const HeaderWithOnlyTitle(title: StringManager.joinRequests),
        Expanded(child: ListView.builder(
          itemCount: 20,
          itemExtent:  70,
          itemBuilder: (context , index ){
            return UserInfoRow( endIcon: Row(children: [
              Image.asset(AssetsPath.acceptIcon , scale: 2.8,),
              SizedBox(width: ConfigSize.defaultSize!*2,),
              Image.asset(AssetsPath.declineIcon , scale: 2.8,)

            ],),);

        }))

      ],),
    );
  }
}