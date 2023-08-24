import 'dart:convert';
import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
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


import 'profile_room_body_controler.dart';
import 'widgets/block_button.dart';
import 'widgets/gift_user_screen.dart';
import 'widgets/image_with_text.dart';
import 'widgets/settings_Button.dart';
import '../../../../../../zego_code_v2/zego_uikit/zego_uikit.dart';

// ignore: must_be_immutable
class UserProfileInRoom extends StatefulWidget {
  final UserDataModel userData;
  final MyDataModel myData;
  final EnterRoomModel roomData;
  final LayoutMode layoutMode;

  const UserProfileInRoom(
      {required this.roomData,
      required this.myData,
      required this.userData,
      required this.layoutMode,
      super.key});

  @override
  State<UserProfileInRoom> createState() => _UserProfileInRoomState();
}

class _UserProfileInRoomState extends State<UserProfileInRoom> {
  bool isOnMic = false;

  bool isAdminOrHost = false;

  bool myProfile = false;

  @override
  Widget build(BuildContext context) {
    isOnMic = checkIsUserOnMic(widget.userData);
    isAdminOrHost =
        cheakisAdminOrHost(widget.userData, widget.myData, widget.roomData);
    myProfile = myProfileOrNot(widget.userData, widget.myData);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: ConfigSize.defaultSize! * 45.4,
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
            height: ConfigSize.defaultSize! * 50.4,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: ConfigSize.defaultSize! * 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      myProfile
                          ? SizedBox(width: ConfigSize.defaultSize! * 8)
                          : Column(
                              children: [
                                if (isAdminOrHost)
                                  BlockButton(
                                    roomData: widget.roomData,
                                    userData: widget.userData,
                                  ),
                              ],
                            ),
                      Column(
                        children: [
                          SizedBox(
                            height: ConfigSize.defaultSize! * 1.5,
                          ),
                          Text(widget.userData.name!,
                              style: TextStyle(
                                  fontSize: ConfigSize.defaultSize! * 1.6,
                                  color: ColorManager.darkBlack,
                                  fontWeight: FontWeight.w400)),
                          IdWithCopyIcon(
                            id: widget.userData.uuid!,
                          ),
                          SizedBox(
                            height: ConfigSize.defaultSize! * 0.5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              UserCountryIcon(
                                  country: widget.userData.profile!.country),
                              const SizedBox(width: 5),
                              MaleFemaleIcon(
                                maleOrFeamle: widget.userData.profile!.gender,
                                age: widget.userData.profile!.age,
                              ),
                              const SizedBox(width: 5),
                              AdminOrOwnerContainer(
                                roomOwnerId: widget.roomData.ownerId,
                                userId: widget.userData.id,
                              ),
                              const SizedBox(width: 5),
                            ],
                          ),
                          SizedBox(height: ConfigSize.defaultSize! * 2),
                        ],
                      ),
                      Column(
                        children: [
                          SettingsButton(
                              roomData: widget.roomData,
                              userData: widget.userData,
                              layoutMode: widget.layoutMode,
                              isAdminOrHost: isAdminOrHost,
                              isOnMic: isOnMic,
                              myProfrile: myProfile),
                          if (isAdminOrHost && isOnMic)
                            ValueListenableBuilder<int>(
                                valueListenable: RoomScreen.updatebuttomBar,
                                builder: (context, mute, _) {
                                  return IconButton(
                                      onPressed: () {
                                        if (RoomScreen.usersHasMute.contains(
                                            widget.userData.id.toString())) {
                                          sendMuteUserMessage(
                                              mute: false,
                                              userId: widget.userData.id
                                                  .toString());
                                        } else {
                                          if (!(widget.roomData.ownerId !=
                                                  widget.myData.id &&
                                              RoomScreen.adminsInRoom
                                                  .containsKey(widget
                                                      .userData.id
                                                      .toString()))) {
                                            //admin can't make mute to admin
                                            sendMuteUserMessage(
                                                mute: true,
                                                userId: widget.userData.id
                                                    .toString());
                                          }
                                        }
                                      },
                                      icon: Icon(
                                        RoomScreen.usersHasMute.contains(
                                                widget.userData.id.toString())
                                            ? Icons.mic_off
                                            : Icons.mic_rounded,
                                        color: Colors.black,
                                      ));
                                })
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Expanded(
                        child: ContainerVipOrContribute(
                      colors: ColorManager.yellowVipContanier,
                      icons: AssetsPath.vipProfileIcon,
                      level:
                          '${StringManager.vip} ${widget.userData.vip1!.level}',
                      colorText: ColorManager.yellowVipContanierText,
                      vipOrContribute: StringManager.levelOfThe,
                    )),
                    const SizedBox(width: 20),
                    Expanded(
                        child: ContainerVipOrContribute(
                      colors: ColorManager.lightBlueInPofile,
                      icons: AssetsPath.contribute,
                      level: widget.userData.level!.senderLevel.toString(),
                      sizeOfIcon: ConfigSize.defaultSize! * 0.18,
                      colorText: ColorManager.blueContributeContanierText,
                      vipOrContribute: StringManager.contribute,
                    )),
                  ],
                ),
                SizedBox(height: ConfigSize.defaultSize!),
                GiftGalleryContainer(userId: widget.userData.id!),
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
                              roomData: widget.roomData,
                              userId: widget.userData.id.toString(),
                              myDataModel: widget.myData,
                            ));
                      },
                      child: const ImageWithText(
                        image: AssetsPath.sendGiftIconProfile,
                        text: StringManager.sendGift,
                      ),
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
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: ConfigSize.defaultSize! * 4.5,
            ),
            child: InkWell(
              onTap: () {
                myProfile?
                 Navigator.pushNamed(context, Routes.userProfile,
                    ):
                Navigator.pushNamed(context, Routes.userProfile,
                    arguments:UserProfilePreamiter(widget.userData, null));
              },
              child: UserImage(
                imageSize: ConfigSize.defaultSize! * 7.5,
                image: widget.userData.profile!.image!,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> sendMuteUserMessage(
      {required bool mute, required String userId}) async {
    if (mute) {
      ZegoUIKit().turnMicrophoneOn(false, userID: userId);
      RoomScreen.usersHasMute.add(userId);
      RoomScreen.updatebuttomBar.value = RoomScreen.updatebuttomBar.value + 1;
    } else {
      RoomScreen.usersHasMute.remove(userId);
      RoomScreen.updatebuttomBar.value = RoomScreen.updatebuttomBar.value + 1;
    }

    var mapInformation = {
      "messageContent": {"message": "muteUser", 'mute': mute, 'id_user': userId}
    };
    String map = jsonEncode(mapInformation);
    ZegoUIKit().sendInRoomCommand(map, []);
  }
}
