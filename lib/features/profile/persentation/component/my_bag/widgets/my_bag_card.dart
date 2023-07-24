

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/core/widgets/cached_network_image.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';

class MyBagCard extends StatelessWidget {
   final String name;
  final String time;
  final String id;
  final String image;
  const MyBagCard({required this.id , required this.image , required this.name , required this.time, super.key});

  @override
  Widget build(BuildContext context) {
    return   Container(
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
                  CustoumCachedImage(
            height: ConfigSize.defaultSize! * 7,
            width: ConfigSize.defaultSize! * 7,
            url: image,
            radius: ConfigSize.defaultSize!,
          ),
                Text(
                  name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  "$time/${StringManager.day}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MainButton(
                      title: StringManager.use,
                      onTap: () {},
                      width: ConfigSize.defaultSize! * 7,
                      height: ConfigSize.defaultSize! * 2,
                      titleSize: ConfigSize.defaultSize!*1.4,
                    ),
                        MainButton(
                          buttonColor: ColorManager.bageGriedinet,
                          
                      title: StringManager.send,
                      onTap: () {},
                      width: ConfigSize.defaultSize! * 7,
                      height: ConfigSize.defaultSize! * 2,
                      titleSize: ConfigSize.defaultSize!*1.4,
                    )
                  ],
                )
              ],
            ),
          );
  }
}