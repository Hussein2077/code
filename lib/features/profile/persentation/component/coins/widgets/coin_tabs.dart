

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class CoinTabs extends StatelessWidget {
  final TabController coinsController ;
  const CoinTabs({required this.coinsController , super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [

      IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back_ios , color: Theme.of(context).colorScheme.primary , size: ConfigSize.defaultSize!*2.5,)),

      Expanded(
        child: TabBar(
           controller:  coinsController,
        indicatorColor: ColorManager.orang,
        indicatorPadding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!*6),
        labelColor: Theme.of(context).colorScheme.primary,
        unselectedLabelColor: Colors.grey,
        labelStyle:TextStyle(fontSize: ConfigSize.defaultSize!*1.8 , fontWeight: FontWeight.bold) ,
        unselectedLabelStyle:TextStyle(fontSize: ConfigSize.defaultSize!*1.6) ,
          tabs:  [
              Text(StringManager.coins.tr(),),
           //   Text(StringManager.silver.tr(),)


        ]),
      ),

      TextButton(onPressed: (){
        Navigator.pushNamed(context, Routes.paymentHistory);
      },style: TextButton.styleFrom(
          foregroundColor:Colors.white
      ),
        child:  const Text('فتوره'), )
    ],);
  }
}