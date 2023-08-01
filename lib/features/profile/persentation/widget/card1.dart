import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class Card1 extends StatelessWidget {
  final OwnerDataModel myData ; 
  final bool isDarkTheme ; 
  const Card1({required this.myData , required this.isDarkTheme ,  super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width - 30,
        height: ConfigSize.defaultSize! * 10,
        decoration: BoxDecoration(
            color: isDarkTheme? Colors.grey.withOpacity(0.3):Colors.white,
            borderRadius: BorderRadius.circular(ConfigSize.defaultSize!)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            card1Coulumn(
                context: context,
                image: AssetsPath.bagProfileIcon,
                title: StringManager.bag.tr(),
                onTap: () => Navigator.pushNamed(context, Routes.myBag , arguments:myData ),),
            card1Coulumn(
                context: context,
                image: AssetsPath.mallprofileIcon,
                title: StringManager.mall.tr(),
                onTap: () => Navigator.pushNamed(context, Routes.mall),),
            card1Coulumn(
                context: context,
                image: AssetsPath.levelProfileIcon,
                title: StringManager.level.tr() ,
                onTap: () => Navigator.pushNamed(context, Routes.level),),
            card1Coulumn(
                context: context,
                image: AssetsPath.vipProfileIcon.tr(),
                title: StringManager.vip
                ,onTap: () => Navigator.pushNamed(context, Routes.vip),
                ),
          ],
        ));
  }
}

Widget card1Coulumn(
    {required BuildContext context,
    required String image,
    required String title , void Function()? onTap}) {
  return InkWell(
    onTap:onTap ,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image , scale: 2.5,),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        )
      ],
    ),
  );
}
