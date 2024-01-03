import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class CoinCard extends StatelessWidget {
  final String type;
  CoinCard({required this.type, super.key});

  int coins = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      height: ConfigSize.defaultSize! * 15,
      padding: EdgeInsets.only(right: ConfigSize.defaultSize! * 2),
      decoration:
      BoxDecoration(image: DecorationImage(image: AssetImage(type == "gold"
          ? AssetsPath.goldCoinCard
          : AssetsPath.silverCoinCard))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            StringManager.balance.tr(),
            style: TextStyle(
                color: Colors.white,
                fontSize: ConfigSize.defaultSize! * 1.8,
                fontWeight: FontWeight.bold),
          ),
          Text(
            type == "gold" ? coins > 0? coins.toString() : '${MyDataModel.getInstance().myStore?.coins}': '${MyDataModel.getInstance().myStore?.silverCoin}',
            style: TextStyle(
                color: Colors.white,
                fontSize: ConfigSize.defaultSize! * 1.8,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
