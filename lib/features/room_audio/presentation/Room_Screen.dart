// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:svgaplayer_flutter/player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/profile/data/data_sorce/remotly_data_source_profile.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/user_on_mic_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/basic_tool_button.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/emojie/emojie_button.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/gifts/gift_button.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/gifts/widgets/gift_users.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/massage_Button.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/speakr_button.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/heaser_room/update_room_screen/widget/edit_features_container.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/lucky_box/lucky_box_controller.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/lucky_box/widgets/dialog_lucky_box.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/Conter_Time_pk_Widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/pk_functions.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/pk_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/background%20widgets/background_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/messages_chached.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/seatconfig%20widgets/none_user_on_seat.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/seatconfig%20widgets/none_user_on_seat_mid_party.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/seatconfig%20widgets/none_user_on_seat_party.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/team_blue.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/team_red.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/seatconfig%20widgets/user_forground_cach.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/seatconfig%20widgets/user_forground_cach_mid_party.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/seatconfig%20widgets/user_forground_cach_party.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/user_avatar.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/viewbackground%20widgets/viewbackground_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_get_users_in_room/manager_get_users_in_room_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_get_users_in_room/manager_get_users_in_room_event.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_get_users_in_room/manager_get_users_in_room_states.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/room_screen_controler.dart';
import 'package:tik_chat_v2/main_screen/main_screen.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/components/audio_video/defines.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/live_audio_room.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/live_audio_room_config.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_live_audio/src/live_audio_room_defines.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/message/message_input.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/defines/command.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/defines/user.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/uikit_service.dart';
import 'package:video_player/video_player.dart';

class RoomScreen extends StatefulWidget {
  final EnterRoomModel room;
  final MyDataModel myDataModel;
  final bool isHost;
  static bool isGiftEntroAnimating = false;
  static late bool outRoom;
  static List<GiftData> listOfAnimatingGifts = [];
  static List<GiftData> listOfAnimatingMp4Gifts = [];
  static List<EntroData> listOfAnimatingEntros = [];
  static Map<int, int> listOfMuteSeats = {};
  static List<String> usersHasMute = [];
  static ValueNotifier<Map<String, EmojieData>> listOfEmojie = ValueNotifier({});
  static ValueNotifier<int> updateEmojie = ValueNotifier(0);
  static Map<String, String> adminsInRoom = {};
  static Map<String, String> banedUsers = {};
  static Map<String, UserDataModel> usersInRoom = {};
  static ValueNotifier<int> clearTimeNotifier = ValueNotifier(0);
  static ValueNotifier<bool> showMessageButton = ValueNotifier<bool>(true);
  static ValueNotifier<bool> banFromWriteIcon = ValueNotifier<bool>(true);
  static ValueNotifier<Map<int, ZegoUIKitUser>> userOnMics = ValueNotifier<Map<int, ZegoUIKitUser>>({});
  static ValueNotifier<UserDataModel> topUserInRoom = ValueNotifier<UserDataModel>(UserDataModel());
  static ValueNotifier<bool> showBanner = ValueNotifier<bool>(false);
  static ValueNotifier<String> myCoins = ValueNotifier<String>('');
  static ValueNotifier<String> roomGiftsPrice = ValueNotifier<String>("");
  static ValueNotifier<Map<int, int>> listOfLoskSeats = ValueNotifier<Map<int, int>>({0: 0});
  static ValueNotifier<bool> isVideoVisible = ValueNotifier<bool>(false);
  static late LayoutMode layoutMode;


  const RoomScreen(
      {Key? key,
      required this.isHost,
      required this.room,
      required this.myDataModel})
      : super(key: key);

  @override
  RoomScreenState createState() => RoomScreenState();
}

class RoomScreenState extends State<RoomScreen> with TickerProviderStateMixin {
  final List<StreamSubscription<dynamic>?> subscriptions = [];
  late SVGAAnimationController animationControllerGift;
  late SVGAAnimationController animationControllerEntro;
  late AnimationController controllerBanner;
  late Animation<Offset> offsetAnimationBanner;
  late AnimationController controllerEntro; // entro animation
  late Animation<Offset> offsetAnimationEntro;
  late final AnimationController controllerMusice;
  ValueNotifier<bool> showPopUp = ValueNotifier<bool>(false);
  String userIdEmojie = ""; // to show emojie
  String giftImg = ""; // to show img gift
  late AnimationController luckGiftBannderController;
  late Animation<Offset> offsetLuckGiftAnimationBanner;


  ///////
  Map<String,String>   roomDataUpdates =
  {'room_intro': '','room_name':'',
    'room_img':'', 'room_type':''};
  /////

  String roomBackgroundChached = "";

 //////
  Map<String,String> userIntroData = {'user_name_intro':'','user_image_intro':''};
 /////

  //////
  Map<String,dynamic> userBannerData =
  { 'gift_banner':'',
    'owner_id_room_banner':'',
    'is_password_room_banner': false,
    'user_data_sender':UserDataModel(),
    'user_data_receiver' : UserDataModel()
  };
  //////

  //////
  Map<String, int> durationKickout = {"durationKickout": 0};
  /////

  ////
  Map<String, dynamic> yallowBanner = {"yallowBannerhasPasswoedRoom": '' ,
    "yallowBannerOwnerRoom" : ''};
  ////

  ////
  Map<String, dynamic> superBox = {"isPasswordRoomLuckyBanner": false, "superCoins" : '', "ownerIdRoomLuckyBanner": ''};
  ////

  Map<String, bool> isPlural = {'isPlural': false};

  Map<String, bool> showYellowBanner = {'showYellowBanner': false};

  String numberOfGift = "0";
  Map <String , dynamic> popUpData = {"pop_up_sender" : null};
  late AnimationController yellowBannercontroller;
  late Animation<Offset> offsetAnimationYellowBanner;
  UserDataModel? yallowBannerSender;

  @override
  void initState() {


    super.initState();

    RoomScreen.usersHasMute = widget.room.mutedUsers!.split(', ');

    luckGiftBannderController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    luckGiftBannderController.addListener(() {
      if (luckGiftBannderController.isCompleted) {
        luckGiftBannderController.stop();
      }
    });
    offsetLuckGiftAnimationBanner =
        Tween(begin: const Offset(-650, 0), end: const Offset(0, 0))
            .animate(CurvedAnimation(
          parent: luckGiftBannderController,
          curve: Curves.easeInOut,
        ));
    RoomScreen.isGiftEntroAnimating = false;
    if (widget.room.mode == 1) {
     RoomScreen.layoutMode = LayoutMode.party;
    } else if (widget.room.mode == 0) {
      RoomScreen.layoutMode = LayoutMode.hostTopCenter;
    } else if (widget.room.mode == 2) {
      RoomScreen.layoutMode = LayoutMode.seats12;
    }

    animationControllerGift = SVGAAnimationController(vsync: this);
    animationControllerEntro = SVGAAnimationController(vsync: this);
    PkController.animationControllerRedTeam = SVGAAnimationController(vsync: this);
    PkController.animationControllerBlueTeam = SVGAAnimationController(vsync: this);
    yellowBannercontroller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    yellowBannercontroller.addListener(() {
      if (controllerBanner.isCompleted) {
        controllerBanner.stop();
        Future.delayed(const Duration(seconds: 3), () async {
          controllerBanner.reverse();
        });
        controllerBanner.reverse();
      }
    });
    offsetAnimationYellowBanner = Tween(
            begin: const Offset(-400, 0),
            end: Offset(ConfigSize.defaultSize! * 1.5, 0))
        .animate(CurvedAnimation(
      parent: yellowBannercontroller,
      curve: Curves.easeInOut,
    ));

    controllerBanner = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    controllerBanner.addListener(() {
      if (controllerBanner.isCompleted) {
        controllerBanner.stop();
        Future.delayed(const Duration(seconds: 3), () async {
          controllerBanner.reverse().then((value) {
            if (RoomScreen.showBanner.value) {
              RoomScreen.showBanner.value = false;
            }
          });
        });
      }
    });
    offsetAnimationBanner = Tween(
            begin: const Offset(-650, 0),
            end: Offset(ConfigSize.defaultSize! * 1.5, 0))
        .animate(CurvedAnimation(
      parent: controllerBanner,
      curve: Curves.easeInOut,
    ));
    controllerEntro = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat(reverse: true);
    offsetAnimationEntro = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.5, 0.0),
    ).animate(CurvedAnimation(
      parent: controllerEntro,
      curve: Curves.linearToEaseOut,
    )); // entro animation
    controllerMusice = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();

    roomBackgroundChached = widget.room.roomBackground ?? '';
    RoomScreen.roomGiftsPrice.value = widget.room.giftPrice.toString();
    RoomScreen.topUserInRoom.value = widget.room.topUser ?? UserDataModel();

    RoomScreen.outRoom = false;

    RoomScreen.banFromWriteIcon.value = widget.room.isUsersBaned ?? false;

    if (widget.room.isUsersBaned ?? false) {
      RoomScreen.banedUsers.putIfAbsent(widget.myDataModel.id.toString(),
          () => widget.myDataModel.id.toString());
      RoomScreen.showMessageButton.value = false;
    }

    //   RoomScreen.zegoMediaPlayer = ZegoLiveAudioRoomController();
    RoomScreen.myCoins.value =
        widget.myDataModel.myStore?.coins.toString() ?? '';
    if (!MainScreen.iskeepInRoom.value) {
      EditFeaturesContainer.roomIsLoked = widget.room.roomPassStatus!;

      if (widget.room.showPk == 1) {
        PkController.showPK.value = true;
      }

      RoomScreen.listOfLoskSeats.value.putIfAbsent(0, () => 0); //host place
      for (int i = 0; i < widget.room.seats!.length; i++) {
        if (widget.room.seats![i] == "locked") {
          RoomScreen.listOfLoskSeats.value.putIfAbsent(i, () => i);
        }
        else if (widget.room.seats![i] == "muted") {
          RoomScreen.listOfMuteSeats.putIfAbsent(i, () => i);
        }
        else if (widget.room.seats![i] == "empty") {
        }
        else if (widget.room.seats![i]['id'] != null) {
          UserOnMicModel myDataModel = UserOnMicModel.fromJson(widget.room.seats![i]);
          if(myDataModel.seatCondition == "locked"){
            RoomScreen.listOfLoskSeats.value.putIfAbsent(i, () => i);
          }else if(myDataModel.seatCondition == "muted"){
            RoomScreen.listOfMuteSeats.putIfAbsent(i, () => i);
          }
          ZegoUIKitUser zegoUIKitUser = ZegoUIKitUser(id: myDataModel.id.toString(), name: myDataModel.name.toString());
         zegoUIKitUser.inRoomAttributes.value['img'] = myDataModel.img;
          RoomScreen.userOnMics.value.putIfAbsent(i, () => zegoUIKitUser);
        }
      }

      for (var element in widget.room.banedUsers!) {
        RoomScreen.banedUsers.putIfAbsent(element, () => element);
      }

      for (var element in widget.room.admins!) {
        RoomScreen.adminsInRoom.putIfAbsent(element, () => element);
      }
      if (widget.room.boxes != null) {
        for (int i = 0; i < widget.room.boxes!.length; i++) {
          LuckyBoxData luckyBox = LuckyBoxData(
              boxId: widget.room.boxes![i].id.toString(),
              coinns: widget.room.boxes![i].coins.toString(),
              ownerName: widget.room.boxes![i].ownerBoxData.name.toString(),
              ownerBoxId: widget.room.boxes![i].ownerBoxData.id.toString(),
              typeLuckyBox: widget.room.boxes![i].type.toString() == 'normal'
                  ? TypeLuckyBox.normalBox
                  : TypeLuckyBox.superBox,
              remTime: widget.room.boxes![i].remmingTime,
              uId: widget.room.boxes![i].ownerBoxData.uuid!,
              ownerImage: widget.room.boxes![i].ownerBoxData.image ?? '');
          LuckyBoxVariables.luckyBoxMap['luckyBoxes'].add(luckyBox);
        }

        if (widget.room.boxes!.isNotEmpty) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.transparent,
                    contentPadding: EdgeInsets.zero,
                    content: DialogLuckyBox(
                      coins: LuckyBoxVariables.luckyBoxMap['luckyBoxes'][LuckyBoxVariables.luckyBoxMap['luckyBoxes'].length - 1].coinns,
                      luckyBoxId: LuckyBoxVariables.luckyBoxMap['luckyBoxes'][LuckyBoxVariables.luckyBoxMap['luckyBoxes'].length - 1].boxId,
                      ownerBoxId: LuckyBoxVariables.luckyBoxMap['luckyBoxes'][LuckyBoxVariables.luckyBoxMap['luckyBoxes'].length - 1]
                          .ownerBoxId,
                      ownerBoxName: LuckyBoxVariables.luckyBoxMap['luckyBoxes'][LuckyBoxVariables.luckyBoxMap['luckyBoxes'].length - 1]
                          .ownerName,
                      removeController: LuckyBoxVariables.luckyBoxRemovecontroller,
                      typeLuckyBox: LuckyBoxVariables.luckyBoxMap['luckyBoxes'][LuckyBoxVariables.luckyBoxMap['luckyBoxes'].length - 1]
                          .typeLuckyBox,
                      remTime: LuckyBoxVariables.luckyBoxMap['luckyBoxes'][LuckyBoxVariables.luckyBoxMap['luckyBoxes'].length - 1].remTime,
                      ownerImage: LuckyBoxVariables.luckyBoxMap['luckyBoxes'][LuckyBoxVariables.luckyBoxMap['luckyBoxes'].length - 1]
                          .ownerImage,
                      uid: LuckyBoxVariables.luckyBoxMap['luckyBoxes'][LuckyBoxVariables.luckyBoxMap['luckyBoxes'].length - 1].uId,
                    ),
                  );
                }); // your dialong goes here
          });
        }
      }

      LuckyBoxVariables.luckyBoxAddecontroller.stream
          .listen((List<LuckyBoxData> updatedListBoxes) {
        if (updatedListBoxes.isNotEmpty) {
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.transparent,
                  contentPadding: EdgeInsets.zero,
                  content: DialogLuckyBox(
                    coins: updatedListBoxes[updatedListBoxes.length - 1].coinns,
                    luckyBoxId:
                        updatedListBoxes[updatedListBoxes.length - 1].boxId,
                    ownerBoxId: updatedListBoxes[updatedListBoxes.length - 1]
                        .ownerBoxId,
                    ownerBoxName:
                        updatedListBoxes[updatedListBoxes.length - 1].ownerName,
                    removeController: LuckyBoxVariables.luckyBoxRemovecontroller,
                    typeLuckyBox: updatedListBoxes[updatedListBoxes.length - 1]
                        .typeLuckyBox,
                    remTime: 30,
                    ownerImage: updatedListBoxes[updatedListBoxes.length - 1]
                        .ownerImage,
                    uid: updatedListBoxes[updatedListBoxes.length - 1].uId,
                  ),
                );
              });
          LuckyBoxVariables.updateLuckyBox.value = LuckyBoxVariables.updateLuckyBox.value + 1;
        } else {
          updatedListBoxes.clear();
          LuckyBoxVariables.updateLuckyBox.value = LuckyBoxVariables.updateLuckyBox.value + 1;
        }
      });

      LuckyBoxVariables.luckyBoxRemovecontroller.stream
          .listen((List<LuckyBoxData> updatedListBoxes) {
        LuckyBoxVariables.updateLuckyBox.value = LuckyBoxVariables.updateLuckyBox.value + 1;
      });
      //topUserCached
      if (widget.room.topUser!.id != null){
        Future.delayed(Duration.zero, () async {
          final topUser = await RemotlyDataSourceProfile()
              .getUserData(userId: widget.room.topUser!.id.toString());
          RoomScreen.topUserInRoom.value = topUser;
        });
      }
      if (widget.room.isPK == 1) {
        PkController.isPK.value = true;
        PkController.showPK.value = true;
        PkController.timeMinutePK = widget.room.pkModel!.timeMPk!;
        PkController.timeSecondPK = widget.room.pkModel!.timeSPk!;
        PkController.scoreTeam1 = widget.room.pkModel!.team1Score!;
        PkController.scoreTeam2 = widget.room.pkModel!.team2Score!;
        PkController.precantgeTeam1 =
            widget.room.pkModel!.percentageTeam1!.toDouble();
        PkController.precantgeTeam2 =
            widget.room.pkModel!.percentageTeam2!.toDouble();
        PKWidget.pkId = widget.room.pkModel!.pkId.toString();
        PKWidget.isStartPK.value = true;
        PkController.updatePKNotifier.value =
            PkController.updatePKNotifier.value + 1;
        getIt<SetTimerPK>().start(context, widget.room.ownerId.toString());
      }
      Future.delayed(const Duration(seconds: 3), () async {
        ZegoUIKit.instance.sendInRoomMessage("انضم للغرفة", false);

        if(widget.myDataModel.intro! != ""){
          Map<String,dynamic>    mapZego = {
            "messageContent" : {
              "message" : "userEntro" ,
              "entroImg"  :  widget.myDataModel.intro ,
              "entroImgId" : widget.myDataModel.introId ,
              'userName'   : widget.myDataModel.name,
              'userImge'   : widget.myDataModel.profile?.image,
              'vip'   :  ((MyDataModel.getInstance().vip1?.level??0)>0) ? true:false,
            }
          };
          UserEntro(mapZego, userIntroData ,loadAnimationEntro);
          String map = jsonEncode(mapZego);
          ZegoUIKit.instance.sendInRoomCommand(map,[]);

        }
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      subscriptions
        ..add(ZegoUIKit()
            .getSignalingPlugin()
            .getInRoomTextMessageReceivedEventStream()
            .listen((event) {}))
        ..add(ZegoUIKit()
            .getInRoomCommandReceivedStream()
            .listen(onInRoomCommandReceived));
    });
  }

  @override
  void dispose() {
    //todo remove that from here and remove init from initFunction
    for (final subscription in subscriptions) {
      subscription?.cancel();
    }
    controllerEntro.dispose();
    controllerBanner.dispose();
    animationControllerGift.dispose();
    animationControllerEntro.dispose();
    PkController.animationControllerBlueTeam.dispose();
    PkController.animationControllerRedTeam.dispose();
    controllerMusice.dispose();
    LuckyBoxVariables.luckyBoxAddecontroller.close();
    RoomScreen.isGiftEntroAnimating = false;
    yellowBannercontroller.dispose();
    luckGiftBannderController.dispose();
    RoomScreen.showBanner.value = false;


    super.dispose();
  }

  Future<void> loadMp4Gift({required GiftData giftData}) async {
    RoomScreen.isGiftEntroAnimating = true;
    if (giftData.showBanner) {
      userBannerData['user_data_sender'] = giftData.senderData;
      userBannerData['user_data_receiver'] = giftData.reciverData;
      userBannerData ['gift_banner']   = giftData.giftBanner;
      giftImg = giftData.giftImg;
      RoomScreen.showBanner.value = giftData.showBanner;
      isPlural['isPlural'] = giftData.isPlural;
      numberOfGift = giftData.numberOfGift;
      RoomScreen.roomGiftsPrice.value = giftData.roomGiftsPrice;
    } else {
      RoomScreen.roomGiftsPrice.value = giftData.roomGiftsPrice;
    }

   // if (giftData.localPath == null) {
    ViewbackgroundWidget.mp4Controller =
    VideoPlayerController.networkUrl(Uri.parse(ConstentApi().getImage(giftData.giftImg)))..initialize();

    // await Methods()
    //       .cacheMp4(
    //           vedioId: int.parse(giftData.giftId), vedioUrl: giftData.giftImg)
    //       .then((value) async {
    //     Directory appDocDir = await getApplicationDocumentsDirectory();
    //     String rootPath = appDocDir.path;
    //     String path = "$rootPath/${giftData.giftId}.mp4";
    //     ViewbackgroundWidget.mp4Controller = VideoPlayerController.file(File(path))..initialize();
    //   });
    // } else {
    //   log('2${giftData.localPath!}');
    //   ViewbackgroundWidget.mp4Controller = VideoPlayerController.file(File(giftData.localPath!))
    //     ..initialize();
    // }
    ViewbackgroundWidget.mp4Controller!.addListener(() {
      if (ViewbackgroundWidget.mp4Controller!.value.position >=
          ViewbackgroundWidget.mp4Controller!.value.duration) {
        if (giftData.showBanner && RoomScreen.showBanner.value) {
          RoomScreen.showBanner.value = false;
          controllerBanner.reverse();
        }

        RoomScreen.isVideoVisible.value = false;

        ViewbackgroundWidget.mp4Controller!.pause();
        RoomScreen.isGiftEntroAnimating = false;
        loadMoreAnimationMp4Gifts();

        // mp4Controller!.dispose();
      } else {
        RoomScreen.isVideoVisible.value = true;
        ViewbackgroundWidget.mp4Controller!.play();
      }
    });
  }

  Future<void> loadAnimationGift(GiftData giftData) async {
    RoomScreen.isGiftEntroAnimating = true;
    if (giftData.showBanner) {
      userBannerData['user_data_sender'] = giftData.senderData;
      userBannerData['user_data_receiver'] = giftData.reciverData;
      userBannerData['gift_banner'] = giftData.giftBanner;
      giftImg = giftData.giftImg;
      controllerBanner.forward();
      isPlural['isPlural'] = giftData.isPlural;
      numberOfGift = giftData.numberOfGift;
      RoomScreen.showBanner.value = giftData.showBanner;
      RoomScreen.roomGiftsPrice.value = giftData.roomGiftsPrice;
    } else {
      RoomScreen.roomGiftsPrice.value = giftData.roomGiftsPrice;
    }

    try {
      final videoItem =
          await Methods().getCachedSvgaImage(giftData.giftId, giftData.img);

      animationControllerGift.videoItem = videoItem;

      animationControllerGift.forward().whenComplete(() {
        RoomScreen.isGiftEntroAnimating = false;
        if (giftData.showBanner && RoomScreen.showBanner.value) {
          // RoomScreen.showBanner.value = false;
        }
        loadMoreAnimationGifts();
        return animationControllerGift.videoItem = null;
      });
    } catch (e) {
      RoomScreen.isGiftEntroAnimating = false;
    }
  }

  void loadMoreAnimationMp4Gifts() async {
    if (RoomScreen.listOfAnimatingMp4Gifts.isNotEmpty) {
      loadMp4Gift(giftData: RoomScreen.listOfAnimatingMp4Gifts[0]);
      RoomScreen.listOfAnimatingMp4Gifts.removeAt(0);
    } else {
      log("is MP4 empty");
      RoomScreen.isGiftEntroAnimating = false;
    }
  }

  void loadMoreAnimationGifts() async {
    if (RoomScreen.listOfAnimatingGifts.isNotEmpty) {
      if (animationControllerGift.isCompleted) {
        await loadAnimationGift(RoomScreen.listOfAnimatingGifts[0]);
        RoomScreen.listOfAnimatingGifts.removeAt(0);
      }
    } else if (RoomScreen.listOfAnimatingEntros.isNotEmpty) {
      await loadAnimationEntro(RoomScreen.listOfAnimatingEntros[0].imgId,
          RoomScreen.listOfAnimatingEntros[0].imgUrl);
      RoomScreen.listOfAnimatingEntros.removeAt(0);
    } else {
      log("is empty");
      RoomScreen.isGiftEntroAnimating = false;
    }
  }

  Future<void> loadAnimationEntro(String imgId, String imgUrl) async {
    RoomScreen.isGiftEntroAnimating = true;
    try {
      final videoItem =
          await Methods().getCachedSvgaImage('$imgId$cacheEntroKey', imgUrl);
      animationControllerGift.videoItem = videoItem;
      //  animationControllerGift.videoItem.audios
      animationControllerGift.forward().whenComplete(() {
        RoomScreen.isGiftEntroAnimating = false;
        loadMoreAnimationEntros();
        loadMoreAnimationGifts();
        return animationControllerGift.videoItem = null;
      });
    } catch (e) {
      RoomScreen.isGiftEntroAnimating = false;
    }
  }

  void loadMoreAnimationEntros() async {
    if (RoomScreen.listOfAnimatingEntros.isNotEmpty) {
      if (animationControllerEntro.isCompleted) {
        await loadAnimationEntro(RoomScreen.listOfAnimatingEntros[0].imgId,
            RoomScreen.listOfAnimatingEntros[0].imgUrl);
        RoomScreen.listOfAnimatingEntros.removeAt(0);
      }
    } else if (RoomScreen.listOfAnimatingGifts.isNotEmpty) {
      loadMoreAnimationGifts();
    } else {
      log("is empty");
    }
  }

  Future<void> showYallowBannerAnimation(
      {required int senderId,
      required String message,
      required bool hasPasswoedRoom,
      required int ownerId}) async {
    ZegoInRoomMessageInput.senderYallowBannerId = senderId;
    if (RoomScreen.usersInRoom[senderId.toString()] == null) {
      yallowBannerSender = await RemotlyDataSourceProfile()
          .getUserData(userId: senderId.toString());
      RoomScreen.usersInRoom
          .putIfAbsent(senderId.toString(), () => yallowBannerSender!);
    } else {
      yallowBannerSender = RoomScreen.usersInRoom[senderId.toString()];
    }
    ZegoInRoomMessageInput.messageYallowBanner = message;
    yallowBanner['yallowBannerhasPasswoedRoom'] = hasPasswoedRoom;

    if (yellowBannercontroller.animationBehavior.name == "normal") {
      yellowBannercontroller.reset();
    }

    setState(() {
      yellowBannercontroller.forward();
      showYellowBanner['showYellowBanner'] = true;
      yallowBanner['yallowBannerOwnerRoom'] = ownerId;
    });
    //  }

    Future.delayed(const Duration(minutes: 7), () {
      //ckeck if there are other banner ;
      yellowBannercontroller.reverse().then((value) =>

          log("don"));
    });
  }

//massages
  Future<void> onInRoomCommandReceived(
      ZegoInRoomCommandReceivedData commandData) async {
    Map<String, dynamic> result = jsonDecode(commandData.command);
    if (result[messageContent] != null) {
      if (result[messageContent][message] == changeBackground) {
        ChangeBackground(result,roomDataUpdates);
      }
      else if (result[messageContent][message] == userEntro) {
        UserEntro(result, userIntroData ,loadAnimationEntro);
      }
      else if (result[messageContent]['msg'] == 'SHB') {
        if (result[messageContent][ownerId].toString() != widget.room.ownerId.toString()) {
          ShowPopularBanner(result, userBannerData, controllerBanner);
        }
      }
      else if (result[messageContent][message] == showEmojie) {
        showingEmojie(
            userId: result[messageContent][idUser].toString(),
            emojieData: EmojieData(
              emojie: result[messageContent]['emoji'].toString(),
              emojieId: result[messageContent]['id'],
              length: result[messageContent]['t_length'],
            ),
            timeEmojie: result[messageContent]['t_length']);
      }
      else if (result[messageContent][message] == showGifts) {
        ShowGifts(result, widget.myDataModel.id.toString(), loadMp4Gift, loadAnimationGift);
      }
      else if (result[messageContent][message] == kicKoutKey) {
        KicKout(result, durationKickout, widget.room.ownerId.toString(), widget.myDataModel.id.toString(), context);

      }//PK start rtm
      else if (result[messageContent][message] == PkController.show_pk) {
        Showpk();
      }
      else if (result[messageContent][message] == PkController.start_pk) {
        Startpk(result, widget.room.ownerId.toString(), context);
      }
      else if (result[messageContent][message] == PkController.hide_pk) {
        Hidepk();
      }
      else if (result[messageContent][message] == PkController.update_pk) {
        Updatepk(result);
      }
      else if (result[messageContent][message] == PkController.close_pk) {
        ClosePkKey(result);
      }
      //PK end rtm
      else if (result[messageContent][message] == leaveMicKey) {
        RoomScreen.userOnMics.value.removeWhere((key, value) => key == result[messageContent]['position']);
      }
      else if (result[messageContent][message] == upMicKey) {
        UpMicKey(result);
      }
      else if (result[messageContent][message] == muteMicKey) {
        MuteMicKey(result);
      }
      else if (result[messageContent][message] == unMuteMicKey) {
        UnMuteMicKey(result);
      }
      else if (result[messageContent][message] == lockMicKey) {
        LockMicKey(result);
      }
      else if (result[messageContent][message] == unLockMicKey) {
        UnLockMicKey(result);
      }
      else if (result[messageContent][message] == topUserKey) {
        if (RoomScreen.topUserInRoom.value.id == null || result[messageContent]['id'] != RoomScreen.topUserInRoom.value.id.toString()) {
          TopUserKey(result);
        }
      }
      else if (result[messageContent][message] == roomModeKey) {
        if (result[messageContent]['mode'] == 'topCenter') {
          widget.room.mode = 0 ;

          setState(() {
           RoomScreen.layoutMode = LayoutMode.hostTopCenter;
            RoomScreen.userOnMics.value.clear();
          });
        } else if (result[messageContent]['mode'] == 'party') {
          widget.room.mode = 1 ;

          setState(() {
            RoomScreen.layoutMode = LayoutMode.party;
            RoomScreen.userOnMics.value.clear();
          });
        } else if (result[messageContent]['mode'] == 'seats12') {
          widget.room.mode = 2 ;

          setState(() {
            RoomScreen.layoutMode = LayoutMode.seats12;
            RoomScreen.userOnMics.value.clear();
          });
        }
      }
      else if (result[messageContent][message] == updateAdminsKey) {
        RoomScreen.adminsInRoom.clear();
        List<String> admins =
            List<String>.from(result[messageContent]['admins'].map((x) => x));
        log(admins.toString());

        for (var element in admins) {
          RoomScreen.adminsInRoom.putIfAbsent(element, () => element);
        }

        setState(() {});
      }
      else if (result[messageContent][message] == removeChatKey) {
        RoomScreen.clearTimeNotifier.value = DateTime.now().millisecondsSinceEpoch;
        MessagesChached.usersMessagesRoom.clear();
      }
      else if (result[messageContent][message] == showLuckyBoxKey) {
        show_lucky_box(result);
      }
      else if (result[messageContent][message] == hideLuckyBoxKey) {
        hide_lucky_box(result);
      }
      else if (result[messageContent][message] == LuckyBoxVariables.bannerSuperBoxKey) {
        BannerSuperBoxKey(result, superBox, LuckyBoxVariables.sendSuperBox);
      }
      else if (result[messageContent]['msg'] == showPobUpKey) {


        ShowPobUpKey(result,popUpData, showPopUp ) ;


      }
      else if (result[messageContent][message] == banFromWritingKey) {
        BanFromWritingKey(result, widget.myDataModel.id.toString(), widget.room.ownerId.toString(), context);
      }
      else if (result[messageContent][message] == unbanFromWritingKey) {
        UnbanFromWritingKey(result, widget.myDataModel.id.toString());
      }
      else if (result[messageContent][message] == 'banDevice') {
        if (result[messageContent]['userId'] == widget.myDataModel.id) {
          await Methods().exitFromRoom(widget.room.ownerId.toString(), context);
          Navigator.pushNamedAndRemoveUntil(context, Routes.login, (route) => false);
        }
      }
      else if (result[messageContent][message] == muteUserKey) {
        MuteUserKey(result);
      }
      else if (result[messageContent][message] == inviteToSeatKey) {
        InviteToSeatKey(result, widget.myDataModel.id.toString(), widget.room.ownerId.toString(), context);
      }
      else if (result[messageContent]['msg'] == 'LBR' && result[messageContent]['uid'] == widget.myDataModel.id) {
        BickFromLuckyBox(result, context);
      }
      else if (result[messageContent]['msg'] == showYallowBanner) {
        showYallowBannerAnimation(
          senderId: result[messageContent]['uId'],
          message: result[messageContent]['umsg'],
          hasPasswoedRoom: result[messageContent]['ps'],
          ownerId: result[messageContent]['oid'],
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: ZegoUIKitPrebuiltLiveAudioRoom(
          appID: appID,
          appSign: appSign,
          userID: widget.myDataModel.id.toString(),
          roomData: widget.room,
          userName: widget.myDataModel.name ?? widget.myDataModel.id.toString(),
          roomID: widget.room.id.toString(),
          config: (widget.isHost
              ? ZegoUIKitPrebuiltLiveAudioRoomConfig.host()
              : ZegoUIKitPrebuiltLiveAudioRoomConfig.audience())
            ..onLeaveConfirmation = (context) async {
              return true;
            }
            ..userInRoomAttributes = {
              'img': widget.myDataModel.profile?.image ?? "",
              'vip': widget.myDataModel.vip1?.level.toString() ?? "",
              'sen': widget.myDataModel.level?.senderImage ?? "",
              'rec': widget.myDataModel.level?.receiverImage ?? "",
              'bubl': widget.myDataModel.bubble ?? "",
              'frm': widget.myDataModel.frameId?.toString() ?? "0",
              'f2': widget.myDataModel.frame.toString()
            }
            ..seatConfig.showSoundWaveInAudioMode = true
            ..layoutConfig.rowSpacing = 0
            ..layoutConfig.rowConfigs = rowRoomSeats(RoomScreen.layoutMode)
            ..layoutConfig.rowSpacing = 10
            ..takeSeatIndexWhenJoining = widget.isHost
                ? getHostSeatIndex(
                    layoutMode:RoomScreen.layoutMode,
                    ownerId: widget.room.ownerId.toString())
                : -1
            ..hostSeatIndexes = [0]
            ..seatConfig = getSeatConfig()
            ..viewbackground = ViewbackgroundWidget(room: widget.room,
                roomDataUpdates: roomDataUpdates,
                userBannerData: userBannerData,
                superBox: superBox,
                layoutMode: RoomScreen.layoutMode,
                controllerMusice: controllerMusice,
                animationControllerEntro: animationControllerEntro,
                animationControllerGift: animationControllerGift,
                yallowBanner: yallowBanner,
                showYellowBanner: showYellowBanner,
                userIntroData: userIntroData,
                offsetAnimationEntro: offsetAnimationEntro,
                yellowBannercontroller: yellowBannercontroller,
                offsetAnimationYellowBanner: offsetAnimationYellowBanner,
                yallowBannerSender: yallowBannerSender,
                isPlural: isPlural,
                controllerBanner: controllerBanner,
                offsetAnimationBanner: offsetAnimationBanner,
                luckGiftBannderController: luckGiftBannderController,
                offsetLuckGiftAnimationBanner: offsetLuckGiftAnimationBanner,
                showPopUp: showPopUp,
                popUpData: popUpData,
                durationKickout: durationKickout)

            ..background = BackgroundWidget(room: widget.room,
                layoutMode:RoomScreen.layoutMode, isHost: widget.isHost)
            ..onSeatsChanged = (
              Map<int, ZegoUIKitUser> takenSeats,
              List<int> untakenSeats,
            ) {
          GiftUser.userOnMicsForGifts.clear();

          takenSeats.forEach((key, value) {
            if(value.id!='') {
              GiftUser.userOnMicsForGifts.putIfAbsent(int.parse(value.id),
                    () => value);
            }
          });
         GiftUser.updateView.value =
             GiftUser.updateView.value +1 ;
            }
            ..bottomMenuBarConfig = ZegoBottomMenuBarConfig(
              maxCount: 10,
              hostButtons: [
                ZegoMenuBarButtonName.toggleMicrophoneButton,
                //  ZegoMenuBarButtonName.soundEffectButton,
              ],
              hostExtendButtons: [

                const SpeakerButton(),
                GiftButton(
                  listAllUsers: ZegoUIKit().getAllUsers(),
                  roomData: widget.room,
                  myDataModel: widget.myDataModel,
                ),
                MassageButton(myDataModel: widget.myDataModel),
                EmoijeButton(
                  userId: widget.myDataModel.id.toString(),
                  roomId: widget.room.id.toString(),
                ),
                BasicToolButton(
                  myDataModel: widget.myDataModel,
                  roomId: widget.room.id.toString(),
                  layoutMode:RoomScreen.layoutMode,
                  ownerId: widget.room.ownerId.toString(),
                  isOnMic: true,
                  roomData: widget.room,
                ),
              ],
              audienceButtons: [],
              audienceExtendButtons: [
                const SpeakerButton(),
                GiftButton(
                    listAllUsers: ZegoUIKit().getAllUsers(),
                    myDataModel: widget.myDataModel,
                    roomData: widget.room),
                MassageButton(myDataModel: widget.myDataModel),
                BasicToolButton(
                  myDataModel: widget.myDataModel,
                  roomId: widget.room.id.toString(),
                  layoutMode: LayoutMode.party,
                  ownerId: widget.room.ownerId.toString(),
                  isOnMic: false,
                  roomData: widget.room,
                ),
              ],
              speakerButtons: [
                ZegoMenuBarButtonName.toggleMicrophoneButton,
                //  ZegoMenuBarButtonName.soundEffectButton,
              ],
              speakerExtendButtons: [
                const SpeakerButton(),
                GiftButton(
                    listAllUsers: ZegoUIKit().getAllUsers(),
                    myDataModel: widget.myDataModel,
                    roomData: widget.room),
                MassageButton(myDataModel: widget.myDataModel),
                EmoijeButton(
                  userId: widget.myDataModel.id.toString(),
                  roomId: widget.room.id.toString(),
                ),
                BasicToolButton(
                  myDataModel: widget.myDataModel,
                  roomId: widget.room.id.toString(),
                  layoutMode:RoomScreen.layoutMode,
                  ownerId: widget.room.ownerId.toString(),
                  isOnMic: true,
                  roomData: widget.room,
                ),
              ],
            )
            ..seatConfig.avatarBuilder = (context, size, user, extraInfo) {
            return ValueListenableBuilder<bool>(
                valueListenable: ZegoUIKit().getMicrophoneStateNotifier(user!.id),
                builder: (context, isMicrophoneEnabled, _) {
                  return UserAvatar(
                      user: user ,
                      image: user.inRoomAttributes.value['img'],
                      isMicrophoneEnabled: isMicrophoneEnabled);
                },
              );
            }
            ..inRoomMessageConfig.itemBuilder = (context, message, extraInfo) {
              return ValueListenableBuilder(
                  valueListenable: RoomScreen.clearTimeNotifier,
                  builder: (BuildContext context, dynamic value, Widget? child) {
                    if (message.timestamp < value) {
                      return const SizedBox.shrink();
                    }
                    if (message.user.inRoomAttributes.value['sen'] == null && MessagesChached.usersMessagesRoom[message.user.id]?.senderLevelImg == null) {
                      if (kDebugMode) {
                        log("wait 2 sec to load more in formation about user");
                      }
                      BlocProvider.of<GetUsersInRoomBloc>(context).add(GetUsersInRoomEvents(userId: message.user.id));
                    }

                    return BlocConsumer<GetUsersInRoomBloc,UsersInRoomState>(
                      builder: (BuildContext context, UsersInRoomState state) {
                          return MessagesChached(
                              message: message,
                              myDataModel: widget.myDataModel,
                              room: widget.room,
                              vip: message.user.inRoomAttributes.value['vip'] ?? "",
                              bubble: message.user.inRoomAttributes.value['bubl'] ?? "",
                              frame: message.user.inRoomAttributes.value['frm'] ?? "",
                              sender: message.user.inRoomAttributes.value['sen'] ?? "",
                              receiver: message.user.inRoomAttributes.value['rec'] ?? "",
                              layoutMode:RoomScreen.layoutMode);
                      },
                      listener: (BuildContext context, UsersInRoomState state) {
                      if (state is GetUsersInRoomSucssesState){
                        MessagesChached.usersMessagesRoom.removeWhere((key, value) => key == state.data![0].id.toString());
                        MessagesChached.usersMessagesRoom.putIfAbsent(state.data![0].id.toString(), () => state.data![0]);
                      }
                    },
                    );
                  });
            },
        ));
  }

  ZegoLiveAudioRoomSeatConfig getSeatConfig() {
    if (RoomScreen.layoutMode == LayoutMode.hostTopCenter) {

      return ZegoLiveAudioRoomSeatConfig(
        foregroundBuilder: (context, size, user, extraInfo) {

          if (user?.id == '' && PkController.showPK.value) {
            if (PkController.teamRed.contains(extraInfo['index'])) {
              return const  TeamRed();
            }
            else if (PkController.teamBlue.contains(extraInfo['index'])) {
              return const  TeamBlue();
            }
            else {
              return Container();
            }
          }
          else if (user?.id == '' && !PkController.showPK.value) {
            return
              NoneUserOnSeat(
              extraInfo: extraInfo,
            );
          }
          else {
            return UserForgroundCach(user: user);
          }
        },
        // avatarBuilder: avatarBuilder,
        backgroundBuilder: (BuildContext context, Size size,
            ZegoUIKitUser? user, Map extraInfo) {
          return Container();
        },
      );
    } else if (RoomScreen.layoutMode == LayoutMode.party) {
      return ZegoLiveAudioRoomSeatConfig(
        foregroundBuilder: (context, size, user, extraInfo) {
          if (user?.id == '') {
            return NoneUserOnSeatParty(extraInfo: extraInfo);
          } else {
            return UserForgroundCachParty(user: user);
          }
        },
        //   avatarBuilder: avatarBuilder,
        backgroundBuilder: (BuildContext context, Size size,
            ZegoUIKitUser? user, Map extraInfo) {
          return Container();
        },
      );
    }
    else if (RoomScreen.layoutMode == LayoutMode.seats12) {
      return ZegoLiveAudioRoomSeatConfig(
        foregroundBuilder: (context, size, user, extraInfo) {
          if (user?.id == '') {
            return NoneUserOnSeatMidParty(extraInfo: extraInfo);
          } else {
            return UserForgroundCachMidParty(user: user);
          }
        },
        //   avatarBuilder: avatarBuilder,
        backgroundBuilder: (BuildContext context, Size size,
            ZegoUIKitUser? user, Map extraInfo) {
          return Container();
        },
      );
    }

    return ZegoLiveAudioRoomSeatConfig(
        //  avatarBuilder: avatarBuilder,
        );
  }
}

List<ZegoLiveAudioRoomLayoutRowConfig> rowRoomSeats(LayoutMode layoutMode) {
  switch (layoutMode) {
    case LayoutMode.hostTopCenter:
      return [
        ZegoLiveAudioRoomLayoutRowConfig(
            count: 1,
            seatSpacing: 10,
            alignment: ZegoLiveAudioRoomLayoutAlignment.center),
        ZegoLiveAudioRoomLayoutRowConfig(
            count: 4,
            seatSpacing: 10,
            alignment: ZegoLiveAudioRoomLayoutAlignment.spaceAround),
        ZegoLiveAudioRoomLayoutRowConfig(
            count: 4,
            seatSpacing: 10,
            alignment: ZegoLiveAudioRoomLayoutAlignment.spaceAround),
        ZegoLiveAudioRoomLayoutRowConfig()
      ];

    case LayoutMode.party:
      return [
        ZegoLiveAudioRoomLayoutRowConfig(
            count: 4,
            seatSpacing: 10,
            alignment: ZegoLiveAudioRoomLayoutAlignment.spaceAround),
        ZegoLiveAudioRoomLayoutRowConfig(
            count: 4,
            seatSpacing: 10,
            alignment: ZegoLiveAudioRoomLayoutAlignment.spaceAround),
        ZegoLiveAudioRoomLayoutRowConfig(
            count: 4,
            seatSpacing: 10,
            alignment: ZegoLiveAudioRoomLayoutAlignment.spaceAround),
        ZegoLiveAudioRoomLayoutRowConfig(
            count: 4,
            seatSpacing: 10,
            alignment: ZegoLiveAudioRoomLayoutAlignment.spaceAround)
      ];

    case LayoutMode.seats12:
      return [
        ZegoLiveAudioRoomLayoutRowConfig(
            count: 4,
            seatSpacing: 10,
            alignment: ZegoLiveAudioRoomLayoutAlignment.spaceAround),
        ZegoLiveAudioRoomLayoutRowConfig(
            count: 4,
            seatSpacing: 10,
            alignment: ZegoLiveAudioRoomLayoutAlignment.spaceAround),
        ZegoLiveAudioRoomLayoutRowConfig(
            count: 4,
            seatSpacing: 10,
            alignment: ZegoLiveAudioRoomLayoutAlignment.spaceAround),
        ZegoLiveAudioRoomLayoutRowConfig()
      ];
  }
}
