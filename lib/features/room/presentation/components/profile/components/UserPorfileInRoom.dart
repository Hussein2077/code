import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/admin_or_owner_container.dart';
import 'package:tik_chat_v2/core/widgets/male_female_icon.dart';
import 'package:tik_chat_v2/core/widgets/user_country_icon.dart';
import 'package:tik_chat_v2/features/room/presentation/components/profile/widgets/contaner_vip_or_contribute.dart';
import 'package:tik_chat_v2/features/room/presentation/components/profile/widgets/gift_gallery_profile.dart';
import 'package:tik_chat_v2/features/room/presentation/components/profile/widgets/icon_with_text.dart';
import 'package:tik_chat_v2/features/room/presentation/components/profile/widgets/mention_or_report_container.dart';

class UserProfileInRoom extends StatelessWidget {
  const UserProfileInRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: ConfigSize.defaultSize! * 38.4,
          decoration: BoxDecoration(
              color: const Color(0xFFFFFCE4),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    ConfigSize.defaultSize! * 2.0,
                  ),
                  topRight: Radius.circular(
                    ConfigSize.defaultSize! * 2.0,
                  ))),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ConfigSize.defaultSize! * 1.9,
          ),
          child: SizedBox(
            height: ConfigSize.defaultSize! * 42.4,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MentionOrReportContainer(
                      text: StringManager.mention,
                      icon: AssetsPath.mention,
                      size: ConfigSize.defaultSize! * 0.3,
                    ),

                    Container(
                      height: ConfigSize.defaultSize! * 8.8,
                      width: ConfigSize.defaultSize! * 8.8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                    ),

                    MentionOrReportContainer(
                      text: StringManager.reports,
                      icon: AssetsPath.warning,
                      size: ConfigSize.defaultSize! * 0.2,
                    ),
                  ],
                ),
                SizedBox(
                  height: ConfigSize.defaultSize! * 1.5,
                ),
                Text('M7mdxl77',
                    style: TextStyle(
                        fontSize: ConfigSize.defaultSize! * 1.6,
                        color: ColorManager.darkBlack,
                        fontWeight: FontWeight.w400)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('ID:123456',
                        style: TextStyle(
                            fontSize: ConfigSize.defaultSize! * 1.2,
                            color: ColorManager.orange,
                            fontWeight: FontWeight.w400)),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(Icons.copy, size: 12,color: ColorManager.orang),
                  ],
                ),
                SizedBox(
                  height: ConfigSize.defaultSize! * 0.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    UserCountryIcon(country: 'Egypt 🏁'),
                    SizedBox(width: 5),
                    MaleFemaleIcon(
                      maleOrFeamle: 1, age: 26,
                    ),
                    SizedBox(width: 5),
                    AdminOrOwnerContainer(
                      roomOwnerId: 5,
                      userId: 5,
                    ),
                    SizedBox(width: 5),

                  ],
                ),
                const SizedBox(height: 20),
                Row(

                  children:  [
                     const Expanded(
                      child: ContainerVipOrContribute(
                        colors: ColorManager.yellowVipContanier,
                        icons: AssetsPath.vipProfileIcon,
                        level: '${StringManager.vip} 0',
                        colorText: ColorManager.yellowVipContanierText,
                        vipOrContribute: StringManager.levelOfThe,
                      )
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: ContainerVipOrContribute(
                      colors: ColorManager.lightBlueInPofile,
                      icons: AssetsPath.contribute,
                      level: "5",
                      sizeOfIcon: ConfigSize.defaultSize!*0.18,
                      colorText: ColorManager.blueContributeContanierText,
                      vipOrContribute: StringManager.contribute,
                    )
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const GiftGalleryContainer(),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:  [

                    //FOLLOW ICON
                    const IconWithText(
                      image: AssetsPath.followIcon,
                      text: StringManager.follow,
                    ),

                    //Friend REQUEST ICON
                    const IconWithText(
                      image: AssetsPath.friendRequestIconProfile,
                      text: StringManager.addFriend,
                    ),
                    //SEND GIFT ICON
                    const IconWithText(
                      image: AssetsPath.sendGiftIconProfile,
                      text: StringManager.sendGift,
                    ),

                    Image.asset(AssetsPath.chatIconProfile,scale: ConfigSize.defaultSize!*0.25,),

                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
