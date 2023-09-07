import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

import 'package:tik_chat_v2/core/widgets/cached_network_image.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/profile/data/model/fanily_rank_model.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manger_show_family/bloc/show_family_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manger_show_family/bloc/show_family_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manger_show_family/bloc/show_family_state.dart';

class TopThreeWidget extends StatelessWidget {
  final List<FamilyRanking> topRanking;

  const TopThreeWidget({required this.topRanking, super.key});

  @override
  Widget build(BuildContext context) {
    return  Stack(
        children: [

          Padding(
              padding: EdgeInsets.only(
                  top: ConfigSize.defaultSize! * 10,
                  left: ConfigSize.defaultSize! * 2.5),
              child: Image.asset(
                AssetsPath.familyPositionCover,
                scale: 3.3,
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: (){
                  if(topRanking[1].id !=0){
                  Navigator.pushNamed(context, Routes.familyProfile,arguments:topRanking[1].id );

                  }
                },
                child: rankColumn(
                    familyName: topRanking[1].name!,
                    familyRank: topRanking[1].rank.toString(),
                    image: topRanking[1].img!,
                    kingImage: AssetsPath.crownSilver),
              ),
              InkWell(
                onTap: () {
                    if(topRanking[0].id !=0){
             Navigator.pushNamed(context, Routes.familyProfile,arguments:topRanking[0].id);

                    }


                },
                child: rankColumn(
                    familyName: topRanking[0].name!,
                    familyRank: topRanking[0].rank.toString(),
                    image: topRanking[0].img!,
                    kingImage: AssetsPath.crownGold),
              ),
              InkWell(
                onTap: (){
                                      if(topRanking[2].id !=0){
                                                          Navigator.pushNamed(context, Routes.familyProfile,arguments:topRanking[2].id );

                                      }
                },
                child: rankColumn(
                    familyName: topRanking[2].name!,
                    familyRank: topRanking[2].rank.toString(),
                    image: topRanking[2].img!,
                    kingImage: AssetsPath.crownBronze),
              )
            ],
          ),
        ],
      );
  }
}

Widget rankColumn({required String image,
  required String kingImage,
  required String familyName,
  required String familyRank}) {
  return Padding(
    padding: kingImage == AssetsPath.crownGold
        ? EdgeInsets.only(bottom: ConfigSize.defaultSize! * 2)
        : EdgeInsets.only(top: ConfigSize.defaultSize! * 2),
    child: Column(
      children: [
        Stack(
          children: [
            SizedBox(
              width: ConfigSize.defaultSize! * 8,
              height: ConfigSize.defaultSize! * 8,
            ),
            Container(
              margin: EdgeInsets.only(top: ConfigSize.defaultSize! * 2),
              width: ConfigSize.defaultSize! * 7,
              height: ConfigSize.defaultSize! * 7,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(ConfigSize.defaultSize!),
              ),
              child: image != ""
                  ? CustoumCachedImage(
                  url: image,
                  height: ConfigSize.defaultSize! * 7,
                  width: ConfigSize.defaultSize! * 7)
                  : Image.asset(AssetsPath.iconApp),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: ConfigSize.defaultSize! * 2,
              ),
              child: Image.asset(
                kingImage,
                scale: 2.5,
              ),
            ),
          ],
        ),
        SizedBox(
          height: ConfigSize.defaultSize! * 3,
        ),
        Text(
          familyName,
          style: TextStyle(
              color: Colors.white, fontSize: ConfigSize.defaultSize! * 1.7),
        ),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ConfigSize.defaultSize!),
                color: Colors.white.withOpacity(0.5)),
            child: Row(
              children: [
                Text(
                  familyRank,
                  style: TextStyle(
                      color: ColorManager.deepBlue,
                      fontSize: ConfigSize.defaultSize! * 1.3),
                ),
                Image.asset(
                  AssetsPath.goldCoinIcon,
                  scale: 15,
                )
              ],
            ))
      ],
    ),
  );
}
