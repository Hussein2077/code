import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';

class CoinCard extends StatelessWidget {
  final String card;
  const CoinCard({required this.card, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      height: ConfigSize.defaultSize! * 15,
      padding: EdgeInsets.only(right: ConfigSize.defaultSize! * 2),
      decoration:
          BoxDecoration(image: DecorationImage(image: AssetImage(card))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            StringManager.balance,
            style: TextStyle(
                color: Colors.white,
                fontSize: ConfigSize.defaultSize! * 1.8,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "9990.0",
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
