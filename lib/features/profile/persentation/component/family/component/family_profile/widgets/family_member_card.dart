import 'package:flutter/material.dart';

import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/custom_horizental_dvider.dart';

class FamilyMemberCard extends StatelessWidget {
  const FamilyMemberCard({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
                margin:
                    EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
                width: ConfigSize.defaultSize! * 10,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius:
                        BorderRadius.circular(ConfigSize.defaultSize!)),
                child: Column(children: [
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: ConfigSize.defaultSize!,
                            top: ConfigSize.defaultSize! * 1.5),
                        child: UserImage(
                          imageSize: ConfigSize.defaultSize! * 4,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: ConfigSize.defaultSize! * 4,
                            left: ConfigSize.defaultSize! * 4),
                        child: Image.asset(
                          AssetsPath.ownerIcon,
                          scale: 2.3,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ConfigSize.defaultSize,
                  ),
                  Text(
                    "الحمود",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  CustomHorizntalDvider(
                    width: ConfigSize.defaultSize! * 7,
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  ),
                  Text(
                    StringManager.owner,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ]),
              );
  }
}