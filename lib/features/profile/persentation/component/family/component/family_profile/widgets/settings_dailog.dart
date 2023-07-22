import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resours_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/custom_horizental_dvider.dart';

class SettingsDailog extends StatelessWidget {
  const SettingsDailog({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 5,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            settingsTabs(
              context: context,
              title: StringManager.joinRequests,
              onTap: () => Navigator.pushNamed(context, Routes.familyRequests),
            ),
            CustomHorizntalDvider(width: MediaQuery.of(context).size.width),
            settingsTabs(
              context: context,
              title: StringManager.deleteFamily,
            ),
            MainButton(
                height: ConfigSize.defaultSize! * 4,
                buttonColor: ColorManager.bageGriedinet,
                onTap: () {
                  Navigator.pop(context);
                },
                title: StringManager.cancel)
          ],
        ),
      ),
    );
  }
}

Widget settingsTabs(
    {required BuildContext context, required title, void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Text(
      title,
      style: Theme.of(context).textTheme.headlineLarge,
    ),
  );
}
