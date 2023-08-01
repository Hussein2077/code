import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class CardOfDiamondEarned extends StatelessWidget {
  final String assetCard;
  const CardOfDiamondEarned({super.key,required this.assetCard});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width - 30,
      height: ConfigSize.defaultSize! * 15,
      padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize! * 2.5,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 1.8),
        gradient: const LinearGradient(
          colors: ColorManager.mainColorList
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(assetCard,scale: 3),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                StringManager.diamondsEarned,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: ConfigSize.defaultSize! * 1.8,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "235.0",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ConfigSize.defaultSize! * 1.8,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: ConfigSize.defaultSize! * 0.5),
                  const Icon(Icons.diamond,color: Colors.blue),

                ],
              ),
            ],
          ),

        ],
      ),
    );
  }
}
