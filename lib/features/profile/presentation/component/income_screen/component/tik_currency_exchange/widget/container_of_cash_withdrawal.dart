import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class ContainerWithdrawal extends StatelessWidget {
  final String diamond,coins;
  const ContainerWithdrawal({super.key,
    required this.diamond,
    required this.coins});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width,

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular( ConfigSize.defaultSize!*1.5),
          gradient:  const LinearGradient(colors: ColorManager.mainColorList
          )),
      padding: EdgeInsets.all( ConfigSize.defaultSize!*1.5),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text( StringManager.diamond,
                style:Theme.of(context).textTheme.bodyLarge,),

              SizedBox(
                height: ConfigSize.defaultSize!*2.0,
              ),
              Row(
                children: [
                  Image.asset(AssetsPath.gemStone,
                      scale: 2.0),
                  const SizedBox(
                    width: 20,
                  ),
                  Text( diamond,
                    style:Theme.of(context).textTheme.bodyMedium,),
                ],
              )
            ],
          ),
          VerticalDivider(
            width: 2,
            thickness: 3,
            indent: 15,
            endIndent: 15,
            color:
            const Color(0xffA3A4A3).withOpacity(0.72),
          ),
          Column(
            children: [
                Text(StringManager.balance,
                style:Theme.of(context).textTheme.bodyLarge,),

              SizedBox(
                height:  ConfigSize.defaultSize!*1.0,
              ),


              Row(
                children: [
                  Image.asset(AssetsPath.circleDollar,
                      scale: 2.0),
                  const SizedBox(
                    width: 10,
                  ),

                  Text(coins,
                    style:Theme.of(context).textTheme.bodyMedium,),

                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
