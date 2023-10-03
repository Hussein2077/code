import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;

import 'package:awesome_ripple_animation/awesome_ripple_animation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:draggable_float_widget/draggable_float_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/model/room_user_messages_model.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/widgets/aristocracy_level.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/cilcular_asset_image.dart';
import 'package:tik_chat_v2/core/widgets/gredin_text_vip.dart';
import 'package:tik_chat_v2/core/widgets/level_continer.dart';
import 'package:tik_chat_v2/core/widgets/show_svga.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/profile/data/data_sorce/remotly_data_source_profile.dart';
import 'package:tik_chat_v2/features/room/data/data_sorce/remotly_data_source_room.dart';
import 'package:tik_chat_v2/features/room/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room/presentation/components/lucky_box/lucky_box.dart';
import 'package:tik_chat_v2/features/room/presentation/components/lucky_box/widgets/dialog_lucky_box.dart';
import 'package:tik_chat_v2/features/room/presentation/components/lucky_box/widgets/error_luck_widget.dart';
import 'package:tik_chat_v2/features/room/presentation/components/pk/pk_widget.dart';
import 'package:tik_chat_v2/features/room/presentation/components/profile/message_room_profile.dart';
import 'package:tik_chat_v2/features/room/presentation/components/profile/top_room_profile.dart';
import 'package:tik_chat_v2/features/room/presentation/components/view_music/dialog_widget.dart';
import 'package:tik_chat_v2/features/room/presentation/components/view_music/view_music_screen.dart';
import 'package:tik_chat_v2/features/room/presentation/components/widgets/ban_from_writing_dilog.dart';
import 'package:tik_chat_v2/features/room/presentation/components/widgets/diloge_bubel_vip.dart';
import 'package:tik_chat_v2/features/room/presentation/components/widgets/invitation_to_mic.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manager_lucky_boxes/luck_boxes_bloc.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manager_lucky_boxes/luck_boxes_states.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manager_user_in_room/users_in_room_bloc.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manager_user_in_room/users_in_room_events.dart';
import 'package:tik_chat_v2/splash.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';

import '../../../core/utils/config_size.dart';

class EmojieData {
  final String emojie;
  final int emojieId;
  final int length;

  EmojieData(
      {required this.emojie, required this.emojieId, required this.length});
}

class LuckyBoxData {
  final String boxId;
  final String coinns;
  final String ownerBoxId;
  final String ownerName;
  final TypeLuckyBox typeLuckyBox;
  final int remTime;
  final String uId;
  final String ownerImage;

  LuckyBoxData(
      {required this.boxId,
      required this.uId,
      required this.ownerImage,
      required this.coinns,
      required this.ownerName,
      required this.ownerBoxId,
      required this.typeLuckyBox,
      required this.remTime});
}

const String messageContent = "messageContent";
const String message = "message";
const String changeBackground = "changeBackground";
const String imgBackgroundKey = "imgbackground";
const String roomImgKey = "roomImg";
const String roomIntroKey = "roomIntro";
const String roomNameKey = "room_name";
const String userEntro = "userEntro";
const String entroImgIdKey = "entroImgId";
const String userName = "userName";
const String userImge = "userImge";
const String showBannerKey = "showBanner";
const String sendIdKey = "send_id";
const String receiverIdKey = "receiver_id";
const String giftImgKey = "giftImg";
const String isPassword = "is_password";
const String ownerId = "owner_id";
const String showEmojie = "showEmojie";
const String idUser = "id_user";
const String id = "id";
const String showGifts = "showGifts";
const String showGiftKey = "showGift";
const String isExpensive = "isExpensive";
const String plural = "plural";
const String numGift = "num_gift";
const String roomGiftsPriceKey = "gift_price";
const String kicKoutKey = "kickout";
const String duration = "duration";
const String showPkKey = "showPK";
const String hidePkKey = "hidePK";
const String startPkKey = "startPK";
const String updatePkKey = "updatePk";
const String closePkKey = "closePk";
const String leaveMicKey = "leaveMic";
const String upMicKey = "upMic";
const String timePkKey = "PkTime";
const String muteMicKey = "muteMic";
const String unMuteMicKey = "unmuteMic";
const String lockMicKey = "lockMic";
const String unLockMicKey = "unLockMic";
const String topUserKey = "topSendGifts";
const String roomModeKey = "roomMode";
const String loseImg = "https://yai.rstar-soft.com/public/storage/";
const String winImg = "https://yai.rstar-soft.com/public/storage/";
const String updateAdminsKey = "updateAdmins";
const String removeChatKey = "removeChat";
const String showLuckyBoxKey = "showluckybox";
const String hideLuckyBoxKey = "hideluckybox";
const String bannerSuperBoxKey = 'bannerSuperBox';
const String ownerRoomIdKey = "ownerRoomId";
const String boxIDKey = "boxId";
const String boxTypeKey = "boxType";
const String boxCoinsKey = "boxCoins";
const String ownerBoxNameKey = "ownerBoxName";
const String ownerBoxIdKey = "ownerBoxId";
const String cacheFrameKey = 'Frame';
const String cacheEmojieKey = 'Emojie';
const String cacheEntroKey = 'Entro';
const String cachExtraKey = 'Extra';
const String cachExtraLevelKey = 'ExtraLevel';
const String showPobUpKey = "PobUp";
const String banFromWritingKey = "banFromWriting";
const String unbanFromWritingKey = "removeBanFromWriting";
const String banDiviceKey = "banDevice";
const String inviteToSeatKey = "inviteToSeat";
const String muteUserKey = 'muteUser';
const String mute = 'mute';
const String showYallowBanner = "yellowBanner";

String appSign = SplashScreen.appSign ??
    "bb61a6e81736c136dac6e2afc46e71642e8eaf35cdbe713d0ced6aa139ac3faa";

int appID = SplashScreen.appId ?? 1442956895;

class GiftData {
  final String giftId;
  final String img;
  final UserDataModel senderData;
  final UserDataModel reciverData;
  final String giftBanner;
  final String giftImg;
  final String numberOfGift;
  final String roomGiftsPrice;
  final bool isPlural;
  final bool showBanner;
  final String? localPath;

  GiftData(
      {required this.img,
      required this.senderData,
      required this.reciverData,
      required this.giftBanner,
      required this.giftImg,
      required this.numberOfGift,
      required this.roomGiftsPrice,
      required this.isPlural,
      required this.giftId,
      required this.showBanner,
      this.localPath});
}

class EntroData {
  final String imgId;
  final String imgUrl;

  EntroData({required this.imgId, required this.imgUrl});
}

// functions in room

Future<void> showingEmojie(
    {required String userId,
    required EmojieData emojieData,
    required int timeEmojie}) async {
  RoomScreen.listOfEmojie.value.remove(userId);
  RoomScreen.listOfEmojie.value.putIfAbsent(userId, () => emojieData);

  RoomScreen.updateEmojie.value =
      DateTime.now().millisecondsSinceEpoch.toInt() +
          MyDataModel.getInstance().id!;

  Future.delayed(Duration(seconds: timeEmojie), () {
    RoomScreen.listOfEmojie.value.remove(userId);
    RoomScreen.updateEmojie.value =
        DateTime.now().millisecondsSinceEpoch.toInt() +
            MyDataModel.getInstance().id!;
  });
}

List<String> splitUsersInRoom({required List<ZegoUIKitUser> orginalList}) {
  List<String> listIds = [];
  orginalList.forEach((element) {
    listIds.add(element.id);
  });
  return listIds;
}

// getUserDataInMessages(String userId) async {
//   try {
//     List<RoomUserMesseagesModel> user =
//         await RemotlyDataSourceRoom().getUsersInRoon([userId]);
//     RoomScreen.usersMessagesRoom.putIfAbsent(userId, () => user[0]);
//   } catch (e) {
//     log(e.toString());
//   }
// }

// getUserDataInRoom(String userId) async {
//   try {
//     UserDataModel ownerDataModel =
//         await RemotlyDataSourceProfile().getUserData(userId: userId);
//     RoomScreen.usersInRoom.putIfAbsent(userId, () {
//       if (kDebugMode) {
//         log("i will get user $userId ");
//       }
//       return ownerDataModel;
//     });
//   } on DioError catch (e) {
//     if (kDebugMode) {
//       log(e.toString());
//     }
//   }
// }

List<int> getLockSeatIndex({required LayoutMode layoutMode}) {
  if (layoutMode == LayoutMode.hostTopCenter) {
    return [0];
  } else if (layoutMode == LayoutMode.party) {
    return [];
  } else {
    return [0];
  }
}

List<Color> colors = const [
  Color(0xFF9EFF00),
  Color(0xFFFF8E8E),
  Color(0xFF005570),
  Color(0xFFD5A5FC),
  Color(0xFFD9D9D9),
  Color(0xFF9EFF00),
  Color(0xFF9EFF00),
  Color(0xFF9EFF00),
  Color(0xFF9EFF00),
  Color(0xFF9EFF00),
  Color(0xFF9EFF00),
  Color(0xFF9EFF00),
  Color(0xFF9EFF00),
  Color(0xFF9EFF00),
  Color(0xFF9EFF00),
];
int getHostSeatIndex(
    {required LayoutMode layoutMode, required String ownerId}) {
  if (layoutMode == LayoutMode.hostTopCenter) {
    ZegoUIKitPrebuiltLiveAudioRoomState.seatManager
        ?.takeOnSeat(0, owerId: ownerId);
    return 0;
  } else if (layoutMode == LayoutMode.party) {
    return 0;
  }
  return -1;
}

Future<void> loadMusice({required String path}) async {
  // RoomScreen.zegoMediaPlayer = await ZegoExpressEngine.instance.createMediaPlayer();

  await ZegoUIKit().playMedia(filePathOrURL: path, enableRepeat: true);

  // await RoomScreen.zegoMediaPlayer?.loadResource(path);

  // await RoomScreen.zegoMediaPlayer!.start();
  //await   RoomScreen.zegoMediaPlayer!.getPlayVolume();
  // await RoomScreen.zegoMediaPlayer!.enableAux(true);
  // await RoomScreen.zegoMediaPlayer!.enableRepeat(true);
  // log(RoomScreen.zegoMediaPlayer!.getTotalDuration().toString());

  MusicScreen.isPlaying.value = true;
}

Future<void> distroyMusic() async {
  //if (RoomScreen.zegoMediaPlayer != null) {
  await ZegoUIKit().stopMedia();

  //  RoomScreen.zegoMediaPlayer = null;
  MusicScreen.isPlaying.value = false;
  // }
}

void restorePKData() {
  RoomScreen.scoreTeam2 = 0;
  RoomScreen.precantgeTeam1 = 0.5;
  RoomScreen.precantgeTeam2 = 0.5;
  RoomScreen.scoreTeam1 = 0;
}

Future<void> clearAll() async {
  RoomScreen.listOfLoskSeats.value = {0: 0};
  RoomScreen.listOfMuteSeats.clear();
  RoomScreen.clearTimeNotifier = ValueNotifier(0);
  RoomScreen.isGiftEntroAnimating = false;
  RoomScreen.listOfAnimatingGifts.clear();
  RoomScreen.listOfAnimatingEntros.clear();
  RoomScreen.isShowingBanner = false;
  RoomScreen.listOfAnimatingBanner.clear();
  RoomScreen.timeMinutePK = 0;
  RoomScreen.timeSecondPK = 0;
  RoomScreen.isPK.value = false;
  PKWidget.isStartPK.value = false;
  RoomScreen.scoreTeam2 = 0;
  RoomScreen.precantgeTeam1 = 0.5;
  RoomScreen.precantgeTeam2 = 0.5;
  RoomScreen.scoreTeam1 = 0;
  RoomScreen.winRedTeam = false;
  RoomScreen.winBlueTeam = false;
  RoomScreen.userOnMics.value.clear();
  RoomScreen.listOfEmojie.value.clear();
  RoomScreen.musicesInRoom.clear();
  RoomScreen.adminsInRoom.clear();
  MusicScreen.isPlaying.value = false;
  RoomScreen.adminsInRoom.clear();
  RoomScreen.usersInRoom.clear();
  RoomScreen.luckyBoxes.clear();
  RoomScreen.usersMessagesInRoom.clear();
  RoomScreen.usersMessagesRoom.clear();

  LuckyBox.currentBox = 1;
  SetTimerLuckyBox.remTimeSuperBox = 0;
  DialogLuckyBox.startTime = false;
  RoomScreen.showPK.value = false;
  RoomScreen.topUserInRoom.value = UserDataModel();
  RoomScreen.musicesInRoom.clear();
  RoomScreen.usersHasMute.clear();
  RoomScreen.banedUsers.clear();
  RoomScreen.isInviteToMic = false;
  RoomScreen.updatePKNotifier.value = 0;
  RoomScreen.editRoom.value = 0;
  RoomScreen.updateEmojie.value = 0;
  RoomScreen.updatebuttomBar.value = 0;
  RoomScreen.imgbackground.value = "";
  RoomScreen.isKick.value = false;
  RoomScreen.showBanner.value = false;
  RoomScreen.myCoins.value = "";
  await distroyMusic();
}

void chooseSeatToInvatation(LayoutMode layoutMode, BuildContext context,
    String ownerId, String userId) {
  if (layoutMode == LayoutMode.hostTopCenter) {
    if (RoomScreen.userOnMics.value.length == 9) {
      errorToast(
          context: context, title: StringManager.thereAreNoEmptySeats.tr());
    } else {
      for (int i = 1; i < 9; i++) {
        if (RoomScreen.userOnMics.value.containsKey(i) ||
            RoomScreen.listOfLoskSeats.value.containsKey(i)) {
          continue;
        }

        BlocProvider.of<UsersInRoomBloc>(context).add(
            InviteUserInRoom(ownerId: ownerId, userId: userId, indexSeate: i));
        break;
      }
    }
  } else if (layoutMode == LayoutMode.party) {
    if (RoomScreen.userOnMics.value.length == 16) {
      errorToast(
          context: context, title: StringManager.thereAreNoEmptySeats.tr());
    } else {
      for (int i = 0; i < 16; i++) {
        if (RoomScreen.userOnMics.value.containsKey(i) ||
            RoomScreen.listOfLoskSeats.value.containsKey(i)) {
          continue;
        }

        BlocProvider.of<UsersInRoomBloc>(context).add(
            InviteUserInRoom(ownerId: ownerId, userId: userId, indexSeate: i));
      }
    }
  } else if (layoutMode == LayoutMode.seats12) {
    if (RoomScreen.userOnMics.value.length == 12) {
      errorToast(
          context: context, title: StringManager.thereAreNoEmptySeats.tr());
    } else {
      for (int i = 0; i < 12; i++) {
        if (RoomScreen.userOnMics.value.containsKey(i) ||
            RoomScreen.listOfLoskSeats.value.containsKey(i)) {
          continue;
        }

        BlocProvider.of<UsersInRoomBloc>(context).add(
            InviteUserInRoom(ownerId: ownerId, userId: userId, indexSeate: i));
      }
    }
  }
} // widgets in room

Widget userAvatar({required String image, required bool isMicrophoneEnabled}) {
  return Stack(
    children: [
      CachedNetworkImage(
        imageUrl: ConstentApi().getImage(image),
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey[850]!,
          highlightColor: Colors.grey[800]!,
          child: Container(
            width: ConfigSize.defaultSize! * 5.7,
            height: ConfigSize.defaultSize! * 5.7,
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
          ),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
      if (!isMicrophoneEnabled)
        Positioned(
          bottom: 0,
          left: AppPadding.p4,
          child: Container(
            width: AppPadding.p26,
            height: AppPadding.p26,
            decoration: const BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                    image: AssetImage(AssetsPath.muteSeatGreen))),
          ),
        )
    ],
  );
}

Widget showLuckyBannerBodyWidget(
    {required UserDataModel sendDataUser,
    required String ownerId,
    required String coins}) {
  log("showLuckyBannerBodyWidget");
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

invitationDialog(BuildContext context, String owerId, int index) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => InvitationToMicDialog(
      onClick: () async {
        Navigator.pop(context);
        await ZegoUIKitPrebuiltLiveAudioRoomState.seatManager!
            .takeOnSeat(index, owerId: owerId);
      },
    ),
  );
}

showInFormationDilog(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => BanFromWritingDilog(
      accpetText: () => Navigator.pop(context),
      greenText: StringManager.ok,
      headerText: StringManager.youBanFromWriting.tr(),
    ),
  );
}

Widget luckyBox(
    {required StreamController<List<LuckyBoxData>> luckyBoxRemovecontroller}) {
  return BlocConsumer<LuckyBoxesBloc, LuckyBoxesStates>(
      builder: (context, state) {
        return Positioned(
          top: ConfigSize.defaultSize! * 10.4,
          child: InkWell(
              onTap: () {
                showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (BuildContext context) {
                      if (RoomScreen.luckyBoxes.isEmpty) {
                        RoomScreen.updateLuckyBox.value =
                            RoomScreen.updateLuckyBox.value + 1;
                        return Center(
                            child: Container(
                          height: ConfigSize.defaultSize! * 46.2,
                          width: ConfigSize.defaultSize! * 23,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: ColorManager.mainColorList),
                              borderRadius:
                                  BorderRadius.circular(AppPadding.p20)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 0, vertical: AppPadding.p8),
                          child: const ErrorLuckWidget(
                            isNotLucky: true,
                          ),
                        ));
                      } else {
                        return AlertDialog(
                          backgroundColor: Colors.transparent,
                          contentPadding: EdgeInsets.zero,
                          content: DialogLuckyBox(
                            coins: RoomScreen
                                .luckyBoxes[RoomScreen.luckyBoxes.length - 1]
                                .coinns,
                            luckyBoxId: RoomScreen
                                .luckyBoxes[RoomScreen.luckyBoxes.length - 1]
                                .boxId,
                            ownerBoxId: RoomScreen
                                .luckyBoxes[RoomScreen.luckyBoxes.length - 1]
                                .ownerBoxId,
                            ownerBoxName: RoomScreen
                                .luckyBoxes[RoomScreen.luckyBoxes.length - 1]
                                .ownerName,
                            removeController: luckyBoxRemovecontroller,
                            typeLuckyBox: RoomScreen
                                .luckyBoxes[RoomScreen.luckyBoxes.length - 1]
                                .typeLuckyBox,
                            remTime: SetTimerLuckyBox.remTimeSuperBox,
                            ownerImage: RoomScreen
                                .luckyBoxes[RoomScreen.luckyBoxes.length - 1]
                                .ownerImage,
                            uid: RoomScreen
                                .luckyBoxes[RoomScreen.luckyBoxes.length - 1]
                                .uId,
                          ),
                        );
                      }
                    });
                // BlocProvider.of<LuckyBoxesBloc>(context)
                //     .add(PickupBoxesEvent(boxId: boxId)) ;
              },
              child: Stack(
                children: [
                  Image.asset(
                    AssetsPath.luckybox2,
                    width: ConfigSize.defaultSize! * 7,
                    height: ConfigSize.defaultSize! * 7,
                  ),
                  Positioned(
                    top: AppPadding.p40,
                    right: AppPadding.p10,
                    child: Badge.count(
                        count: RoomScreen.luckyBoxes.length,
                        isLabelVisible: RoomScreen.luckyBoxes.length != 1),
                  )
                ],
              )),
        );
      },
      listener: (context, state) {});
}

Widget teamRed() {
  return Padding(
    padding: EdgeInsets.only(top: 20.h, left: 10.w),
    child: Container(
      width: ConfigSize.defaultSize! * 8.2,
      height: ConfigSize.defaultSize! * 8.2,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
        AssetsPath.team1,
      ))),
    ),
  );
}

Widget teamBlue() {
  return Padding(
      padding: EdgeInsets.only(top: 25.h, right: 0.w, left: 25.w, bottom: 15.h),
      child: Container(
        width: ConfigSize.defaultSize! * 7.1,
        height: ConfigSize.defaultSize! * 7.1,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
          AssetsPath.team2,
        ))),
      ));
}

Widget noneUserOnSeat({
  required Map<dynamic, dynamic> extraInfo,
}) {
  return Container(
    padding: EdgeInsets.only(
        top: ConfigSize.defaultSize! * 8.5,
        left: extraInfo['index'] == 0
            ? ConfigSize.defaultSize! * 3.7
            : ConfigSize.defaultSize! * 0.0),
    child: extraInfo['index'] == 0
        ? Image.asset(
            AssetsPath.hostMark,
            width: AppPadding.p20,
            height: AppPadding.p20,
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: colors[1],
                radius: ConfigSize.defaultSize! * .9,
                child: Text(
                  "${extraInfo['index']}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: AppPadding.p12,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                "empty",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: AppPadding.p10,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
  );
}

Widget userForgroundCach({ZegoUIKitUser? user}) {
  return Stack(children: [
    if (user!.inRoomAttributes.value['frm'].toString() != "0")
      ShowSVGA(
        imageId: '${user.inRoomAttributes.value['frm']}$cacheFrameKey',
        url: user.inRoomAttributes.value['f2'] ?? "",
      ),
    ValueListenableBuilder<int>(
        valueListenable: RoomScreen.updateEmojie,
        builder: (context, mapEmoji, _) {
          if (RoomScreen.listOfEmojie.value.containsKey(user.id)) {
            return ShowSVGA(
              imageId:
                  '${RoomScreen.listOfEmojie.value[user.id]!.emojieId.toString()}$cacheEmojieKey',
              url: RoomScreen.listOfEmojie.value[user.id]!.emojie,
            );
          } else {
            return Container();
          }
        }),
    Positioned(
      bottom: 0,
      top: ConfigSize.defaultSize! * 9.5,
      left: ConfigSize.defaultSize! * 0,
      right: 0,
      child: SizedBox(
        width: ConfigSize.defaultSize! * 24,
        height: ConfigSize.defaultSize! * 12,
        child: GradientTextVip(
          text: user.name,
          isVip: user.inRoomAttributes.value['vip'] == ''
              ? false
              : user.inRoomAttributes.value['vip'] == '8'
                  ? true
                  : false,
          textStyle: TextStyle(
            fontSize: AppPadding.p10,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontStyle: FontStyle.italic,
            overflow: TextOverflow.ellipsis,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    )
  ]);
}

Widget userForgroundCachParty({ZegoUIKitUser? user}) {
  return Stack(children: [
    if (user!.inRoomAttributes.value['frm'].toString() != "0")
      ShowSVGA(
        imageId: '${user.inRoomAttributes.value['frm']}$cacheFrameKey',
        url: user.inRoomAttributes.value['f2'] ?? "",
      ),
    //todo use bloc
    ValueListenableBuilder<Map<String, EmojieData>>(
        valueListenable: RoomScreen.listOfEmojie,
        builder: (context, mapEmoji, _) {
          if (mapEmoji.containsKey(user.id)) {
            return ShowSVGA(
              imageId:
                  '${RoomScreen.listOfEmojie.value[user.id]!.emojieId.toString()}$cacheEmojieKey',
              url: RoomScreen.listOfEmojie.value[user.id]!.emojie,
            );
          } else {
            return Container();
          }
        }),
    Positioned(
      bottom: 0,
      top: ConfigSize.defaultSize! * 8.8,
      left: ConfigSize.defaultSize! * 1.0,
      right: 0,
      child: SizedBox(
        width: ConfigSize.defaultSize! * 24,
        height: ConfigSize.defaultSize! * 12,
        child: GradientTextVip(
          text: user.name,
          isVip: user.inRoomAttributes.value['vip'] == ''
              ? false
              : user.inRoomAttributes.value['vip'] == '8'
                  ? true
                  : false,
          textStyle: TextStyle(
              fontSize: AppPadding.p10,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontStyle: FontStyle.italic,
              overflow: TextOverflow.ellipsis),
          textAlign: TextAlign.center,
        ),
      ),
    )
  ]);
}

Widget noneUserOnSeatParty({required Map<dynamic, dynamic> extraInfo}) {
  return Container(
    padding: EdgeInsets.only(
        top: ConfigSize.defaultSize! * 8, left: ConfigSize.defaultSize! * 2.2),
    child: Row(
      children: [
        CircleAvatar(
          backgroundColor: colors[1],
          radius: ConfigSize.defaultSize! * .9,
          child: Text(
            "${extraInfo['index'] + 1}",
            style: const TextStyle(
                color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(
          width: 3,
        ),
        Text(
          StringManager.empty.tr(),
          style: TextStyle(
              color: Colors.white,
              fontSize: AppPadding.p10,
              fontWeight: FontWeight.w700),
        ),
      ],
    ),
  );
}

Widget userForgroundCachMidParty({ZegoUIKitUser? user}) {
  return Stack(children: [
    if (user!.inRoomAttributes.value['frm'].toString() != "0")
      ShowSVGA(
        imageId: '${user.inRoomAttributes.value['frm']}$cacheFrameKey',
        url: user.inRoomAttributes.value['f2'] ?? "",
      ),
    ValueListenableBuilder<Map<String, EmojieData>>(
        valueListenable: RoomScreen.listOfEmojie,
        builder: (context, mapEmoji, _) {
          if (mapEmoji.containsKey(user.id)) {
            return ShowSVGA(
              imageId:
                  '${RoomScreen.listOfEmojie.value[user.id]!.emojieId.toString()}$cacheEmojieKey',
              url: RoomScreen.listOfEmojie.value[user.id]!.emojie,
            );
          } else {
            return Container();
          }
        }),
    Positioned(
      bottom: 0,
      top: ConfigSize.defaultSize! * 8.8,
      left: ConfigSize.defaultSize! * 2.5,
      right: 0,
      child: SizedBox(
        width: ConfigSize.defaultSize! * 24,
        height: ConfigSize.defaultSize! * 12,
        child: GradientTextVip(
          text: user.name,
          isVip: user.inRoomAttributes.value['vip'] == ''
              ? false
              : user.inRoomAttributes.value['vip'] == '8'
                  ? true
                  : false,
          textStyle: TextStyle(
              fontSize: AppPadding.p10,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontStyle: FontStyle.italic,
              overflow: TextOverflow.ellipsis),
          textAlign: TextAlign.start,
        ),
      ),
    )
  ]);
}

Widget noneUserOnSeatMidParty({required Map<dynamic, dynamic> extraInfo}) {
  return Container(
    padding: EdgeInsets.only(
        top: ConfigSize.defaultSize! * 8.4,
        left: ConfigSize.defaultSize! * 2.2),
    child: Row(
      children: [
        CircleAvatar(
          backgroundColor: colors[1],
          radius: ConfigSize.defaultSize! * .9,
          child: Text(
            "${extraInfo['index'] + 1}",
            style: const TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(
          width: 3,
        ),
        Text(
          StringManager.empty.tr(),
          style: TextStyle(
              color: Colors.white,
              fontSize: AppPadding.p10,
              fontWeight: FontWeight.w700),
        ),
      ],
    ),
  );
}

Widget messagesChached(
    {required ZegoInRoomMessage message,
    required String vip,
    required String sender,
    required String receiver,
    required String bubble,
    required String frame,
    required MyDataModel myDataModel,
    required BuildContext context,
    required LayoutMode layoutMode,
    required EnterRoomModel room}) {
  bool changeTheme = message.changeTheme ?? false;
  List<String> words = message.message.split(" ");

  List<TextSpan> spans = [];

  for (String word in words) {
    if (word.startsWith("@")) {
      spans.add(TextSpan(
          text: "$word ", style: const TextStyle(color: Colors.yellow)));
    } else {
      spans.add(TextSpan(
          text: "$word ", style: const TextStyle(color: Colors.white)));
    }
  }

  return InkWell(
    onTap: () {
      bottomDailog(
          context: context,
          widget: MessageRoomProfile(
            myData: myDataModel,
            userId: message.user.id.toString(),
            roomData: room,
            layoutMode: layoutMode,
          ));
    },
    child: Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppPadding.p8, vertical: AppPadding.p2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: UserImage(

                    image: message.user.inRoomAttributes.value['img'] ??
                        RoomScreen.usersMessagesRoom[message.user.id]?.image ??
                        ""),
              ),
              SizedBox(width: ConfigSize.defaultSize,),
            

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    SizedBox(height: ConfigSize.defaultSize!*1.5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                           GradientTextVip(
                        text: message.user.name,
                        isVip: message.user.inRoomAttributes.value['vip'] == ''
                            ? false
                            : message.user.inRoomAttributes.value['vip'] == '8'
                                ? true
                                : false,
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                            fontSize: AppPadding.p10),
                        textAlign: TextAlign.center,
                      ),
                                  SizedBox(width: ConfigSize.defaultSize!-3,),
                          room.ownerId.toString() == message.user.id
                              ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset(AssetsPath.hostMark))
                              : const SizedBox(),
                          AristocracyLevel(
                              level: vip == ""
                                  ? RoomScreen.usersMessagesRoom[message.user.id]
                                          ?.vipLevel ??
                                      0
                                  : int.parse(vip)),
                          const SizedBox(
                            width: 1,
                          ),
                          if ((RoomScreen.usersMessagesRoom[message.user.id]
                                      ?.senderLevelImg ??
                                  '') !=
                              '')
                            SizedBox(
                              width: ConfigSize.defaultSize! * 4,
                              height: ConfigSize.defaultSize! * 2,
                              child: LevelContainer(
                                image: sender == ""
                                    ? RoomScreen.usersMessagesRoom[message.user.id]
                                            ?.senderLevelImg ??
                                        ''
                                    : sender,
                              ),
                            ),
                          const SizedBox(
                            width: 1,
                          ),
                          if ((RoomScreen.usersMessagesRoom[message.user.id]
                                      ?.revicerLevelImg ??
                                  '') !=
                              '')
                            SizedBox(
                              width: ConfigSize.defaultSize! * 4,
                              height: ConfigSize.defaultSize! * 2,
                              child: LevelContainer(
                                image: receiver == ""
                                    ? RoomScreen.usersMessagesRoom[message.user.id]
                                            ?.revicerLevelImg ??
                                        ''
                                    : receiver,
                              ),
                            ),
                        ],
                      ),
                      (bubble == "" && changeTheme == false)
              ? Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p24,
                      top: AppPadding.p2,
                      bottom: AppPadding.p2,
                      right: AppPadding.p2),
                  child: Container(
                    // width: ConfigSize.defaultSize!*33,
                    decoration: BoxDecoration(
                        color: ColorManager.lightGray.withOpacity(0.2)),

                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    child: SelectableText.rich(
                      TextSpan(children: spans),
                    ),
                  ),
                )
              : changeTheme
                  ? Padding(
                      padding: EdgeInsets.only(
                          left: ConfigSize.defaultSize! * 3,
                          top: ConfigSize.defaultSize! - 4,
                          bottom: ConfigSize.defaultSize! - 4,
                          right: ConfigSize.defaultSize! - 4),
                      child: Container(
                        // width: ConfigSize.defaultSize!*33,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(ConfigSize.defaultSize!),
                            color: ColorManager.deepBlue),

                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 4),
                        child: SelectableText.rich(
                          TextSpan(children: spans),
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(
                          left: AppPadding.p24,
                          top: AppPadding.p2,
                          bottom: AppPadding.p2,
                          right: AppPadding.p2),
                      child: CachedNetworkImage(
                          imageUrl: ConstentApi().getImage(bubble == ""
                              ? RoomScreen
                                  .usersMessagesRoom[message.user.id]?.bubble
                              : bubble),
                          imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.fill),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: ConfigSize.defaultSize! + 15,
                                    vertical: ConfigSize.defaultSize!),
                                child: SelectableText.rich(
                                  TextSpan(children: spans),
                                ),
                              ),
                          placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey[850]!,
                                highlightColor: Colors.grey[800]!,
                                child: Container(
                                  width: ConfigSize.defaultSize! * 5.7,
                                  height: ConfigSize.defaultSize! * 5.7,
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                          errorWidget: (context, url, error) => const Center(
                                child: Icon(Icons.error),
                              )),
                    ),
                    
                    ],

                  ),
            ],
          ),
        
        ],
      ),
    ),
  );
}

Widget giftBannerWidget(
    {required UserDataModel sendDataUser,
    required UserDataModel receiverDataUser,
    required String giftImage,
    required AnimationController controllerBanner,
    required Animation<Offset> offsetAnimationBanner,
    required bool isPlural,
    required String roomIntro}) {
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
                      image: sendDataUser.profile!.image!,
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
                          if (sendDataUser.level!.receiverImage! != '')
                            LevelContainer(
                                image: sendDataUser.level!.receiverImage!),
                          if (sendDataUser.level!.senderImage! != '')
                            LevelContainer(
                                image: sendDataUser.level!.senderImage!),
                          if (sendDataUser.vip1 != null)
                            AristocracyLevel(
                              level: sendDataUser.vip1!.level!,
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
                      image: receiverDataUser.profile!.image!,
                      imageSize: AppPadding.p26),
                ],
              ),
            ));
      });
}

Widget popUpWidget(
    {UserDataModel? ownerDataModel,
    required EnterRoomModel enterRoomModel,
    required int vip,
    required String massage}) {
  return DilogBubbelVip(
    roomData: enterRoomModel,
    message: massage,
    vip: vip,
    userData: ownerDataModel,
  );
}

Widget roomBackground(
  BuildContext context,
  EnterRoomModel room,
) {
  return ValueListenableBuilder<String>(
    valueListenable: RoomScreen.imgbackground,
    builder: (context, edit, _) {
      return CachedNetworkImage(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        fit: BoxFit.cover,
        imageUrl: (ConstentApi().getImage(RoomScreen.imgbackground.value == ""
            ? room.roomBackground
            : RoomScreen.imgbackground.value)),
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey[850]!,
          highlightColor: Colors.grey[800]!,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    },
  );
}

Widget hostTopCenterWidget(BuildContext context, LayoutMode layoutMode,
    UserDataModel? topUser, MyDataModel myDataModel, EnterRoomModel room) {
  return Padding(
    padding: EdgeInsets.only(
        top: ConfigSize.defaultSize! * 10, right: ConfigSize.defaultSize! * 6),
    child: Align(
      alignment: Alignment.topRight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: ConfigSize.defaultSize! * 10,
            height: ConfigSize.defaultSize! * 11,
            child: const Image(
              image: AssetImage(AssetsPath.kingchir),
            ),
          ),
          if (topUser?.id != null)
            Stack(
              alignment: Alignment.center,
              children: [
                InkWell(
                  onTap: () => bottomDailog(
                    context: context,
                    widget: TopRoomProfile(
                      myData: myDataModel,
                      roomData: room,
                      userId: topUser.id.toString(),
                      layoutMode: layoutMode,
                    ),
                  ),
                  child: UserImage(
                    image: topUser!.profile!.image!,
                    frame: topUser.frame,
                    frameId: topUser.frameId,
                    imageSize: ConfigSize.defaultSize! * 4,
                  ),
                ),
                topUser.frame == ""
                    ? SizedBox(
                        width: ConfigSize.defaultSize! * 6,
                        height: ConfigSize.defaultSize! * 6,
                      )
                    : Positioned(
                        child: SizedBox(
                            width: ConfigSize.defaultSize! * 6,
                            height: ConfigSize.defaultSize! * 6,
                            child: ShowSVGA(
                              imageId: '${topUser.frameId}$cacheFrameKey',
                              url: topUser.frame ?? '',
                            )),
                      ),
              ],
            ),
          if (topUser?.id != null)
            Positioned(
              top: ConfigSize.defaultSize! * 9,
              //  bottom: ConfigSize.screenWidth! * 0.08,
              child: Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ConfigSize.screenWidth! * 0.02,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: GradientTextVip(
                      text: topUser!.name!,
                      isVip: topUser.hasColorName ?? false,
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                          color: Colors.white),
                    )),
              ),
            )
        ],
      ),
    ),
  );
}

/*Widget familyRoomIcon (BuildContext context ,EnterRoomModel room ){
      return  Positioned(
                    right: 0,
                    top: ConfigSize.defaultSize! * 7,
                    child: InkWell(
                      onTap: ()  async{
                    
                
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamed(context, Routes.familyProfile,
                            arguments:room.roomFamily!.id);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: ConfigSize.defaultSize!),
                        width: ConfigSize.defaultSize!*10,
                        padding: EdgeInsets.symmetric(
                            horizontal: ConfigSize.defaultSize!, vertical: AppPadding.p2),
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(AssetsPath.purbleBackGround)),
                            borderRadius: BorderRadius.circular(ConfigSize.defaultSize!)),
                        child: Center(
                          child: Text(
                            room.roomFamily!.name!,
                            style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize: ConfigSize.defaultSize! * 1.2 ,overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ),
                    ),
                  );
 }*/

Widget musicWidget(
    BuildContext context,
    final void Function() refrashRoom,
    EnterRoomModel room,
    AnimationController controllerMusice,
    final void Function() destroyMusic) {
  return ValueListenableBuilder<bool>(
      valueListenable: MusicScreen.isPlaying,
      builder: (context, isPlay, _) {
        if (isPlay) {
          return DraggableFloatWidget(
            config: DraggableFloatWidgetBaseConfig(
              initPositionYInTop: false,
              initPositionYMarginBorder: ConfigSize.screenHeight! - 300,
              borderTopContainTopBar: true,
              borderBottom: 30,
            ),
            onTap: () {
              //  int totalDuration = await RoomScreen.zegoMediaPlayer!.getTotalDuration();
              int totalDuration = ZegoUIKit().getMediaTotalDuration();
              showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                        backgroundColor: ColorManager.mainColor,
                        child: MusicDialog(
                          refreshRoom: refrashRoom,
                          ownerId: room.ownerId.toString(),
                          totalDuration: totalDuration,
                        ));
                  });
            },
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: RippleAnimation(
                      repeat: true,
                      color: ColorManager.mainColor,
                      minRadius: 30,
                      ripplesCount: 6,
                      child: RotationTransition(
                          turns: controllerMusice,
                          child: Container(
                              height: ConfigSize.defaultSize! * 7,
                              width: ConfigSize.defaultSize! * 7,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(
                                      ConfigSize.defaultSize! * 7),
                                  image: const DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      image: AssetImage(AssetsPath.music)))))),
                ),
                GestureDetector(
                  onTap: destroyMusic,
                  child: Container(
                      decoration: BoxDecoration(
                          color: ColorManager.mainColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        CupertinoIcons.clear,
                        color: Colors.white,
                        size: AppPadding.p14,
                      )),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      });
}

showBanFromWritingDilog(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => BanFromWritingDilog(
      accpetText: () => Navigator.pop(context),
      greenText: StringManager.ok,
      headerText: StringManager.youBanFromWriting,
    ),
  );
}

class YallowBannerData {
  final int senderId;
  final String message;
  final bool yallowBannerhasPasswoedRoom;
  final String yallowBannerOwnerRoom;

  YallowBannerData(
      {required this.senderId,
      required this.message,
      required this.yallowBannerhasPasswoedRoom,
      required this.yallowBannerOwnerRoom});
}

showYallowBannerWidget(
    {required AnimationController controllerYallowBanner,
    required Animation<Offset> offsetAnimationYallowBanner,
    UserDataModel? senderYallowBanner,
    required hasPassword,
    required myData,
    required int ownerId,
    required int cureentRoomId}) {
  return Directionality(
    textDirection: ui.TextDirection.rtl,
    child: AnimatedBuilder(
        animation: controllerYallowBanner,
        builder: (context, child) {
          return Transform.translate(
              offset: offsetAnimationYallowBanner.value,
              child: InkWell(
                onTap: () {
                  if (ownerId != cureentRoomId) {
                    Methods().checkIfRoomHasPassword(
                        context: context,
                        isInRoom: true,
                        hasPassword: hasPassword,
                        ownerId: ownerId.toString(),
                        myData: myData);
                  }
                },
                child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: ConfigSize.defaultSize! - 4,
                        horizontal: ConfigSize.defaultSize! - 3),
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: ColorManager.yellowGrident),
                        borderRadius: BorderRadius.circular(20)),
                    margin: EdgeInsets.only(top: ConfigSize.defaultSize! * 10),
                    width: ConfigSize.defaultSize! * 35,
                    height: ConfigSize.defaultSize! * 4,
                    child: Row(
                      children: [
                        UserImage(
                            imageSize: ConfigSize.defaultSize! * 4,
                            image: senderYallowBanner!.isAanonymous!
                                ? StringManager.imageAnanyomus
                                : senderYallowBanner.profile!.image!),
                        SizedBox(
                          width: ConfigSize.defaultSize,
                        ),
                        SizedBox(
                          width: ConfigSize.defaultSize! * 23.5,
                          child: TextScroll(
                            textDirection: ui.TextDirection.rtl,

                            senderYallowBanner.isAanonymous!
                                ? "${StringManager.nameAnayoums} : ${ZegoInRoomMessageInput.messageYallowBanner}"
                                : "${senderYallowBanner.name} : ${ZegoInRoomMessageInput.messageYallowBanner}",
                            mode: TextScrollMode.endless,
                            velocity:
                                const Velocity(pixelsPerSecond: Offset(70, 0)),
                            delayBefore: const Duration(milliseconds: 500),
                            pauseBetween: const Duration(seconds: 1),
                            style: const TextStyle(color: Colors.black),

                            // textAlign: TextAlign.left,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorManager.gray.withOpacity(0.6)),
                          child: IconButton(
                              onPressed: () {
                                controllerYallowBanner.reset();
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.black,
                                size: 15,
                              )),
                        )
                      ],
                    )),
              ));
        }),
  );

  // AnimatedBuilder(
  //
  //   animation: yellowBannercontroller,
  //   builder: (context, child) {
  //     return Positioned(
  //       left: -ConfigSize.defaultSize!*40+ yellowBannercontroller.value * (MediaQuery.of(context).size.width ),
  //       child: child!,
  //     );
  //   },
  //   child: ,
  // ) ;
}
