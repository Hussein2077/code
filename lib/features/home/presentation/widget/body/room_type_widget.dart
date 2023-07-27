

import 'package:animated_icon/animated_icon.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class RoomTypeWidget extends StatelessWidget {
  final int style ; 
  const RoomTypeWidget({required this.style, super.key});

  @override
  Widget build(BuildContext context) {
    return     Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(ConfigSize.defaultSize! * 2),
                        color:style==0 ?  ColorManager.hanPurple:style==1?ColorManager.orangeRed :ColorManager.darkPink 
                      ),
                      child: Row(
                        children: [
                          AnimateIcon(
                              key: UniqueKey(),
                              height: ConfigSize.defaultSize! * 1.5,
                              width: ConfigSize.defaultSize! * 4,
                              onTap: () {},
                              iconType: IconType.continueAnimation,
                              // height: AppPadding.p12,
                              // width: AppPadding.p12,
                              color: ColorManager.whiteColor,
                              animateIcon: AnimateIcons.loading3),
                          Text(
                            "نعنشه",
                            style: TextStyle(
                                color: ColorManager.whiteColor,
                                fontSize: ConfigSize.defaultSize! * 1.2),
                          ),
                        ],
                      ),
                    );
  }
}