import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/features/auth/presentation/component/add_info/widgets/add_profile_pic.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/user_profile/component/edit_info/widget/compelete_profile.dart';

import 'widget/user_info_widget.dart';

class EditInfoScreen extends StatelessWidget {
  const EditInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const HeaderWithOnlyTitle(title: StringManager.editProfile),
          const CompleteProfile(),
          title(context: context, title: StringManager.personalInfo),
          const UserInfoWidget(),
          title(context: context, title: StringManager.addImage),
          const AddProFilePic(),
        ],
      ),
    );
  }
}

Widget title({required BuildContext context, required String title}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.symmetric(
        vertical: ConfigSize.defaultSize!, horizontal: ConfigSize.defaultSize!),
    color: Theme.of(context).colorScheme.secondary,
    child: Text(
      title,
      style: Theme.of(context).textTheme.bodyLarge,
    ),
  );
}
