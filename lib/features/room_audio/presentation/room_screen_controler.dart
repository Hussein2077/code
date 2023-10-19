// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:async';
import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/level_data_model.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/model/profile_room_model.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/model/vip_center_model.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/profile/data/data_sorce/remotly_data_source_profile.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/lucky_box/lucky_box_controller.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/lucky_box/widgets/dialog_lucky_box.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/lucky_box/widgets/error_luck_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/lucky_box/widgets/sucess_luck_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/pk_functions.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/pk_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/view_music/view_music_screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/ban_from_writing_dilog.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/invitation_to_mic.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_user_in_room/users_in_room_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_user_in_room/users_in_room_events.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_events.dart';
import 'package:tik_chat_v2/splash.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';

class EmojieData {
  final String emojie;
  final int emojieId;
  final int length;

  EmojieData(
      {required this.emojie, required this.emojieId, required this.length});
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
const String leaveMicKey = "leaveMic";
const String upMicKey = "upMic";
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

String appSign = SplashScreen.appSign ?? "bb61a6e81736c136dac6e2afc46e71642e8eaf35cdbe713d0ced6aa139ac3faa";

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
  log(listIds.toString());
  return listIds;
}



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

int getHostSeatIndex({required LayoutMode layoutMode, required String ownerId}) {
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

Future<void> clearAll() async {
  RoomScreen.listOfLoskSeats.value = {0: 0};
  RoomScreen.listOfMuteSeats.clear();
  RoomScreen.clearTimeNotifier = ValueNotifier(0);
  RoomScreen.isGiftEntroAnimating = false;
  RoomScreen.listOfAnimatingGifts.clear();
  RoomScreen.listOfAnimatingEntros.clear();
  RoomScreen.isShowingBanner = false;
  RoomScreen.listOfAnimatingBanner.clear();
  PkController.timeMinutePK = 0;
  PkController.timeSecondPK = 0;
  PkController.isPK.value = false;
  PKWidget.isStartPK.value = false;
  PkController.scoreTeam2 = 0;
  PkController.precantgeTeam1 = 0.5;
  PkController.precantgeTeam2 = 0.5;
  PkController.scoreTeam1 = 0;
  PkController.winRedTeam = false;
  PkController.winBlueTeam = false;
  RoomScreen.userOnMics.value.clear();
  RoomScreen.listOfEmojie.value.clear();
  RoomScreen.musicesInRoom.clear();
  RoomScreen.adminsInRoom.clear();
  RoomScreen.usersMessagesRoom.clear();
  RoomScreen.usersMessagesProfileRoom.clear();
  MusicScreen.isPlaying.value = false;
  RoomScreen.adminsInRoom.clear();
  RoomScreen.usersInRoom.clear();
  LuckyBoxVariables.luckyBoxMap['luckyBoxes'].clear();
  RoomScreen.usersMessagesProfileRoom.clear();
  LuckyBoxVariables.luckyBoxMap['currentBox'] = 1;
  SetTimerLuckyBox.remTimeSuperBox = 0;
  DialogLuckyBox.startTime = false;
  PkController.showPK.value = false;
  RoomScreen.topUserInRoom.value = UserDataModel();
  RoomScreen.musicesInRoom.clear();
  RoomScreen.usersHasMute.clear();
  RoomScreen.banedUsers.clear();
  RoomScreen.isInviteToMic = false;
  PkController.updatePKNotifier.value = 0;
  RoomScreen.editRoom.value = 0;
  RoomScreen.updateEmojie.value = 0;
  RoomScreen.updatebuttomBar.value = 0;
  RoomScreen.imgbackground.value = "";
  RoomScreen.isKick.value = false;
  RoomScreen.showBanner.value = false;
  RoomScreen.myCoins.value = "";
  RoomScreen.winCircularluckyGift.value = 0;

  await distroyMusic();
}


void chooseSeatToInvatation(LayoutMode layoutMode, BuildContext context, String ownerId, String userId) {
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



ChangeBackground(Map<String, dynamic> result, Map<String,String> roomDataUpdates ){
  RoomScreen.imgbackground.value = result[messageContent][imgBackgroundKey] ?? "";
  roomDataUpdates['room_img'] = result[messageContent][roomImgKey];
   roomDataUpdates['room_intro']  = result[messageContent][roomIntroKey];
  roomDataUpdates['room_name'] = result[messageContent][roomNameKey];
  roomDataUpdates['room_type'] = result[messageContent]['room_type'] ?? "";
  RoomScreen.roomIsLoked = result[messageContent]['is_locked'];
  RoomScreen.editRoom.value = RoomScreen.editRoom.value + 1;
}

UserEntro(Map<String, dynamic> result,  Map<String,String> userIntroData ,  Future<void> Function(String imgId, String imgUrl) loadAnimationEntro)async{
  if (result[messageContent][entroImgIdKey] == "") {
    if (result[messageContent]['vip'] == null
        ? false
        : result[messageContent]['vip'] > 0) {
      RoomScreen.showEntro.value = true;
    }

    userIntroData['user_name_intro']  = result[messageContent][userName];
    userIntroData['user_image_intro']   = result[messageContent][userImge];
  } else {
    if (RoomScreen.isGiftEntroAnimating) {
      RoomScreen.listOfAnimatingEntros.add(EntroData(
          imgId: result[messageContent][entroImgIdKey],
          imgUrl: result[messageContent]['entroImg']));
    } else {
      await loadAnimationEntro(result[messageContent][entroImgIdKey].toString(),
      result[messageContent]['entroImg']);
      if (result[messageContent]['vip'] == null
          ? false
          : result[messageContent]['vip'] > 0) {
        RoomScreen.showEntro.value = true;
      }
      userIntroData['user_name_intro']  = result[messageContent][userName];
      userIntroData['user_image_intro']  = result[messageContent][userImge];
    }
  }
}

ShowPopularBanner(Map<String, dynamic> result, var sendDataUser, var receiverDataUser, Map<String,dynamic>  userBannerData , var controllerBanner){
  UserDataModel sendData;

  sendData = UserDataModel(
      profile: ProfileRoomModel(image: result[messageContent]['si']),
      name: result[messageContent]['sn'],
      level: LevelDataModel(
          senderImage: result[messageContent]['ssl'],
          receiverImage: result[messageContent]['srl']),
      vip1: VipCenterModel(level: result[messageContent]['sv']));

  UserDataModel receiverData;
  receiverData = UserDataModel(
      profile: ProfileRoomModel(image: result[messageContent]['ri']),
      name: result[messageContent]['rn'],
      level: LevelDataModel(
          senderImage: result[messageContent]['rsl'],
          receiverImage: result[messageContent]['rrl']),
      vip1: VipCenterModel(level: result[messageContent]['rv']));

  sendDataUser = sendData;
  receiverDataUser = receiverData;
  userBannerData['gift_banner']  = result[messageContent][giftImgKey].toString();
  userBannerData['is_password_room_banner']  = result[messageContent]['isPass'];
  userBannerData['owner_id_room_banner']  = result[messageContent]['oId'].toString();
  controllerBanner.forward();
  RoomScreen.showBanner.value = true;
}

ShowGifts(Map<String, dynamic> result, String id, Future<void> Function({required GiftData giftData}) loadMp4Gift, Future<void> Function(GiftData giftData) loadAnimationGift)async{
  String sendId = result[messageContent][sendIdKey].toString();
  String receiverId = result[messageContent][receiverIdKey].toString();
  if (sendId == id) {
    RoomScreen.myCoins.value = result[messageContent]['coins'];
  }
  UserDataModel sendData = UserDataModel();
  UserDataModel receiverData = UserDataModel();
  if (result[messageContent][isExpensive]) {
    if (RoomScreen.usersInRoom[sendId] == null) {
      sendData =
          await RemotlyDataSourceProfile().getUserData(userId: sendId);
      RoomScreen.usersInRoom.putIfAbsent(sendId, () => sendData);
    } else {
      sendData = RoomScreen.usersInRoom[sendId]!;
    }

    if (RoomScreen.usersInRoom[receiverId] == null) {
      receiverData = await RemotlyDataSourceProfile()
          .getUserData(userId: receiverId);
      RoomScreen.usersInRoom.putIfAbsent(receiverId, () => receiverData);
    } else {
      receiverData = RoomScreen.usersInRoom[receiverId]!;
    }
  }
  Map<String, dynamic> cachedGifts = {};
  if (result[messageContent]['showGift'].contains("mp4")) {
    cachedGifts =
        await Methods().getCachingVideo(key: StringManager.cachGiftKey);
  }

  GiftData giftData = GiftData(
      localPath: cachedGifts
          .containsKey(result[messageContent]['gift_id'].toString())
          ? cachedGifts[result[messageContent]['gift_id'].toString()]
          : null,
      giftId: result[messageContent]['gift_id'].toString(),
      img: result[messageContent][showGiftKey],
      senderData: sendData,
      reciverData: receiverData,
      giftBanner: result[messageContent][giftImgKey].toString(),
      giftImg: result[messageContent][showGiftKey],
      numberOfGift: result[messageContent][numGift].toString(),
      roomGiftsPrice:
      result[messageContent][roomGiftsPriceKey].toString(),
      isPlural: result[messageContent][plural],
      showBanner: result[messageContent][isExpensive]);
  if (cachedGifts
      .containsKey(result[messageContent]['gift_id'].toString())) {
    // RoomScreen.isGiftEntroAnimating = true;
    if (RoomScreen.isGiftEntroAnimating) {
      RoomScreen.listOfAnimatingMp4Gifts.add(giftData);
    } else {
      await loadMp4Gift(giftData: giftData);
    }
  } else {
    if (RoomScreen.isGiftEntroAnimating) {
      RoomScreen.listOfAnimatingGifts.add(giftData);
    } else {
      await loadAnimationGift(giftData);
    }
  }
}

KicKout(Map<String, dynamic> result, var durationKickout, String ownerId, String id, BuildContext context){
  durationKickout = result[messageContent]['duration'];
  RoomScreen.isKick.value = true;
  Future.delayed(const Duration(seconds: 3), () async {
    Navigator.pop(context);
    await Methods().exitFromRoom(ownerId);
    BlocProvider.of<OnRoomBloc>(context).add(LeaveMicEvent(
        ownerId: ownerId,
        userId: id));
    BlocProvider.of<OnRoomBloc>(context).add(InitRoomEvent());
    RoomScreen.isKick.value = false;
  });
}


UpMicKey(Map<String, dynamic> result){
  ZegoUIKitUser zegoUIKitUser = ZegoUIKitUser(
      id: result[messageContent]['userId'],
      name: result[messageContent]['userName']);
  RoomScreen.userOnMics.value.putIfAbsent(
      int.parse(result[messageContent]['position']), () => zegoUIKitUser);
}

MuteMicKey(Map<String, dynamic> result){
  RoomScreen.listOfMuteSeats.putIfAbsent(
      int.parse(result[messageContent]['position']),
          () => int.parse(result[messageContent]['position']));
  RoomScreen.editAudioVideoContainer.value =
      RoomScreen.editAudioVideoContainer.value + 1;
}

UnMuteMicKey(Map<String, dynamic> result){
  RoomScreen.listOfMuteSeats
      .remove(int.parse(result[messageContent]['position']));

  RoomScreen.editAudioVideoContainer.value =
      RoomScreen.editAudioVideoContainer.value + 1;
}

LockMicKey(Map<String, dynamic> result){
  RoomScreen.listOfLoskSeats.value.putIfAbsent(
      int.parse(result[messageContent]['position']),
          () => int.parse(result[messageContent]['position']));
  RoomScreen.editAudioVideoContainer.value =
      RoomScreen.editAudioVideoContainer.value + 1;
}

UnLockMicKey(Map<String, dynamic> result){
  RoomScreen.listOfLoskSeats.value
      .remove(int.parse(result[messageContent]['position']));
  RoomScreen.editAudioVideoContainer.value =
      RoomScreen.editAudioVideoContainer.value + 1;
}

TopUserKey(Map<String, dynamic> result)async{
  RoomScreen.topUserInRoom.value = UserDataModel(
      id: result[messageContent]['id'],
      name: result[messageContent]['name'],
      frame: result[messageContent]['frame'],
      profile: ProfileRoomModel(image: result[messageContent]['img']),
      hasColorName: result[messageContent]['has_color_name']);
  final topModel = await RemotlyDataSourceProfile().getUserData(
      userId: RoomScreen.topUserInRoom.value.id.toString());
  RoomScreen.topUserInRoom.value = topModel;
}

ShowPobUpKey(Map<String, dynamic> result, var pobUpSender, var showPopUp)async{
  ZegoInRoomMessageInput.senderPobUpId = result[messageContent]['uId'];
  if (RoomScreen.usersInRoom[result[messageContent]['uId']] == null) {
    pobUpSender = await RemotlyDataSourceProfile().getUserData(userId: result[messageContent]['uId'].toString());
    RoomScreen.usersInRoom.putIfAbsent(result[messageContent]['uId'].toString(), () => pobUpSender!);
  } else {
    pobUpSender = RoomScreen.usersInRoom[result[messageContent]['uId'].toString()];
  }
  ZegoInRoomMessageInput.messagePonUp = result[messageContent]['my_msg'];

  showPopUp.value = true;
}

BanFromWritingKey(Map<String, dynamic> result, String id, String ownerId, BuildContext context){
  log(result[messageContent]['userId'].toString());
  RoomScreen.banedUsers.putIfAbsent(result[messageContent]['userId'], () => result[messageContent]['userId']);
  if (id == result[messageContent]['userId']) {
    RoomScreen.showMessageButton.value = false;
    showBanFromWritingDilog(context);
  } else if (result[messageContent]['userId'] == "") {
    RoomScreen.banFromWriteIcon.value = true;

    if (id != ownerId) {
      showBanFromWritingDilog(context);
    }

    RoomScreen.usersInRoom.forEach((key, value) {
      if (id != ownerId) {
        RoomScreen.banedUsers.putIfAbsent(key, () => key);
        RoomScreen.showMessageButton.value = false;
      }
    });
  }
}

UnbanFromWritingKey(Map<String, dynamic> result, String id){
  RoomScreen.banedUsers.remove(result[messageContent]['userId']);

  if (id == result[messageContent]['userId']) {
    RoomScreen.showMessageButton.value = true;
  } else if (result[messageContent]['userId'] == "") {
    RoomScreen.banFromWriteIcon.value = false;
    RoomScreen.showMessageButton.value = true;
    RoomScreen.banedUsers.clear();
  }
}

MuteUserKey(Map<String, dynamic> result){
  if (result[messageContent][mute]) {
    ZegoUIKit().turnMicrophoneOn(false, userID: result[messageContent][idUser]);
    RoomScreen.usersHasMute.add(result[messageContent][idUser]);
  } else {
    RoomScreen.usersHasMute.remove(result[messageContent][idUser]);
  }
  RoomScreen.updatebuttomBar.value = RoomScreen.updatebuttomBar.value + 1;
}

InviteToSeatKey(Map<String, dynamic> result, String id, String ownerId, BuildContext context){
  if (result[messageContent][idUser] == id) {
    if (RoomScreen.isInviteToMic == false) {
      RoomScreen.isInviteToMic = true;
      invitationDialog(context, ownerId, result[messageContent]['index']);
    }
    //todo update this show
  }
}
