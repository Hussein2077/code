import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class CountryIcon extends StatelessWidget {
  final String? name;
  final String? flag;
  final Color?color ;
  const CountryIcon({this.color ,  this.flag, this.name, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: ConfigSize.defaultSize! * 2),
      width: ConfigSize.defaultSize! * 15,
      padding: EdgeInsets.all(ConfigSize.defaultSize!),
      decoration: BoxDecoration(
        color: color,
          gradient:color==null? const LinearGradient(colors: ColorManager.mainColorList):null,
          borderRadius: BorderRadius.circular(
            ConfigSize.defaultSize! * 2,
          )),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            flag == null
                ? Image.asset(
                    AssetsPath.globalIcon,
                    scale: 2,
                  )
                : flag == AssetsPath.fireIcon
                    ? Image.asset(
                        AssetsPath.fireIcon,
                        scale: 2.5,
                      )
                    : CachedNetworkImage(
                        imageUrl: ConstentApi().getImage(flag),
                        width: ConfigSize.defaultSize! * 2.4,
                        height: ConfigSize.defaultSize! * 2.4,
                      ),
            Text(
              name ?? StringManager.countries.tr(),
              style: TextStyle(
                  color: ColorManager.whiteColor,
                  fontSize: ConfigSize.defaultSize! * 1.6),
            ),
            // const Icon(Icons.keyboard_arrow_down , color: Colors.white,),
          ],
        ),
      ),
    );
  }
}
