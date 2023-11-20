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
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/profile/data/data_sorce/remotly_data_source_profile.dart';
import 'package:tik_chat_v2/features/room_audio/data/data_sorce/remotly_data_source_room.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/room_vistor_model.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/get_all_room_user_usecase.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/gifts/widgets/gift_users.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/heaser_room/owner_room/owner_room.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/heaser_room/update_room_screen/widget/edit_features_container.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/lucky_box/lucky_box_controller.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/lucky_box/widgets/dialog_lucky_box.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/lucky_gift/widgets/lucky_candy.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/Conter_Time_pk_Widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/pk_functions.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/pk_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/profile/message_room_profile.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/profile/user_porfile_in_room_body.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/view_music/view_music_screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/background%20widgets/room_background.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/ban_from_writing_dilog.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/invitation_to_mic.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/messages_chached.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/show_entro_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/viewbackground%20widgets/music_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/viewbackground%20widgets/viewbackground_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_pk/pk_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_pk/pk_events.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_user_in_room/users_in_room_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_user_in_room/users_in_room_events.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_events.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/components/live_page.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/core/core_managers.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/message/message_input.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/defines/user.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/uikit_service.dart';

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
String appSign =  "";
int appID =  0;


class GiftData {
  final String giftId;
  final String img;
  final RoomVistorModel? senderData;
  final RoomVistorModel? reciverData;
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
    ZegoLiveAudioRoomManagers().seatManager
        ?.takeOnSeat(0, ownerId: ownerId);
    return 0;
  } else if (layoutMode == LayoutMode.party) {
    return 0;
  }
  return -1;
}

Future<void> loadMusice({required String path}) async {
  MusicWidget.isIPlayerMedia=true ;
  await ZegoUIKit().playMedia(filePathOrURL: path);


  MusicScreen.isPlaying.value = true;
}

Future<void> clearAll(String ownerId, BuildContext context) async {

  RoomScreen.listOfLoskSeats.value = {0: 0};
  RoomScreen.listOfMuteSeats.clear();
  RoomScreen.clearTimeNotifier = ValueNotifier(0);
  RoomScreen.isGiftEntroAnimating = false;
  RoomScreen.listOfAnimatingGifts.clear();
  RoomScreen.listOfAnimatingEntros.clear();
  if(ownerId == MyDataModel.getInstance().id.toString() &&  PkController.showPK.value){
    BlocProvider.of<PKBloc>(context).add(ClosePKEvent(ownerId: ownerId, pkId: PKWidget.pkId));
    BlocProvider.of<PKBloc>(context).add(HidePKEvent(ownerId: ownerId));
  }
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
  PkController.showPK.value = false;
  PkController.updatePKNotifier.value = 0;
  if(getIt<SetTimerPK>().timer != null){
    getIt<SetTimerPK>().timer?.cancel();
  }
  RoomScreen.userOnMics.value.clear();
  RoomScreen.listOfEmojie.value.clear();
  MusicScreen.musicesInRoom.clear();
  RoomScreen.adminsInRoom.clear();
  MessagesChached.usersMessagesRoom.clear();
  MusicScreen.isPlaying.value = false;
  RoomScreen.usersInRoom.clear();
  LuckyBoxVariables.luckyBoxMap['luckyBoxes'].clear();
  MessageRoomProfile.usersMessagesProfileRoom.clear();
  LuckyBoxVariables.luckyBoxMap['currentBox'] = 1;
  SetTimerLuckyBox.remTimeSuperBox = 0;
  DialogLuckyBox.startTime = false;
  RoomScreen.topUserInRoom.value = UserDataModel();
  RoomScreen.usersHasMute.clear();
  RoomScreen.banedUsers.clear();
  InvitationToMicDialog.isInviteToMic = false;
  OwnerOfRoom.editRoom.value = 0;
  RoomScreen.updateEmojie.value = 0;
  UserProfileInRoom.updatebuttomBar.value = 0;
  RoomBackground.imgbackground.value = "";
  ViewbackgroundWidget.isKick.value = false;
  RoomScreen.showBanner.value = false;
  RoomScreen.myCoins.value = "";
  LuckyCandy.winCircularluckyGift.value = 0;
  GiftUser.userSelected.clear();
  GiftUser.userOnMicsForGifts.clear();
  RoomScreen.showBanner.value = false;
}

Future<void> distroyMusic() async {
  MusicWidget.isIPlayerMedia=false ;
  await ZegoUIKit.instance.stopMedia();
  MusicScreen.isPlaying.value = false;
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
        await ZegoLiveAudioRoomManagers().seatManager!
            .takeOnSeat(index, ownerId: owerId);
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
  RoomBackground.imgbackground.value = result[messageContent][imgBackgroundKey] ?? "";
  roomDataUpdates['room_img'] = result[messageContent][roomImgKey];
   roomDataUpdates['room_intro']  = result[messageContent][roomIntroKey];
  roomDataUpdates['room_name'] = result[messageContent][roomNameKey];
  roomDataUpdates['room_type'] = result[messageContent]['room_type'] ?? "";
  EditFeaturesContainer.roomIsLoked = result[messageContent]['is_locked'];
  OwnerOfRoom.editRoom.value = OwnerOfRoom.editRoom.value + 1;
}

UserEntro(Map<String, dynamic> result,  Map<String,String> userIntroData ,  Future<void> Function(String imgId, String imgUrl) loadAnimationEntro)async{
  if (result[messageContent][entroImgIdKey] == "") {
    userIntroData['user_name_intro']  = result[messageContent][userName];
    userIntroData['user_image_intro']   = result[messageContent][userImge];
    if (result[messageContent]['vip'] == null ? false : result[messageContent]['vip'] > 0) {
      ShowEntroWidget.showEntro.value = true;

    }


  } else {
    if (RoomScreen.isGiftEntroAnimating) {
      RoomScreen.listOfAnimatingEntros.add(EntroData(
          imgId: result[messageContent][entroImgIdKey],
          imgUrl: result[messageContent]['entroImg']));
    } else {
      await loadAnimationEntro(result[messageContent][entroImgIdKey].toString(),
      result[messageContent]['entroImg']);
      userIntroData['user_name_intro']  = result[messageContent][userName];
      userIntroData['user_image_intro']  = result[messageContent][userImge];
      if ( result[messageContent]['vip'] ) {
        ShowEntroWidget.showEntro.value = true;
      }

    }
  }
}

ShowPopularBanner(Map<String, dynamic> result, Map<String,dynamic>  userBannerData , var controllerBanner){
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

  userBannerData['user_data_sender'] = sendData;
  userBannerData['user_data_receiver'] = receiverData;
  userBannerData['gift_banner']  = result[messageContent][giftImgKey].toString();
  userBannerData['is_password_room_banner']  = result[messageContent]['isPass'];
  userBannerData['owner_id_room_banner']  = result[messageContent]['oId'].toString();
  controllerBanner.forward();
  RoomScreen.showBanner.value = true;
}

ShowGifts(Map<String, dynamic> result, String id, Future<void> Function({required GiftData giftData}) loadMp4Gift, Future<void> Function(GiftData giftData) loadAnimationGift, String roomOwnerId)async{
  String sendId = result[messageContent][sendIdKey].toString();
  String receiverId = result[messageContent][receiverIdKey].toString();
  if (sendId == id) {
    RoomScreen.myCoins.value = result[messageContent]['coins'];
  }
  List<RoomVistorModel> sendData = [];
  List<RoomVistorModel> receiverData = [];
  if (result[messageContent][isExpensive]) {
    if (RoomScreen.usersInRoom[sendId] == null) {
      sendData = await RemotlyDataSourceRoom().getRoomUser(pram: GetAlluserPram(roomOwnerId, "1", [sendId]));
      RoomScreen.usersInRoom.putIfAbsent(sendId, () => sendData[0]);
    } else {
      sendData.add(RoomScreen.usersInRoom[sendId]!);
    }

    if (RoomScreen.usersInRoom[receiverId] == null) {
      receiverData = await RemotlyDataSourceRoom().getRoomUser(pram: GetAlluserPram(roomOwnerId, "1", [receiverId]));
      RoomScreen.usersInRoom.putIfAbsent(receiverId, () => receiverData[0]);
    } else {
      receiverData.add(RoomScreen.usersInRoom[receiverId]!);
    }
  }
  Map<String, dynamic> cachedGifts = {};
  if (result[messageContent]['showGift'].contains("mp4")) {
    cachedGifts = await Methods().getCachingVideo(key: StringManager.cachGiftKey);
  }

  GiftData giftData = GiftData(
      localPath: cachedGifts.containsKey(result[messageContent]['gift_id'].toString())
          ? cachedGifts[result[messageContent]['gift_id'].toString()]
          : null,
      giftId: result[messageContent]['gift_id'].toString(),
      img: result[messageContent][showGiftKey],
      senderData: sendData.isNotEmpty? sendData[0] : null,
      reciverData: receiverData.isNotEmpty? receiverData[0] : null,
      giftBanner: result[messageContent][giftImgKey].toString(),
      giftImg: result[messageContent][showGiftKey],
      numberOfGift: result[messageContent][numGift].toString(),
      roomGiftsPrice:
      result[messageContent][roomGiftsPriceKey].toString(),
      isPlural: result[messageContent][plural],
      showBanner: result[messageContent][isExpensive]);
      if (cachedGifts.containsKey(result[messageContent]['gift_id'].toString())) {
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
  durationKickout['durationKickout'] = int.parse(result[messageContent]['duration']);
  ViewbackgroundWidget.isKick.value = true;
  Future.delayed(const Duration(seconds: 3), () async {
    Navigator.pop(context);
    await Methods().exitFromRoom(ownerId, context);
    BlocProvider.of<OnRoomBloc>(context).add(LeaveMicEvent(
        ownerId: ownerId,
        userId: id));
    BlocProvider.of<OnRoomBloc>(context).add(InitRoomEvent());
    ViewbackgroundWidget.isKick.value = false;
  });
}


UpMicKey(Map<String, dynamic> result){
  ZegoUIKitUser zegoUIKitUser = ZegoUIKitUser(
      id: result[messageContent]['userId'],
      name: result[messageContent]['userName']);
  if(result[messageContent]['is_swap']){
    RoomScreen.userOnMics.value.removeWhere((key, value) => key == result[messageContent]['old_position']);
  }
  RoomScreen.userOnMics.value.putIfAbsent(
      int.parse(result[messageContent]['position']), () => zegoUIKitUser);
}

MuteMicKey(Map<String, dynamic> result){
  RoomScreen.listOfMuteSeats.putIfAbsent(
      int.parse(result[messageContent]['position']),
          () => int.parse(result[messageContent]['position']));
  ZegoLivePage.editAudioVideoContainer.value =
      ZegoLivePage.editAudioVideoContainer.value + 1;
}

UnMuteMicKey(Map<String, dynamic> result){
  RoomScreen.listOfMuteSeats
      .remove(int.parse(result[messageContent]['position']));

  ZegoLivePage.editAudioVideoContainer.value =
      ZegoLivePage.editAudioVideoContainer.value + 1;
}

LockMicKey(Map<String, dynamic> result){
  RoomScreen.listOfLoskSeats.value.putIfAbsent(
      int.parse(result[messageContent]['position']),
          () => int.parse(result[messageContent]['position']));
  ZegoLivePage.editAudioVideoContainer.value =
      ZegoLivePage.editAudioVideoContainer.value + 1;
}

UnLockMicKey(Map<String, dynamic> result){
  RoomScreen.listOfLoskSeats.value
      .remove(int.parse(result[messageContent]['position']));
  ZegoLivePage.editAudioVideoContainer.value =
      ZegoLivePage.editAudioVideoContainer.value + 1;
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

ShowPobUpKey(Map<String, dynamic> result, Map<String , dynamic> pobUpData, var showPopUp)async{
  ZegoInRoomMessageInput.senderPobUpId = result[messageContent]['uId'];
  pobUpData['pop_up_sender']  = UserDataModel(name:result[messageContent]['name'] , profile: ProfileRoomModel(image:result[messageContent]['image'] ,  ) , vip1:VipCenterModel(level:result[messageContent]['VIP'] ) );

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
  UserProfileInRoom.updatebuttomBar.value = UserProfileInRoom.updatebuttomBar.value + 1;
}

InviteToSeatKey(Map<String, dynamic> result, String id, String ownerId, BuildContext context){
  if (result[messageContent][idUser] == id) {
    if (InvitationToMicDialog.isInviteToMic == false) {
      InvitationToMicDialog.isInviteToMic = true;
      invitationDialog(context, ownerId, result[messageContent]['index']);
    }
    //todo update this show
  }
}
