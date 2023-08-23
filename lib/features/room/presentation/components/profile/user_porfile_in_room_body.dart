import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/admin_or_owner_container.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/id_with_copy_icon.dart';
import 'package:tik_chat_v2/core/widgets/male_female_icon.dart';
import 'package:tik_chat_v2/core/widgets/user_country_icon.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/room/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room/presentation/components/profile/widgets/contaner_vip_or_contribute.dart';
import 'package:tik_chat_v2/features/room/presentation/components/profile/widgets/gift_gallery_profile.dart';
import 'package:tik_chat_v2/features/room/presentation/components/profile/widgets/icon_with_text.dart';
import 'package:tik_chat_v2/features/room/presentation/components/profile/widgets/mention_or_report_container.dart';

import 'profile_room_body_controler.dart';
import 'widgets/gift_user_screen.dart';

// ignore: must_be_immutable
class UserProfileInRoom extends StatelessWidget {
  final UserDataModel userData;
  final MyDataModel myData;
  final EnterRoomModel roomData;
  final LayoutMode layoutMode;

  bool isOnMic = false;
  bool isAdminOrHost = false;
  bool myProfile = false;

  UserProfileInRoom(
      {required this.roomData,
      required this.myData,
      required this.userData,
      required this.layoutMode,
      super.key});

  @override
  Widget build(BuildContext context) {
    isOnMic = checkIsUserOnMic(userData);
    isAdminOrHost = cheakisAdminOrHost(userData, myData, roomData);
    myProfile = myProfileOrNot(userData, myData);
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
                    if (!myProfile)
                      MentionOrReportContainer(
                        text: StringManager.mention,
                        icon: AssetsPath.mention,
                        size: ConfigSize.defaultSize! * 0.3,
                      ),
                    UserImage(
                      image: userData.profile!.image!,
                    ),
                    MentionOrReportContainer(
                      text: StringManager.reports,
                      icon: AssetsPath.warning,
                      size: ConfigSize.defaultSize! * 0.25,
                    ),
                  ],
                ),
                SizedBox(
                  height: ConfigSize.defaultSize! * 1.5,
                ),
                Text(userData.name!,
                    style: TextStyle(
                        fontSize: ConfigSize.defaultSize! * 1.6,
                        color: ColorManager.darkBlack,
                        fontWeight: FontWeight.w400)),
                IdWithCopyIcon(
                  id: userData.uuid!,
                ),
                SizedBox(
                  height: ConfigSize.defaultSize! * 0.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserCountryIcon(country: userData.profile!.country),
                    const SizedBox(width: 5),
                    MaleFemaleIcon(
                      maleOrFeamle: userData.profile!.gender,
                      age: userData.profile!.age,
                    ),
                    const SizedBox(width: 5),
                    AdminOrOwnerContainer(
                      roomOwnerId: roomData.ownerId,
                      userId: userData.id,
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
                SizedBox(height: ConfigSize.defaultSize! * 2),
                Row(
                  children: [
                    Expanded(
                        child: ContainerVipOrContribute(
                      colors: ColorManager.yellowVipContanier,
                      icons: AssetsPath.vipProfileIcon,
                      level: '${StringManager.vip} ${userData.vip1!.level}',
                      colorText: ColorManager.yellowVipContanierText,
                      vipOrContribute: StringManager.levelOfThe,
                    )),
                    const SizedBox(width: 20),
                    Expanded(
                        child: ContainerVipOrContribute(
                      colors: ColorManager.lightBlueInPofile,
                      icons: AssetsPath.contribute,
                      level: userData.level!.senderLevel,
                      sizeOfIcon: ConfigSize.defaultSize! * 0.18,
                      colorText: ColorManager.blueContributeContanierText,
                      vipOrContribute: StringManager.contribute,
                    )),
                  ],
                ),
                SizedBox(height: ConfigSize.defaultSize!),
                GiftGalleryContainer(userId: userData.id!),
                SizedBox(height: ConfigSize.defaultSize! + 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //FOLLOW ICON
                    //todo i did comment here
                    //  IconWithText(
                    // onTap: (){},
                    //   icon: AssetsPath.followIcon,
                    //   text: StringManager.follow,
                    // ),
                    // //Friend REQUEST ICON
                    // const IconWithText(
                    //   image: AssetsPath.friendRequestIconProfile,
                    //   text: StringManager.addFriend,
                    // ),
                    //SEND GIFT ICON
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          bottomDailog(
                              context: context,
                              widget: GiftUserScreen(
                                roomData: roomData,
                                userId: userData.id.toString(),
                                myDataModel: myData,
                              ));
                        },
                        child: SizedBox()
                        //todo i did comment here
                        /*
                       IconWithText(
                        onTap:(){} ,
                        icon: AssetsPath.sendGiftIconProfile,
                        text: StringManager.sendGift,
                                         ),

                        */
                        ),

                    Container(
                        // alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(
                          horizontal: ConfigSize.defaultSize! * 4.2,
                          vertical: ConfigSize.defaultSize! * 1.5,
                        ),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image: AssetImage(
                                  AssetsPath.chatIconProfile,
                                ))),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: ConfigSize.defaultSize! * 2.5,
                          ),
                          child: const Text(StringManager.talk,
                              textAlign: TextAlign.right),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
