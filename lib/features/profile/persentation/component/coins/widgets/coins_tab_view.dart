import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/custom_horizental_dvider.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/coins/widgets/coins_card.dart';

class CoinsTabView extends StatelessWidget {
  final String type;

  const CoinsTabView({required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CoinCard(
          type: type,
        ),
        Text(
          StringManager.recharge.tr(),
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        CustomHorizntalDvider(
          width: ConfigSize.defaultSize! * 3,
          color: type == "gold" ? ColorManager.orang : Colors.grey,
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
                    child: type == "gold"
                        ? Column(
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
                              Text("240 L.E",
                                  style: Theme.of(context).textTheme.bodyMedium)
                            ],
                          )
                        : Column(
                            children: [
                              Image.asset(
                                AssetsPath.sliverCoinIcon,
                                scale: 5.5,
                              ),
                              Text(
                                "1200",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: ConfigSize.defaultSize! * 1.7),
                              ),
                              Text("240 L.E",
                                  style: Theme.of(context).textTheme.bodyMedium)
                            ],
                          ),
                  );
                }))
      ],
    );
  }
}
