import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';

import 'widgets/family_profile_bottom_bar.dart';
import 'widgets/family_profile_info.dart';

class FamilyProfileScreen extends StatelessWidget {
  const FamilyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Brightness currentBrightness = Theme.of(context).brightness;
    bool isDarkTheme = currentBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(children: [
        Expanded(child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: isDarkTheme
                  ?null: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AssetsPath.familyProfileCover),
                          fit: BoxFit.fitHeight))
                 ,
                 child: const FamilyProfileInfo(),
            )
          ],
        ),
      ),),
const FamilyProfileBottomBar()
      ],)
    );
  }
}
