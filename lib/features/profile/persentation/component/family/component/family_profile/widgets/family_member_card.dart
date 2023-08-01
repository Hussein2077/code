import 'package:flutter/material.dart';

import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/custom_horizental_dvider.dart';

class FamilyMemberCard extends StatelessWidget {
  final String id ; 
  final String name ; 
  final String type ; 
  final String image ; 
  const FamilyMemberCard({required this.id ,  required this.image , required this.name , required this.type ,  super.key});

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
                          image: image,
                          imageSize: ConfigSize.defaultSize! * 4.5,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: ConfigSize.defaultSize! * 4,
                            left: ConfigSize.defaultSize! * 4),
                        child:type==StringManager.owner? Image.asset(
                          AssetsPath.ownerIcon,
                          scale: 2.3,
                        ):type==StringManager.admin?Image.asset(
                          AssetsPath.adminIcon,
                          scale: 2.3,
                        ):const SizedBox(),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ConfigSize.defaultSize,
                  ),
                  SizedBox(
                    width: ConfigSize.defaultSize!*14,
                    child: Center(
                      child: Text(
                        name,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                  CustomHorizntalDvider(
                    width: ConfigSize.defaultSize! * 7,
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  ),
                  Text(
                    type,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ]),
              );
  }
}