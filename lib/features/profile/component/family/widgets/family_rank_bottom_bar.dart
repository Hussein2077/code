

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/features/profile/component/family/component/create_family/create_family_screen.dart';

class FamilyRankBottomBar extends StatelessWidget {
  const FamilyRankBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        bottomDailog(context: context, widget: const CreateFamily());
      },
      child: Container(width: MediaQuery.of(context).size.width,
      height: ConfigSize.defaultSize!*6,
      color: ColorManager.lightOrange,
      child: Center(child: Text(StringManager.createFamily , style: TextStyle(color: Colors.orange , fontSize: ConfigSize.defaultSize!*2) ,),),
      ),
    );
  }
}