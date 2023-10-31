import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/aristocracy_level.dart';
import 'package:tik_chat_v2/core/widgets/gredin_text_vip.dart';
import 'package:tik_chat_v2/core/widgets/level_continer.dart';
import 'package:tik_chat_v2/core/widgets/male_female_icon.dart';
import 'package:tik_chat_v2/core/widgets/shimmer_id.dart';
import 'user_country_icon.dart';
import 'user_image.dart';

class UserInfoRow extends StatelessWidget {
  final UserDataModel userData;

  final double? imageSize;

  final Widget? underName;

  final Widget? endIcon;

  final double? underNameWidth;
  final Widget? idOrNot;

  final void Function()? onTap;

  const UserInfoRow(
      {this.underNameWidth,
      this.onTap,
      required this.userData,
      this.endIcon,
      this.underName,
      this.imageSize,
      this.idOrNot,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ??
          () {
            Methods.instance.userProfileNvgator(
                context: context, userId: userData.id.toString());
          },
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize! * 1.5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 1,
            ),
            UserImage(
              frame: userData.frame,
              frameId: userData.frameId,
              imageSize: imageSize,
              boxFit: BoxFit.cover,
              image: userData.profile!.image!,
            ),
            SizedBox(
              width: ConfigSize.defaultSize! * 0.5,
            ),
            const Spacer(
              flex: 4,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GradientTextVip(
                  text: userData.name ?? "",
                  textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: ConfigSize.defaultSize! * 1.6,
                      ),
                  isVip: userData.hasColorName!,
                ),
                SizedBox(
                  width: underNameWidth ?? ConfigSize.screenWidth! - 150,
                  child: underName ??
                      Row(
                        children: [
                          MaleFemaleIcon(
                            maleOrFeamle: userData.profile!.gender,
                            age: userData.profile!.age,
                          ),
                          SizedBox(width: ConfigSize.defaultSize! * 0.4),
                          if (!userData.isCountryHiden!)
                            UserCountryIcon(country: userData.profile!.country),
                          LevelContainer(
                            image: userData.level!.receiverImage!,
                          ),
                          AristocracyLevel(
                            level: userData.vip1!.level!,
                          ),
                          SizedBox(
                            width: ConfigSize.defaultSize!*.5,
                          ),
                          idOrNot!=null ?
                          idOrNot!:
                              userData.isGold?
                          ShimmerId(id: userData.uuid.toString(),style: Theme.of(context).textTheme.titleSmall,)
                              :
                              Text(
                                "ID ${userData.uuid.toString()}",
                                style: Theme.of(context).textTheme.titleSmall,
                              )
                        ],
                      ),
                )
              ],
            ),
            const Spacer(
              flex: 20,
            ),
            endIcon ??
                Image.asset(
                  AssetsPath.chatWithUserIcon,
                  scale: 2.5,
                ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
