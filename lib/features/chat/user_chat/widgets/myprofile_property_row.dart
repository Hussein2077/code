import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';

import '../../../../core/utils/config_size.dart';


class MyProfilPropertyRow extends StatelessWidget {
  final String iconPath;
  final String title;
  final String? descriptiontitle;
  final Function() onTap;
  final bool? showIcon;

   MyProfilPropertyRow(
      {super.key,
      required this.iconPath,
      required this.title,
      required this.onTap,
      this.showIcon,
      this.descriptiontitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: ConfigSize.defaultSize! * 5,
          width: ConfigSize.defaultSize! * 40,
          margin: EdgeInsets.symmetric(vertical: ConfigSize.defaultSize! * 0.8),
          padding:
              EdgeInsets.symmetric(horizontal: ConfigSize.screenWidth! * 0.02),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 2),
            // image: const DecorationImage(
            //     image: AssetImage(AssetsPath.backGroundRow),
            //     fit: BoxFit.fitWidth),
          ),
          child: InkWell(
            onTap: onTap,

            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(iconPath,color:iconPath==AssetsPath.groupChat?ColorManager.yellow:null ,),
                  const Spacer(
                    flex: 1,
                  ),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: ConfigSize.defaultSize!*1.5
                    ),
                  ),
                if(descriptiontitle!=null)
                  Row(
                    children: [
                      SizedBox(width:ConfigSize.defaultSize!*1 ,),
                      Text(
                 descriptiontitle!,
                        style:  TextStyle(fontSize: ConfigSize.defaultSize!*1.2,color: ColorManager.orangeRed),
                      ),
                    ],
                  ),
                   Spacer(

                    flex: (descriptiontitle!=null)?2:10,
                  ),
                  SizedBox(
                    width: ConfigSize.defaultSize! * 3,
                    height: ConfigSize.defaultSize! * 3,
                    child: showIcon == null
                        ? const Icon(Icons.arrow_forward_ios)
                        : null,
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                ],
              ),
            ),
          ),
        ),
        //SizedBox(height: ConfigSize.screenHeight!*0.0117,)
      ],
    );
  }
}
