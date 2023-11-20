// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/aristocracy_level.dart';
import 'package:tik_chat_v2/core/widgets/level_continer.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/room_vistor_model.dart';

class GiftBannerWidget extends StatelessWidget {
  RoomVistorModel sendDataUser;
  RoomVistorModel receiverDataUser;
  String giftImage;
  AnimationController controllerBanner;
  Animation<Offset> offsetAnimationBanner;
  bool isPlural;
  String roomIntro;
  GiftBannerWidget({super.key, required this.sendDataUser, required this.receiverDataUser, required this.giftImage, required this.controllerBanner, required this.offsetAnimationBanner, required this.isPlural, required this.roomIntro});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controllerBanner,
        builder: (context, child) {
          return Transform.translate(
              offset: offsetAnimationBanner.value,
              child: Container(
                width: ConfigSize.defaultSize! * 34,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetsPath.bannerRoom),
                  ),
                ),
                padding: EdgeInsets.only(
                    top: ConfigSize.defaultSize! * 3,
                    bottom: ConfigSize.defaultSize!,
                    left: ConfigSize.defaultSize! * 1.5,
                    right: ConfigSize.defaultSize! * 1.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserImage(
                        image: sendDataUser.image!,
                        imageSize: AppPadding.p26),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: ConfigSize.defaultSize! * 8,
                              child: Text(sendDataUser.name!,
                                  style: TextStyle(
                                      fontSize: AppPadding.p12,
                                      fontWeight: FontWeight.w600,
                                      foreground: Paint()
                                        ..shader = const LinearGradient(
                                          colors: <Color>[
                                            Colors.red,
                                            Colors.deepPurpleAccent,

                                            //add more color here.
                                          ],
                                        ).createShader(
                                          const Rect.fromLTWH(
                                              0.0, 0.0, 200.0, 100.0),
                                        )),
                                  overflow: TextOverflow.ellipsis),
                            ),
                            if (sendDataUser.revicerLevelImg! != '')
                              LevelContainer(
                                  image: sendDataUser.revicerLevelImg!),
                            if (sendDataUser.senderLevelImg! != '')
                              LevelContainer(
                                  image: sendDataUser.senderLevelImg!),
                            if (sendDataUser.vipLevel != null)
                              AristocracyLevel(
                                level: sendDataUser.vipLevel!,
                              )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "أرسل ألي",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: AppPadding.p12),
                            ),
                            SizedBox(
                              width: ConfigSize.defaultSize! * 10,
                              child: Text(
                                  isPlural
                                      ? "ألي الغرفة$roomIntro"
                                      : receiverDataUser.name!,
                                  style: TextStyle(
                                      fontSize: AppPadding.p12,
                                      fontWeight: FontWeight.w600,
                                      foreground: Paint()
                                        ..shader = const LinearGradient(
                                          colors: <Color>[
                                            Colors.pinkAccent,
                                            Colors.deepPurpleAccent,
                                            Colors.red
                                            //add more color here.
                                          ],
                                        ).createShader(
                                          const Rect.fromLTWH(
                                              0.0, 0.0, 200.0, 100.0),
                                        )),
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        )
                      ],
                    ),
                    UserImage(
                        image: receiverDataUser.image!,
                        imageSize: AppPadding.p26),
                  ],
                ),
              ));
        });
  }
}
