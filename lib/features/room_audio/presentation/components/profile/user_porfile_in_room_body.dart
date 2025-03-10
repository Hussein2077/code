import 'dart:convert';
import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gif/gif.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/admin_or_owner_container.dart';
import 'package:tik_chat_v2/core/widgets/aristocracy_level.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/gredin_text_vip.dart';
import 'package:tik_chat_v2/core/widgets/id_with_copy_icon.dart';
import 'package:tik_chat_v2/core/widgets/male_female_icon.dart';
import 'package:tik_chat_v2/core/widgets/user_country_icon.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/user_profile/widget/lower/user_badge_item.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/user_profile/widget/profile_bottom_bar.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/follow_manger/bloc/follow_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/follow_manger/bloc/follow_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/user_badges_manager/user_badges_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/user_badges_manager/user_badges_state.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/gifts/widgets/Gift_Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/gifts/widgets/anonymous_dialog_gifts.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/profile/widgets/contaner_vip_or_contribute.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/profile/widgets/settings_button.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_events.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/uikit_service.dart';
import 'profile_room_body_controler.dart';
import 'widgets/image_with_text.dart';

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

  static ValueNotifier<int> updatebuttomBar = ValueNotifier<int>(0);

  @override
  State<UserProfileInRoom> createState() => _UserProfileInRoomState();
}

class _UserProfileInRoomState extends State<UserProfileInRoom>
    with TickerProviderStateMixin {
  late GifController _controller;

  @override
  void initState() {
    localisFollow = widget.userData.isFollow!;
    _controller = GifController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  //  localisFollow = widget.userData.isFollow!;
  bool isOnMic = false;

  bool isAdminOrHost = false;

  bool myProfile = false;
  late bool localisFollow;

  ValueNotifier<bool> followAneimate = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    isOnMic = checkIsUserOnMic(widget.userData);
    isAdminOrHost =
        cheakisAdminOrHost(widget.userData, widget.myData, widget.roomData);
    myProfile = myProfileOrNot(widget.userData, widget.myData);

    return SizedBox(
      height: ConfigSize.screenHeight! * .51,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: ConfigSize.screenHeight! * .45,
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
            padding: EdgeInsets.only(
              top: ConfigSize.defaultSize! * 3,
              left: ConfigSize.defaultSize! * 1.9,
              right: ConfigSize.defaultSize! * 1.9,
              bottom: ConfigSize.defaultSize! * 1,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: ConfigSize.defaultSize! * 6,
                    ),
                    GradientTextVip(
                      text: widget.userData.name!,
                      typeUser: widget.userData.userType ?? 0,
                      textStyle: TextStyle(
                          fontSize: ConfigSize.defaultSize! * 1.6,
                          color: ColorManager.darkBlack,
                          fontWeight: FontWeight.w400),
                      isVip: widget.userData.hasColorName!,
                    ),
                    if (widget.userData.bio.toString() != "")
                      Text(
                        widget.userData.bio.toString(),
                        style: TextStyle(
                            fontSize: ConfigSize.defaultSize! * 1.3,
                            color: ColorManager.darkBlack.withOpacity(0.8),
                            fontWeight: FontWeight.w400),
                      ),

                    widget.userData.familyData != null
                        ? InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.familyProfile,
                            arguments: widget.roomData.roomFamily!.id);
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: ConfigSize.defaultSize! * 0.2,
                              horizontal: ConfigSize.defaultSize! * 1),
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: ColorManager.mainColorList),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${StringManager.familyName.tr()}: ",
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text(
                                widget.userData.familyData!.name!
                                    .toString(),
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          )),
                    )
                        : const SizedBox(),
                    IdWithCopyIcon(
                      userData: widget.userData,
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (!widget.userData.isCountryHiden!)
                          UserCountryIcon(
                              country: widget.userData.country?.flag ?? ""),
                        SizedBox(width: ConfigSize.defaultSize! * 0.5),
                        MaleFemaleIcon(
                          maleOrFeamle: widget.userData.profile!.gender,
                          age: widget.userData.profile!.age,
                        ),
                        SizedBox(width: ConfigSize.defaultSize! * 0.5),
                        AdminOrOwnerContainer(
                          roomOwnerId: widget.roomData.ownerId,
                          userId: widget.userData.id,
                        ),
                        SizedBox(width: ConfigSize.defaultSize! * 2),
                        if (widget.userData.vip1!.img1 != null)
                          AristocracyLevel(
                            level: widget.userData.vip1!.level!,
                          ),
                        SizedBox(width: ConfigSize.defaultSize! * 0.5),
                      ],
                    ),

                    BlocBuilder<UserBadgesBloc, UserBadgesState>(
                        builder: (context, state) {
                          if (state is UserBadgesSucssesState) {
                            return state.badges.data.isEmpty
                                ? const SizedBox()
                                : SizedBox(
                              width: ConfigSize.defaultSize! * 20,
                              child: UserBadgesItem(
                                width: ConfigSize.screenWidth! * 0.1,
                                height: ConfigSize.screenHeight! * 0.075,
                                userBadges: state.badges,
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        }),
                  ],
                ),
                SizedBox(height: ConfigSize.defaultSize!),
                Row(
                  children: [
                    Expanded(
                        child: ContainerVipOrContribute(
                      colors: ColorManager.yellowVipContanier,
                      icons: AssetsPath.vipProfileIcon,
                      level: widget.userData.level!.reciverLivel.toString(),
                      colorText: ColorManager.yellowVipContanierText,
                      vipOrContribute: StringManager.receiverLevel.tr(),
                    )),
                    SizedBox(width: ConfigSize.defaultSize!),
                    Expanded(
                        child: ContainerVipOrContribute(
                      colors: ColorManager.lightBlueInPofile,
                      icons: AssetsPath.contribute,
                      level: widget.userData.level!.senderLevel.toString(),
                      sizeOfIcon: ConfigSize.defaultSize! * 0.22,
                      colorText: ColorManager.blueContributeContanierText,
                      vipOrContribute: StringManager.senderLevel.tr(),
                    )),
                  ],
                ),
                SizedBox(height: ConfigSize.defaultSize! * 0.3),
                // GiftGalleryContainer(userId: widget.userData.id!),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (!myProfile)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              mentionAction(
                                  context: context,
                                  roomData: widget.roomData,
                                  userData: widget.userData);
                            },
                            child: mentionButton(),
                          ),
                          InkWell(
                            onTap: () {
                              privateCommentAction(
                                context: context,
                                roomData: widget.roomData,
                                userData: widget.userData,
                              );
                            },
                            child: privateCommentButton(),
                          ),
                          ValueListenableBuilder<bool>(
                              valueListenable: followAneimate,
                              builder: (context, isShow, _) {
                                if (isShow) {
                                  return SizedBox(
                                    height: ConfigSize.defaultSize! * 3.5,
                                    width: ConfigSize.defaultSize! * 3.5,
                                    child: Gif(
                                      image:
                                          const AssetImage(AssetsPath.verified),
                                      controller: _controller,
                                      autostart: Autostart.loop,
                                      placeholder: (context) =>
                                          const SizedBox(),
                                    ),
                                  );
                                } else {
                                  return localisFollow
                                      ? const SizedBox()
                                      : bottomBarColumn(
                                          context: context,
                                          icon: AssetsPath.followIcon,
                                          title: StringManager.follow.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  fontSize:
                                                      ConfigSize.defaultSize!),
                                          onTap: follow);
                                }
                              }),
                          SizedBox(
                            width: ConfigSize.defaultSize!,
                          ),
                        ],
                      ),
                    //SEND GIFT ICON
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        widget.myData.isAanonymous == false
                            ? bottomDailog(
                                context: context,
                                widget: GiftScreen(
                                  roomData: widget.roomData,
                                  userId: widget.userData.id.toString(),
                                  myDataModel: widget.myData,
                                  userImage:
                                      widget.userData.profile?.image ?? '',
                                  listAllUsers: null,
                                  isSingleUser: true,
                                ))
                            : showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AnonymounsDialogGifts();
                                });
                      },
                      child: ImageWithText(
                        image: AssetsPath.sendGiftIconProfile,
                        text: StringManager.sendGift.tr(),
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        Methods.instance.checkIfFriends(
                            userData: widget.userData, context: context);
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: ConfigSize.defaultSize! * 3,
                            vertical: ConfigSize.defaultSize! * .5,
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
                            child: Text(StringManager.talk.tr(),
                                textAlign: TextAlign.right),
                          )),
                    ),
                  ],
                ),
                SizedBox(height: ConfigSize.defaultSize!),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: InkWell(
              onTap: () {
                Methods.instance.userProfileNvgator(
                    context: context, userData: widget.userData);
              },
              child: UserImage(
                boxFit: BoxFit.cover,
                frame: widget.userData.frame,
                frameId: widget.userData.frameId,
                imageSize: ConfigSize.screenHeight! * .08,
                image: widget.userData.profile!.image!,
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize! * 1.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: ConfigSize.defaultSize! * 6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // (isAdminOrHost && isOnMic)
                          //     ? ValueListenableBuilder<int>(
                          //     valueListenable:
                          //     UserProfileInRoom.updatebuttomBar,
                          //     builder: (context, mute, _) {
                          //       return IconButton(
                          //           onPressed: () {
                          //             if (RoomScreen.usersHasMute.contains(
                          //                 widget.userData.id.toString())) {
                          //               sendMuteUserMessage(
                          //                   mute: false,
                          //                   userId:
                          //                   widget.userData.id.toString(),
                          //                   ownerId: widget.roomData.ownerId
                          //                       .toString());
                          //             } else {
                          //               if (!(widget.roomData.ownerId !=
                          //                   widget.myData.id &&
                          //                   RoomScreen.adminsInRoom.containsKey(
                          //                       widget.userData.id
                          //                           .toString()))) {
                          //                 //admin can't make mute to admin
                          //                 sendMuteUserMessage(
                          //                     mute: true,
                          //                     userId:
                          //                     widget.userData.id.toString(),
                          //                     ownerId: widget.roomData.ownerId
                          //                         .toString());
                          //               }
                          //             }
                          //           },
                          //           icon: Icon(
                          //             RoomScreen.usersHasMute.contains(widget.userData.id.toString())
                          //                 ? Icons.mic_off
                          //                 : Icons.mic_rounded,
                          //             color: Colors.black,
                          //           ));
                          //     })
                          //     : SizedBox(
                          //   height: ConfigSize.defaultSize! * 4,
                          // ),
                          //
                          // myProfile //for the blockbutto
                          //     ? SizedBox(width: ConfigSize.defaultSize! * 8)
                          //     : isAdminOrHost
                          //     ? BlockButton(
                          //   roomData: widget.roomData,
                          //   userData: widget.userData,
                          // ) : SizedBox(width: ConfigSize.defaultSize! * 8),

                          if (!myProfile)
                            InkWell(
                              onTap: () {
                                repoertsAction(
                                    context: context,
                                    userData: widget.userData);
                              },
                              child: Row(
                                children: [
                                  const Icon(Icons.report),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(StringManager.report.tr()),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),

                //column for setting and mute buttons

                Padding(
                  padding: EdgeInsets.only(top: ConfigSize.defaultSize! * 6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if(isAdminOrHost && widget.userData.id!=MyDataModel.getInstance().id)
                      SettingsButton(
                          roomData: widget.roomData,
                          userData: widget.userData,
                          layoutMode: widget.layoutMode,
                          isAdminOrHost: isAdminOrHost,
                          isOnMic: isOnMic,
                          myProfrile: myProfile),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> sendMuteUserMessage(
      {required bool mute,
      required String userId,
      required String ownerId}) async {
    if (mute) {
      ZegoUIKit.instance.turnMicrophoneOn(false, userID: userId);
      BlocProvider.of<OnRoomBloc>(context)
          .add(MuteUserMicEvent(userId: userId, ownerId: ownerId));
      RoomScreen.usersHasMute.add(userId);
      UserProfileInRoom.updatebuttomBar.value =
          UserProfileInRoom.updatebuttomBar.value + 1;
    } else {
      RoomScreen.usersHasMute.remove(userId);
      BlocProvider.of<OnRoomBloc>(context)
          .add(UnMuteUserMicEvent(userId: userId, ownerId: ownerId));
      UserProfileInRoom.updatebuttomBar.value =
          UserProfileInRoom.updatebuttomBar.value + 1;
    }
    var mapInformation = {
      "messageContent": {"message": "muteUser", 'mute': mute, 'id_user': userId}
    };
    String map = jsonEncode(mapInformation);
    ZegoUIKit.instance.sendInRoomCommand(map, []);
  }

  void Function()? follow() {
    _controller.reset();

    followAneimate.value = !followAneimate.value;

    if (!localisFollow) {
      BlocProvider.of<FollowBloc>(context)
          .add(FollowEvent(userId: widget.userData.id.toString()));
      localisFollow = !localisFollow;
    }

    Future.delayed(const Duration(milliseconds: 1800), () async {
      _controller.stop();
      followAneimate.value = !followAneimate.value;
    });
    return null;
  }

  Widget mentionButton() {
    return SizedBox(
      width: ConfigSize.defaultSize! * 6,
      child: Column(
        children: [
          Container(
            width: ConfigSize.defaultSize! * 3,
            height: ConfigSize.defaultSize! * 3,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.65),
              borderRadius: BorderRadius.all(
                  Radius.circular(ConfigSize.defaultSize! * 2.5)),
            ),
            child: Center(
              child: Text(
                '@',
                style: TextStyle(
                    color: Colors.white, fontSize: ConfigSize.defaultSize! * 2),
              ),
            ),
          ),
          Text(StringManager.mention.tr(),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.black, fontSize: ConfigSize.defaultSize!)),
        ],
      ),
    );
  }

  Widget privateCommentButton() {
    return SizedBox(
      width: ConfigSize.defaultSize! * 10,
      child: Column(
        children: [
          SizedBox(
            width: ConfigSize.defaultSize! * 6,
            height: ConfigSize.defaultSize! * 3,
            child: Center(
              child: Image.asset(AssetsPath.privateCommentGif),
            ),
          ),
          Text(
            StringManager.privateComment.tr(),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.black, fontSize: ConfigSize.defaultSize!),
          )
        ],
      ),
    );
  }
}
