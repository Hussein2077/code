

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/core/widgets/cached_network_image.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';

import '../../../../../../core/widgets/pop_up_dialog.dart';

class MallCard extends StatelessWidget {
  final String name ; 
  final String price ; 
  final String time ; 
  final String id ; 
  final String image ; 
  const MallCard({required this.image ,  required this.id ,  required this.name , required this.price , required this.time, super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
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
                Align(
                  alignment: Alignment.center, child:     Text(
                 name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),),
                   SizedBox(
                  height: ConfigSize.defaultSize!,
                ),
               CustoumCachedImage(height: ConfigSize.defaultSize!*7, width: ConfigSize.defaultSize!*7, url:image ,
               radius: ConfigSize.defaultSize!,
               ),
                SizedBox(
                  height: ConfigSize.defaultSize!,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [  Text(
                  "$price / $time ${StringManager.day} ",
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
                      onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return
                        PopUpDialog(accpetText: (){},  headerText:StringManager.youWillBuy,widget:SizedBox(),);
                            });
                      },
                      width: ConfigSize.defaultSize! * 7,
                      height: ConfigSize.defaultSize! * 2,
                      titleSize: ConfigSize.defaultSize!*1.4,
                    ),
                      
                  ],
                )
              ],
            ),
          );
  }
}