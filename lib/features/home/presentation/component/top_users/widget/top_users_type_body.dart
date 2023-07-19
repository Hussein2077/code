import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';

import 'package:tik_chat_v2/features/home/presentation/component/top_users/widget/time_tabs.dart';

import 'top_user_time_body.dart';

class TopUsersTypeBody extends StatelessWidget {
 final TabController timeController ; 
  const TopUsersTypeBody({required this.timeController, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         TimeTabs(timeController: timeController,),
           SizedBox(height: ConfigSize.defaultSize!*3,),           

    Expanded(
    child: TabBarView(
      controller: timeController,
      children:const [
    TopUserTimeBody(),
    TopUserTimeBody(),
    TopUserTimeBody(),
    ]),
    )
     
      ],
    );
  }
}
