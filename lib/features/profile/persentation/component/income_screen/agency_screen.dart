import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/income_screen/widget/card_diamonds_earned.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/income_screen/widget/linear_gradient_contaner.dart';

class AgencyScreen extends StatelessWidget {
  const AgencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
          children: [
            SizedBox(height: ConfigSize.defaultSize! / 0.2),
            const HeaderWithOnlyTitle(title: StringManager.income),
            SizedBox(height: ConfigSize.defaultSize! / 0.4),
            const CardOfDiamondEarned(
              assetCard: AssetsPath.moneyBag,
            ),
            SizedBox(height: ConfigSize.defaultSize! / 0.4),
             LinearGradientContainer(
              onPress: (){
                Navigator.pushNamed(context, Routes.liveReportScreen);
              },
              title: StringManager.liveReport,
            ),
            const Spacer(),
            MainButton(
              onTap: () {
                 Navigator.pushNamed(context, Routes.instructionsScreen);
              },
              title: StringManager.joinRequests,
            ),
            SizedBox(height: ConfigSize.defaultSize! / 0.4),
            MainButton(
              onTap: () {
                Navigator.pushNamed(context, Routes.cashWithdrawal);
              },
              title: StringManager.withdrawal,
            ),

            SizedBox(height: ConfigSize.defaultSize! / 0.4),
            MainButton(
              onTap: () {
                Navigator.pushNamed(context, Routes.exchangeForGoldScreen);
              },
              title: StringManager.withdrawal,
            ),
            Icon(Icons.question_mark_sharp,color: Theme.of(context).iconTheme.color),
            Text(StringManager.whatIsAgency,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center),
            SizedBox(height: ConfigSize.defaultSize! / 0.4),

          ],
        ));
  }
}
