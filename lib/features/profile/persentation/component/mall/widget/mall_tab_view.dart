

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';

class MallTabView extends StatelessWidget {
  const MallTabView({super.key});

  @override
  Widget build(BuildContext context) {
   return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1.1),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(
                left: ConfigSize.defaultSize!,
                right: ConfigSize.defaultSize!,
                bottom: ConfigSize.defaultSize! * 1.2),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(ConfigSize.defaultSize!)),
            child: Column(
              children: [
                SizedBox(
                  height: ConfigSize.defaultSize!,
                ),
                Align(alignment: Alignment.topRight, child:     Text(
                  "هديه موت",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),),
                Image.asset(
                  AssetsPath.testImage,
                  scale: 25,
                ),
                SizedBox(
                  height: ConfigSize.defaultSize!,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [  Text(
                  "520 / 7 ايام",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Image.asset(AssetsPath.goldCoinIcon,scale: 10,)
                ],)     ,       
                  SizedBox(
                  height: ConfigSize.defaultSize!,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MainButton(
                      title: StringManager.buy,
                      onTap: () {},
                      width: ConfigSize.defaultSize! * 7,
                      height: ConfigSize.defaultSize! * 2,
                      titleSize: ConfigSize.defaultSize!*1.4,
                    ),
                      
                  ],
                )
              ],
            ),
          );
        });
  }
}