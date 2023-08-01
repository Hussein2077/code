import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/custom_horizental_dvider.dart';
import 'package:tik_chat_v2/features/profile/presentation/component/income_screen/widget/card_diamonds_earned.dart';

class ExchangeForGoldScreen extends StatelessWidget {

  const ExchangeForGoldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: ConfigSize.defaultSize!*5,),
          const CardOfDiamondEarned(
            assetCard: AssetsPath.moneyBag,
          ),
          Text(
            StringManager.recharge,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          CustomHorizntalDvider(
            width: ConfigSize.defaultSize! * 3,
            color:  ColorManager.orang,
          ),
          Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(top: ConfigSize.defaultSize!),
                      margin: EdgeInsets.symmetric(
                          vertical: ConfigSize.defaultSize!,
                          horizontal: ConfigSize.defaultSize!),
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(ConfigSize.defaultSize!),
                          color: Theme.of(context).colorScheme.secondary),
                      child: Column(
                        children: [
                          Image.asset(
                            AssetsPath.goldCoinIcon,
                            scale: 4,
                          ),
                          Text(
                            "1200",
                            style: TextStyle(
                                color: ColorManager.yellow,
                                fontSize: ConfigSize.defaultSize! * 1.7),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("240",
                                  style: Theme.of(context).textTheme.bodyMedium),
                               Icon(Icons.diamond_rounded,color: Colors.blue.shade900),
                            ],
                          )
                        ],
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
