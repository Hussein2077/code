import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/aristocracy_level.dart';
import 'package:tik_chat_v2/core/widgets/level_continer.dart';
import 'package:tik_chat_v2/core/widgets/male_female_icon.dart';
import 'user_country_icon.dart';
import 'user_image.dart';


class UserInfoRow extends StatelessWidget {
  final UserDataModel userData ;

  final double? imageSize;

  final Widget? underName;

  final Widget? endIcon;

  final double? underNameWidth;

  final void Function()? onTap;

  const UserInfoRow(
      {this.underNameWidth,
        this.onTap,
        required this.userData,
        this.endIcon,
        this.underName,
        this.imageSize,
        super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ??
              () {
            Navigator.pushNamed(context, Routes.userProfile,
                arguments: userData.id.toString());
          },
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize! * 1.5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 1,
            ),
            UserImage(
              imageSize: imageSize,
              boxFit: BoxFit.cover,
              image: userData.profile!.image!,
            ),
            SizedBox(
              width:  ConfigSize.defaultSize! * 0.5,
            ),
            const Spacer(
              flex: 4,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  userData.name ?? "",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(
                  width:
                  underNameWidth ?? MediaQuery.of(context).size.width - 140,
                  child: underName ??
                      Row(

                        children: [
                          MaleFemaleIcon(
                            maleOrFeamle: userData.profile!.gender, age: userData.profile!.gender,
                          ),
                          UserCountryIcon(country: userData.profile!.country),
                          LevelContainer(
                            image: userData.level!.senderImage!,
                          ),
                          AristocracyLevel(
                            level: 2,
                          ),
                          const Spacer(),
                          Text(
                            "ID ${userData.uuid.toString()}",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
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