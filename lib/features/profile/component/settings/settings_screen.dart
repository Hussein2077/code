import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resours_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/features/profile/component/settings/widget/linking_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          SizedBox(
            height: ConfigSize.defaultSize! * 3.5,
          ),
          const HeaderWithOnlyTitle(title: StringManager.settings),
          SizedBox(
            height: ConfigSize.defaultSize! * 3.5,
          ),
          settingsRow(
              context: context,
              icon: AssetsPath.linkingIcon,
              title: StringManager.linkingAccount , 
              onTap: () => bottomDailog(context: context, widget: const LinkingScreen()),
              
              ),
          SizedBox(
            height: ConfigSize.defaultSize! * 3.5,
          ),
          settingsRow(
              context: context,
              icon: AssetsPath.languageIcon,
              title: StringManager.language , 
              onTap: () => Navigator.pushNamed(context, Routes.language),),
          SizedBox(
            height: ConfigSize.defaultSize! * 3.5,
          ),
          settingsRow(
              context: context,
              icon: AssetsPath.modeIcon,
              title: StringManager.mode ,
              onTap: () => Navigator.pushNamed(context, Routes.mode),
              ),
        ],
      ),
    );
  }
}

Widget settingsRow({
  required BuildContext context,
  required String icon,
  required String title,
  void Function()? onTap
}) {
  return InkWell(
    onTap: onTap,
    child: Row(
      children: [
        const Spacer(
          flex: 1,
        ),
        Image.asset(
          icon,
          scale: 2,
        ),
        const Spacer(
          flex: 1,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const Spacer(
          flex: 15,
        ),
        Icon(
          Icons.arrow_forward_ios,
          color: Theme.of(context).colorScheme.primary,
          size: ConfigSize.defaultSize! * 2,
        ),
        const Spacer(
          flex: 1,
        ),
      ],
    ),
  );
}
