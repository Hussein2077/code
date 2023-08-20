import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/admin_or_owner_container.dart';
import 'package:tik_chat_v2/core/widgets/id_with_copy_icon.dart';
import 'package:tik_chat_v2/core/widgets/male_female_icon.dart';
import 'package:tik_chat_v2/core/widgets/user_country_icon.dart';
import 'package:tik_chat_v2/features/room/presentation/components/profile/widgets/contaner_vip_or_contribute.dart';
import 'package:tik_chat_v2/features/room/presentation/components/profile/widgets/gift_gallery_profile.dart';
import 'package:tik_chat_v2/features/room/presentation/components/profile/widgets/icon_with_text.dart';
import 'package:tik_chat_v2/features/room/presentation/components/profile/widgets/text_with_text.dart';
import 'package:tik_chat_v2/features/room/presentation/components/profile/widgets/mention_or_report_container.dart';

class UserProfileInRoom extends StatefulWidget {
  const UserProfileInRoom({super.key, this.selectedValue});

  final String? selectedValue;

  @override
  State<UserProfileInRoom> createState() => _UserProfileInRoomState();
}

class _UserProfileInRoomState extends State<UserProfileInRoom> {
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: ConfigSize.defaultSize! * 46.9,
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
            height: ConfigSize.defaultSize! * 51.0,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(top: ConfigSize.defaultSize! * 5.5,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MentionOrReportContainer(
                            text: StringManager.mention,
                            icon: AssetsPath.mention,
                            size: ConfigSize.defaultSize! * 0.3,
                          ),
                          SizedBox(
                            height: ConfigSize.defaultSize! * 0.5,
                          ),
                          Container(
                            width: ConfigSize.defaultSize! * 5.0,
                            height: ConfigSize.defaultSize! * 2.7,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    ConfigSize.defaultSize!),
                                color: Colors.white.withOpacity(0.2)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(

                                isExpanded: true,
                                hint: Text(
                                 'Bloc',
                                 style: TextStyle(
                                   fontSize: ConfigSize.defaultSize! * 1.5,
                                   fontWeight: FontWeight.w500,
                                   color: ColorManager.gray,
                                 ),
                                 overflow: TextOverflow.ellipsis,
                                    ),

                                items: items
                                    .map((item) => DropdownMenuItem(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: TextStyle(
                                              fontSize:
                                                  ConfigSize.defaultSize! * 1.8,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                                // value:RoomTypeButton.roomType ,
                                onChanged: (value) {
                                  setState(() {
                                    value =selectedValue;
                                  });
                                },
                                icon:  Icon(Icons.block_flipped,color: ColorManager.gray,size:  ConfigSize.defaultSize! * 1.8),

                                iconEnabledColor: Colors.white,
                                iconDisabledColor: Colors.grey,
                                buttonHeight: ConfigSize.defaultSize! * 1.8,
                                buttonWidth: ConfigSize.defaultSize! * 70,

                                buttonDecoration: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                itemHeight: ConfigSize.defaultSize! * 5,
                                itemPadding: EdgeInsets.only(
                                    left: ConfigSize.defaultSize! * 1.8,
                                    right: ConfigSize.defaultSize! * 1.8),
                                dropdownMaxHeight: ConfigSize.defaultSize! * 15,
                                dropdownWidth: ConfigSize.defaultSize! * 10,
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: ColorManager.lightGray.withOpacity(0.5),
                                ),
                                scrollbarRadius: const Radius.circular(40),
                                scrollbarThickness: 6,
                                scrollbarAlwaysShow: true,
                                offset: const Offset(-20, 0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: ConfigSize.defaultSize! * 0.5,
                          ),
                          IconWithText(
                            onTap: (){

                            },
                            icon: Icons.block_flipped,
                            text: StringManager.ban.tr(),

                          ),

                          SizedBox(
                            height: ConfigSize.defaultSize! * 0.5,
                          ),
                          const SizedBox(),
                          IconWithText(
                            onTap: (){

                            },
                            icon: Icons.admin_panel_settings_sharp,
                            text: StringManager.admin.tr(),

                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: ConfigSize.defaultSize! * 2.5
                      ),
                      height: ConfigSize.defaultSize! * 8.8,
                      width: ConfigSize.defaultSize! * 8.8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top: ConfigSize.defaultSize! * 5.5),
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MentionOrReportContainer(
                            text: StringManager.reports,
                            icon: AssetsPath.warning,
                            size: ConfigSize.defaultSize! * 0.25,
                          ),
                          SizedBox(
                            height: ConfigSize.defaultSize! * 0.5,
                          ),
                           IconWithText(
                            onTap: (){

                            },
                            icon: Icons.share_rounded,
                            text: StringManager.inviteFriend,
                          ),
                          SizedBox(
                            height: ConfigSize.defaultSize! * 0.5,
                          ),
                           IconWithText(
                             onTap: (){

                             },
                            icon: Icons.mic_none_rounded,
                            text: StringManager.muteMic,
                          ),
                        ],
                      ),
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
                const IdWithCopyIcon(
                  id: '154554',
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
                      maleOrFeamle: 1,
                      age: 26,
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
                  children: [
                    const Expanded(
                        child: ContainerVipOrContribute(
                      colors: ColorManager.yellowVipContanier,
                      icons: AssetsPath.vipProfileIcon,
                      level: '${StringManager.vip} 0',
                      colorText: ColorManager.yellowVipContanierText,
                      vipOrContribute: StringManager.levelOfThe,
                    )),
                    const SizedBox(width: 20),
                    Expanded(
                        child: ContainerVipOrContribute(
                      colors: ColorManager.lightBlueInPofile,
                      icons: AssetsPath.contribute,
                      level: "5",
                      sizeOfIcon: ConfigSize.defaultSize! * 0.18,
                      colorText: ColorManager.blueContributeContanierText,
                      vipOrContribute: StringManager.contribute,
                    )),
                  ],
                ),
                const SizedBox(height: 10),
                const GiftGalleryContainer(),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //FOLLOW ICON
                    const ImageWithText(
                      image: AssetsPath.followIcon,
                      text: StringManager.follow,
                    ),
                    //Friend REQUEST ICON
                    const ImageWithText(
                      image: AssetsPath.friendRequestIconProfile,
                      text: StringManager.addFriend,
                    ),
                    //SEND GIFT ICON
                    const ImageWithText(
                      image: AssetsPath.sendGiftIconProfile,
                      text: StringManager.sendGift,
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
