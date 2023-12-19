import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/invit_screen/invit_screen_dtails.dart';

import 'profile_row_item.dart';

class Card3 extends StatelessWidget {
  final MyDataModel myData;
  final bool isDarkTheme;

  const Card3({required this.myData, required this.isDarkTheme, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width - 30,
        height: ConfigSize.defaultSize! * 18,
        decoration: BoxDecoration(
            color: isDarkTheme ? Colors.grey.withOpacity(0.3) : Colors.white,
            borderRadius: BorderRadius.circular(ConfigSize.defaultSize!)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ProfileRowItem(
              title: StringManager.complaints.tr(),
              image: AssetsPath.customServiceIcon,
              onTap: () => Navigator.pushNamed(context, Routes.custoumService,
                  arguments: myData.id),
            ),
            ProfileRowItem(
                title: StringManager.invitaion.tr(),
                image: AssetsPath.invitation,
    scale:20,
    color:Colors.grey,
                onTap:
                //     () {
                //   bottomDailog(context: context, widget: InvitScreenDetails());
                // }
                () => Navigator.pushNamed(context, Routes.invitScreenDetails),
                ),
            ProfileRowItem(
              title: StringManager.settings.tr(),
              image: AssetsPath.settiengsIcon,
              onTap: () => Navigator.pushNamed(context, Routes.settings),
            ),
          ],
        ));
  }
}
