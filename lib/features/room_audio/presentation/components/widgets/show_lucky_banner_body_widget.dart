// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/aristocracy_level.dart';
import 'package:tik_chat_v2/core/widgets/cilcular_asset_image.dart';
import 'package:tik_chat_v2/core/widgets/level_continer.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';

class ShowLuckyBannerBodyWidget extends StatelessWidget {
  UserDataModel sendDataUser;
  String ownerId;
  String coins;
  ShowLuckyBannerBodyWidget({super.key, required this.sendDataUser, required this.ownerId, required this.coins});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ConfigSize.defaultSize! * 28.9,
      height: ConfigSize.defaultSize! * 5.8,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: ColorManager.mainColorList),
        borderRadius: BorderRadius.circular(AppPadding.p22),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UserImage(
            image: ConstentApi().getImage(sendDataUser.profile!.image),
            imageSize: AppPadding.p30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(sendDataUser.name!,
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
                              const Rect.fromLTWH(0.0, 0.0, 200.0, 100.0),
                            )),
                      overflow: TextOverflow.ellipsis),
                  if (sendDataUser.level!.receiverImage! != '')
                    LevelContainer(
                      image: ConstentApi()
                          .getImage(sendDataUser.level!.receiverImage!),
                    ),
                  if (sendDataUser.level!.senderImage! != '')
                    LevelContainer(
                      image: ConstentApi()
                          .getImage(sendDataUser.level!.senderImage!),
                    ),
                  if (sendDataUser.vip1 != null)
                    AristocracyLevel(
                      level: sendDataUser.vip1!.level!,
                    )
                ],
              ),
              Row(
                children: [
                  const Text(
                    "أرسل صندوق مميز :",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                  SizedBox(
                    width: ConfigSize.defaultSize! * 5.8,
                    child: Text(coins,
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
                                const Rect.fromLTWH(0.0, 0.0, 200.0, 100.0),
                              )),
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              )
            ],
          ),
          CilcularAssetImage(image: AssetsPath.luckybox2, size: AppPadding.p36)
        ],
      ),
    );
  }
}
