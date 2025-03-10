import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/aristocracy_level.dart';
import 'package:tik_chat_v2/core/widgets/level_continer.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/custom_horizental_dvider.dart';
import 'package:tik_chat_v2/features/home/data/model/user_top_model.dart';

class OthersUsers extends StatelessWidget {
  final List<UserTopModel> usersData;

  final String type;

  const OthersUsers({required this.usersData, required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    Brightness currentBrightness = Theme.of(context).brightness;
    bool isDarkTheme = currentBrightness == Brightness.dark;
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: usersData.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Methods.instance.userProfileNvgator(
                  context: context, userId: usersData[index].userId.toString());
            },
            child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: ConfigSize.defaultSize!,
                ),
                height: ConfigSize.defaultSize! * 10,
                decoration: BoxDecoration(
                    color: isDarkTheme ? Colors.black : ColorManager.whiteColor,
                    borderRadius: index == 0
                        ? BorderRadius.only(
                            topLeft:
                                Radius.circular(ConfigSize.defaultSize! * 2),
                            topRight:
                                Radius.circular(ConfigSize.defaultSize! * 2))
                        : null),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(children: [
                      const Spacer(
                        flex: 1,
                      ),
                      Text(
                        "${index + 4}",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      UserImage(
                        frame: usersData[index].frame,
                        frameId: usersData[index].frameId,
                        image: usersData[index].avater!,
                        imageSize: ConfigSize.defaultSize! * 4,
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Column(
                        children: [
                          Text(
                            usersData[index].name!,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Row(
                            children: [
                              type == 'sender'
                                  ? Center(
                                      child: SizedBox(
                                          width: ConfigSize.defaultSize! * 4,
                                          height: ConfigSize.defaultSize! * 2,
                                          child: LevelContainer(
                                              image:
                                                  usersData[index].senderImage!)),
                                    )
                                  : Center(
                                      child: SizedBox(
                                          width: ConfigSize.defaultSize! * 4,
                                          height: ConfigSize.defaultSize! * 2,
                                          child: LevelContainer(
                                              image:
                                                  usersData[index].receverImage!)),
                                    ),
                              AristocracyLevel(
                                level: usersData[index].vipLevel!,
                              ),
                            ],
                          )
                        ],
                      ),
                      const Spacer(
                        flex: 20,
                      ),
                      Text(
                        usersData[index].exp.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                    ]),
                    CustomHorizntalDvider(
                      width: MediaQuery.of(context).size.width - 100,
                      color: Colors.black.withOpacity(0.1),
                    )
                  ],
                )),
          );
        });
  }
}
