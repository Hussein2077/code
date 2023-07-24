

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';

class FamilyProfileBottomBar extends StatelessWidget {
  const FamilyProfileBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!*3 , vertical: ConfigSize.defaultSize!*2.5),
      width: MediaQuery.of(context).size.width,
      height: ConfigSize.defaultSize!*9,
      color: Theme.of(context).colorScheme.secondary,
      child: MainButton(onTap: (){}, title: StringManager.requestToJoin ,),
    );
  }
}