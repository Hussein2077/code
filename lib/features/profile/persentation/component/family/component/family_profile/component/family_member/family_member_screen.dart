

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/screen_back_ground.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/family/component/family_profile/widgets/family_member_card.dart';

class FamilyMemberScreen extends StatelessWidget {
  const FamilyMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
        Brightness currentBrightness = Theme.of(context).brightness;
    bool isDarkTheme = currentBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ScreenBackGround(image: isDarkTheme? AssetsPath.familyProfileCoverBlack :AssetsPath.familyProfileCover, child:  Column(children: [
        SizedBox(height: ConfigSize.defaultSize!*3.5,),
        const HeaderWithOnlyTitle(title: StringManager.familyMember),
        Expanded(
          child: GridView.builder(
            itemCount: 20,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3 , mainAxisSpacing: ConfigSize.defaultSize!*3 , childAspectRatio: 1.1), itemBuilder: (context , index){
            return const FamilyMemberCard();
          }),
        )

      ],))
    );
  }
}