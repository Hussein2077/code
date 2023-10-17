// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:svgaplayer_flutter/player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/room_user_messages_model.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/profile/data/data_sorce/remotly_data_source_profile.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/user_on_mic_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/basic_tool_button.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/emojie/emojie_button.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/gifts/gift_button.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/massage_Button.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/speakr_button.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/heaser_room/header_room.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/lucky_box/lucky_box_controller.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/lucky_box/widgets/dialog_lucky_box.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pageView_games/pageview_games.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/Conter_Time_pk_Widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/pk_functions.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/pk_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/view_music/music_list.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/background%20widgets/host_top_center_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/background%20widgets/room_background.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/dialog_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/kick_out_user_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/lucky_gift_win_circle.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/messages_chached.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/seatconfig%20widgets/none_user_on_seat.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/seatconfig%20widgets/none_user_on_seat_mid_party.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/seatconfig%20widgets/none_user_on_seat_party.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/team_blue.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/team_red.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/seatconfig%20widgets/user_forground_cach.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/seatconfig%20widgets/user_forground_cach_mid_party.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/seatconfig%20widgets/user_forground_cach_party.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/show_entro_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/user_avatar.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/lucky_box/widgets/lucky_box.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/viewbackground%20widgets/music_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/viewbackground%20widgets/pop_up_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/viewbackground%20widgets/show_yallow_banner_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_states.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/send_gift_manger/send_gift_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/send_gift_manger/send_gift_states.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/room_screen_controler.dart';
import 'package:tik_chat_v2/main_screen/main_screen.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/components/audio_video/defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/live_audio_room.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/live_audio_room_config.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/live_audio_room_defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/components/message/in_room_message_input.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/defines/command.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/defines/user_defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_uikit/src/services/uikit_service.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';
import 'components/widgets/show_gift_banner_widget.dart';
import 'components/widgets/show_lucky_banner_widget.dart';

class RoomScreen extends StatefulWidget {
  final EnterRoomModel room;
  final MyDataModel myDataModel;
  final bool isHost;
  static bool isGiftEntroAnimating = false;
  static bool isShowingBanner = false;
  static bool isInviteToMic = false;
  static bool roomIsLoked = false;
  static late bool outRoom;
  static List<GiftData> listOfAnimatingGifts = [];
  static List<GiftData> listOfAnimatingMp4Gifts = [];
  static List<EntroData> listOfAnimatingEntros = [];
  static List<String> listOfAnimatingBanner = [];
  static List<MusicObject> musicesInRoom = [];
  static List<int> teamBlue = [1, 2, 5, 6];
  static List<int> teamRed = [3, 4, 7, 8];
  static List<String> usersHasMute = [];
  static Map<int, int> listOfMuteSeats = {};
  static ValueNotifier<Map<String, EmojieData>> listOfEmojie = ValueNotifier({});
  static ValueNotifier<int> updateEmojie = ValueNotifier(0);
  static Map<String, String> adminsInRoom = {};
  static Map<String, String> banedUsers = {};
  static Map<String, UserDataModel> usersMessagesInRoom = {};
  static Map<String, RoomUserMesseagesModel> usersMessagesRoom = {};
  static Map<String, UserDataModel> usersInRoom = {};
  static ValueNotifier<int> clearTimeNotifier = ValueNotifier(0);
  static ValueNotifier<bool> showMessageButton = ValueNotifier<bool>(true);
  static ValueNotifier<bool> banFromWriteIcon = ValueNotifier<bool>(true);
  static ValueNotifier<Map<int, ZegoUIKitUser>> userOnMics = ValueNotifier<Map<int, ZegoUIKitUser>>({});
  static ValueNotifier<UserDataModel> topUserInRoom = ValueNotifier<UserDataModel>(UserDataModel());
  static ValueNotifier<bool> showBanner = ValueNotifier<bool>(false);
  static ValueNotifier<String> myCoins = ValueNotifier<String>('');
  static ValueNotifier<bool> showEntro = ValueNotifier<bool>(false);
  static ValueNotifier<String> roomGiftsPrice = ValueNotifier<String>("");
  static ValueNotifier<bool> isKick = ValueNotifier<bool>(false);
  static ValueNotifier<Map<int, int>> listOfLoskSeats = ValueNotifier<Map<int, int>>({0: 0});
  static ValueNotifier<int> editRoom = ValueNotifier<int>(0);
  static ValueNotifier<int> editAudioVideoContainer = ValueNotifier<int>(0);
  static ValueNotifier<int> updateMessgasList = ValueNotifier<int>(0);
  static ValueNotifier<int> updatebuttomBar = ValueNotifier<int>(0);
  static ValueNotifier<String> imgbackground = ValueNotifier<String>("");
  static List<YallowBannerData> listofAnimationYallowBanner = [];
  static ValueNotifier<bool> isVideoVisible = ValueNotifier<bool>(false);
  static ValueNotifier<int> winCircularluckyGift = ValueNotifier<int>(0);

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
  VideoPlayerController? mp4Controller;
  late LayoutMode layoutMode;
  StreamController<List<ZegoUIKitUser>> userInRoomController = StreamController.broadcast();
  ValueNotifier<bool> showPopUp = ValueNotifier(false);
  String userIdEmojie = ""; // to show emojie
  bool showGift = false; // to show gift
  String giftImg = ""; // to show img gift


 ///////
  Map<String,String>   roomDataUpdates =
  {'room_intro': '','room_name':'',
    'room_img':'', 'room_type':''};
  /////

  String roomBackgroundChached = "";

 //////
  Map<String,String> userIntroData = {'user_name_intro':'','user_image_intro':'' };
 /////

  //////
  Map<String,dynamic> userBannerData =
  { 'gift_banner':'',
    'owner_id_room_banner':'',
    'is_password_room_banner':''
  };
  UserDataModel? sendDataUser;
  UserDataModel? receiverDataUser;
  //////

  //////
  Map<String, dynamic> durationKickout = {"durationKickout": ""};
  /////

  ////
  Map<String, dynamic> yallowBanner = {"yallowBannerhasPasswoedRoom": '' , "yallowBannerOwnerRoom" : ''};
  ////

  ////
  Map<String, dynamic> superBox = {"isPasswordRoomLuckyBanner": false, "superCoins" : '', "ownerIdRoomLuckyBanner": ''};
  ////


  bool isPlural = false;
  String numberOfGift = "0";
  UserDataModel? pobUpSender;
  late AnimationController yellowBannercontroller;
  late Animation<Offset> offsetAnimationYellowBanner;
  UserDataModel? yallowBannerSender;
  bool showYellowBanner = false;
  showOverlay(Widget widget) {
    OverlayState overlayState = Overlay.of(context);
    overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Padding(
          padding: EdgeInsets.all(ConfigSize.defaultSize! * 1.5),
          child: widget),
    );

    overlayState.insert(overlayEntry);

    //to remove overlay after a certain time, use:
    Future.delayed(const Duration(seconds: 2)).then((value) {
      overlayEntry.remove();
    });
  }

  @override
  void initState() {
    super.initState();

    userInRoomController.stream.listen((zegoList) {});

    RoomScreen.usersMessagesRoom.putIfAbsent(
        widget.myDataModel.id.toString(),
        () => RoomUserMesseagesModel(
              bubble: widget.myDataModel.bubble ?? "",
              bubbleId: widget.myDataModel.bubbleId ?? 0,
              hasColorName: widget.myDataModel.hasColorName ?? false,
              id: widget.myDataModel.id!,
              image: widget.myDataModel.profile!.image!,
              name: widget.myDataModel.name!,
              revicerLevelImg: widget.myDataModel.level?.receiverImage??'',
              senderLevelImg: widget.myDataModel.level?.senderImage??'',
              uuid: widget.myDataModel.uuid!,
              vipLevel: widget.myDataModel.vip1?.level??0,
            ));

    RoomScreen.isGiftEntroAnimating = false;
    if (widget.room.mode == 1) {
      layoutMode = LayoutMode.party;
    } else if (widget.room.mode == 0) {
      layoutMode = LayoutMode.hostTopCenter;
    } else if (widget.room.mode == 2) {
      layoutMode = LayoutMode.seats12;
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
      RoomScreen.roomIsLoked = widget.room.roomPassStatus!;

      if (widget.myDataModel.intro! != "") {
        loadAnimationEntro(widget.myDataModel.introId?.toString() ?? "",
            widget.myDataModel.intro!);
        if (widget.myDataModel.vip1?.id != null) {
          RoomScreen.showEntro.value = true;
        }
        userIntroData['user_name_intro']  = widget.myDataModel.name!;
        userIntroData['user_image_intro'] = widget.myDataModel.profile!.image!;
      }
      if (widget.room.showPk == 1) {
        PkController.showPK.value = true;
      }

      RoomScreen.listOfLoskSeats.value.putIfAbsent(0, () => 0); //host place
      for (int i = 0; i < widget.room.seats!.length; i++) {
        if (widget.room.seats![i] == "locked") {
          RoomScreen.listOfLoskSeats.value.putIfAbsent(i, () => i);
        } else if (widget.room.seats![i] == "muted") {
          RoomScreen.listOfMuteSeats.putIfAbsent(i, () => i);
        } else if (widget.room.seats![i] == "empty") {
        } else if (widget.room.seats![i]['id'] != null) {
          UserOnMicModel myDataModel = UserOnMicModel.fromJson(widget.room.seats![i]);
          ZegoUIKitUser zegoUIKitUser = ZegoUIKitUser(id: myDataModel.id.toString(), name: myDataModel.name.toString());
          zegoUIKitUser.inRoomAttributes.value['uu'] = 'moooo';
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
      if (widget.room.topUser!.id != null) {
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
        ZegoUIKit().sendInRoomMessage("انضم للغرفة", false);

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
    userInRoomController.close();
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

    super.dispose();
  }

  activePK() {
    PkController.isPK.value
        ? PkController.isPK.value = false
        : PkController.isPK.value = true;
  }

  //todo you should remove this function
  refrashRoom() {
    setState(() {});
  }

  //todo you shoulde remove setState here
  destroyMusic() {
    setState(() {
      distroyMusic();
    });
  }

  Future<void> loadMp4Gift({required GiftData giftData}) async {
    RoomScreen.isGiftEntroAnimating = true;
    if (giftData.showBanner) {
      sendDataUser = giftData.senderData;
      receiverDataUser = giftData.reciverData;
      userBannerData ['gift_banner']   = giftData.giftBanner;
      giftImg = giftData.giftImg;
      RoomScreen.showBanner.value = giftData.showBanner;
      isPlural = giftData.isPlural;
      numberOfGift = giftData.numberOfGift;
      RoomScreen.roomGiftsPrice.value = giftData.roomGiftsPrice;
    } else {
      RoomScreen.roomGiftsPrice.value = giftData.roomGiftsPrice;
    }

    if (giftData.localPath == null) {
      await Methods()
          .cacheMp4(
              vedioId: int.parse(giftData.giftId), vedioUrl: giftData.giftImg)
          .then((value) async {
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String rootPath = appDocDir.path;
        String path = "$rootPath/${giftData.giftId}.mp4";
        mp4Controller = VideoPlayerController.file(File(path))..initialize();
      });
    } else {
      mp4Controller = VideoPlayerController.file(File(giftData.localPath!))
        ..initialize();
    }

    mp4Controller!.addListener(() {
      if (mp4Controller!.value.position >= mp4Controller!.value.duration) {
        if (giftData.showBanner && RoomScreen.showBanner.value) {
          RoomScreen.showBanner.value = false;
          controllerBanner.reverse();
        }

        RoomScreen.isVideoVisible.value = false;

        mp4Controller!.pause();
        RoomScreen.isGiftEntroAnimating = false;
        loadMoreAnimationMp4Gifts();

        // mp4Controller!.dispose();
      } else {
        RoomScreen.isVideoVisible.value = true;
        mp4Controller!.play();
      }
    });
  }

  Future<void> loadAnimationGift(GiftData giftData) async {
    RoomScreen.isGiftEntroAnimating = true;
    if (giftData.showBanner) {
      sendDataUser = giftData.senderData;
      receiverDataUser = giftData.reciverData;
       userBannerData['gift_banner'] = giftData.giftBanner;
      giftImg = giftData.giftImg;
      controllerBanner.forward();
      isPlural = giftData.isPlural;
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
      showYellowBanner = true;
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
    //log('commandData.command'+commandData.command);
    if (result[messageContent] != null) {
      if (result[messageContent][message] == changeBackground) {
        ChangeBackground(result,roomDataUpdates);
      }
      else if (result[messageContent][message] == userEntro) {
        if (result[messageContent]['uid'] != widget.myDataModel.id) {
          UserEntro(result,  userIntroData ,loadAnimationEntro);
        }
      }
      else if (result[messageContent]['msg'] == 'SHB') {
        if (result[messageContent][ownerId].toString() != widget.room.ownerId.toString()) {
          ShowPopularBanner(result, sendDataUser, receiverDataUser, userBannerData, controllerBanner);
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

      }
      //PK start rtm
      else if (result[messageContent][message] == showPkKey) {
        ShowPkKey();
      }
      else if (result[messageContent][message] == startPkKey) {
        StartPkKey(result, widget.room.ownerId.toString(), context);
      }
      else if (result[messageContent][message] == hidePkKey) {
        HidePkKey();
      }
      else if (result[messageContent][message] == updatePkKey) {
        UpdatePkKey(result);
      }
      else if (result[messageContent][message] == closePkKey) {
        ClosePkKey(result);
      }
      //PK end rtm
      else if (result[messageContent][message] == leaveMicKey) {
        RoomScreen.userOnMics.value.remove(result[messageContent]['position']);
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
          setState(() {
            layoutMode = LayoutMode.hostTopCenter;
            RoomScreen.userOnMics.value.clear();
          });
        } else if (result[messageContent]['mode'] == 'party') {
          setState(() {
            layoutMode = LayoutMode.party;
            RoomScreen.userOnMics.value.clear();
          });
        } else if (result[messageContent]['mode'] == 'seats12') {
          setState(() {
            layoutMode = LayoutMode.seats12;
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
        ShowPobUpKey(result, pobUpSender, showPopUp);
      }
      else if (result[messageContent][message] == banFromWritingKey) {
        BanFromWritingKey(result, widget.myDataModel.id.toString(), widget.room.ownerId.toString(), context);
      }
      else if (result[messageContent][message] == unbanFromWritingKey) {
        UnbanFromWritingKey(result, widget.myDataModel.id.toString());
      }
      else if (result[messageContent][message] == 'banDevice') {
        if (result[messageContent]['userId'] == widget.myDataModel.id) {
          await Methods().exitFromRoom(widget.room.ownerId.toString());
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
          myDataModel: widget.myDataModel,
          roomData: widget.room,
          roomMode: layoutMode,
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
            ..layoutConfig.rowConfigs = rowRoomSeats(layoutMode)
            ..layoutConfig.rowSpacing = 10
            ..takeSeatIndexWhenJoining = widget.isHost
                ? getHostSeatIndex(
                    layoutMode: layoutMode,
                    ownerId: widget.room.ownerId.toString())
                : -1
            ..hostSeatIndexes = [0]
            ..seatConfig = getSeatConfig()
            ..viewbackground = viewbackground()
            ..background = background()
            ..onSeatsChanged = (
              Map<int, ZegoUIKitUser> takenSeats,
              List<int> untakenSeats,
            ) {
              RoomScreen.userOnMics.value = {...takenSeats};

              // to handle any use on mic should server know
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
                  listUsers: ZegoUIKit().getAudioVideoList(),
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
                  notifyRoom: activePK,
                  layoutMode: layoutMode,
                  ownerId: widget.room.ownerId.toString(),
                  isOnMic: true,
                  roomData: widget.room,
                ),
              ],
              audienceButtons: [],
              audienceExtendButtons: [
                const SpeakerButton(),
                GiftButton(
                    listUsers: ZegoUIKit().getAudioVideoList(),
                    listAllUsers: ZegoUIKit().getAllUsers(),
                    myDataModel: widget.myDataModel,
                    roomData: widget.room),
                MassageButton(myDataModel: widget.myDataModel),
                BasicToolButton(
                  myDataModel: widget.myDataModel,
                  roomId: widget.room.id.toString(),
                  notifyRoom: activePK,
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
                    listUsers: ZegoUIKit().getAudioVideoList(),
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
                  notifyRoom: activePK,
                  layoutMode: layoutMode,
                  ownerId: widget.room.ownerId.toString(),
                  isOnMic: true,
                  roomData: widget.room,
                ),
              ],
            )
            ..seatConfig.avatarBuilder = (context, size, user, extraInfo) {
              // if (RoomScreen.usersInRoom[user?.id] == null) {
              //   getUserDataInRoom(user!.id);
              // }
              return ValueListenableBuilder<bool>(
                valueListenable:
                    ZegoUIKit().getMicrophoneStateNotifier(user!.id),
                builder: (context, isMicrophoneEnabled, _) {
                  return UserAvatar(
                      image: user.inRoomAttributes.value['img'].toString(),
                      isMicrophoneEnabled: isMicrophoneEnabled);
                },
              );
            }
            ..inRoomMessageViewConfig.itemBuilder =
                (context, message, extraInfo) {
              return ValueListenableBuilder(
                  valueListenable: RoomScreen.clearTimeNotifier,
                  builder:
                      (BuildContext context, dynamic value, Widget? child) {
                    if (message.timestamp < value) {
                      return const SizedBox.shrink();
                    }
                  
                    if (message.user.inRoomAttributes.value['sen'] == null &&
                        RoomScreen.usersMessagesRoom[message.user.id]
                                ?.senderLevelImg ==
                            null) {
                      Future.delayed(const Duration(seconds: 3), () {
                        if (kDebugMode) {
                          log("wait 2 sec to load more in formation about user");
                        }
                        RoomScreen.updateMessgasList.value =
                            RoomScreen.updateMessgasList.value + 1;
                      });
                    }
                    return ValueListenableBuilder(
                        valueListenable: RoomScreen.updateMessgasList,
                        builder: (context, update, _) {
                          return MessagesChached(
                              message: message,
                              myDataModel: widget.myDataModel,
                              room: widget.room,
                              vip: message.user.inRoomAttributes.value['vip'] ??
                                  "",
                              bubble:
                                  message.user.inRoomAttributes.value['bubl'] ??
                                      "",
                              frame:
                                  message.user.inRoomAttributes.value['frm'] ??
                                      "",
                              sender:
                                  message.user.inRoomAttributes.value['sen'] ??
                                      "",
                              receiver:
                                  message.user.inRoomAttributes.value['rec'] ??
                                      "",
                              layoutMode: layoutMode);
                        });
                  });
            },
        ));
  }

  Widget background() {
    return BlocConsumer<OnRoomBloc, OnRoomStates>(
      builder: (_, state) {
        return Stack(
          children: [
            RoomBackground( room: widget.room,),
            if (layoutMode == LayoutMode.hostTopCenter)
              ValueListenableBuilder<UserDataModel>(
                  valueListenable: RoomScreen.topUserInRoom,
                  builder: (context, topUser, _) {
                    return HostTopCenterWidget(
                      layoutMode: layoutMode, topUser: topUser,room:  widget.room,myDataModel:   widget.myDataModel, );
                  }),
            ValueListenableBuilder<bool>(
                valueListenable: PkController.showPK,
                builder: (context, isShowPK, _) {
                  if (isShowPK && layoutMode == LayoutMode.hostTopCenter) {
                    return Padding(
                      padding: EdgeInsets.only(top: AppPadding.p45),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: PKWidget(
                            scoreBlueTeam: PkController.scoreBlue,
                            scoreRedTem: PkController.scoreRed,
                            isHost: widget.isHost,
                            ownerId: widget.room.ownerId.toString(),
                            notifyRoom: activePK,
                          )),
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
          ],
        );
      },
      listener: (_, state) async {
        if (state is UpdateRoomSucsseState) {
          MainScreen.roomData = state.data;
          Navigator.pop(context);
          sucssesToast(
              context: context, title: StringManager.successfulOperation);
        } else if (state is UpdateRoomErrorState) {
          Navigator.pop(context);
          errorToast(context: context, title: state.errorMassage);
        } else if (state is OnRoomLoadingState) {
          bottomDailog(context: context, widget: const DialogLoadingWidget());
        } else if (state is BanUserFromWritingErrorState) {
          Navigator.pop(context);
          errorToast(context: context, title: state.errorMassage);
        } else if (state is BanUserFromWritingLoadingState) {
          bottomDailog(context: context, widget: const DialogLoadingWidget());
        } else if (state is BanUserFromWritingSuccessState) {
          Navigator.pop(context);
          sucssesToast(context: context, title: state.successMassage);
        } else if (state is SendPobUpErrorState) {
          errorToast(context: context, title: state.errorMassage);
        } else if (state is SendPobUpSuccessState) {
          // sucssesToast(context: context, title: state.successMassage) ;
        } else if (state is SendYallowBannerErrorState) {
          errorToast(context: context, title: state.errorMassage);
        }
      },
    );
  }

  Widget viewbackground() {
    return BlocConsumer<SendGiftBloc, SendGiftStates>(
        builder: (context, state) {
      return Stack(children: [
        SizedBox(
          width: ConfigSize.defaultSize! * 92.5,
          height: ConfigSize.defaultSize! * 92.5,
        ),
        Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
                padding: EdgeInsets.only(
                    right: 0, bottom: ConfigSize.defaultSize! * 2),
                child: const PageViewGames())),
        ValueListenableBuilder(
            valueListenable: RoomScreen.editRoom,
            builder: (context, editValue, _) {
              return HeaderRoom(
                userInRoomController: userInRoomController,
                roomName:roomDataUpdates['room_name']??'' ,
                room: widget.room,
                myDataModel: widget.myDataModel,
                introRoom: roomDataUpdates['room_intro']??'' ,
                roomImg:roomDataUpdates['room_img']??'',
                notifyRoom: activePK,
                roomMode: layoutMode == LayoutMode.hostTopCenter
                    ? 0
                    : layoutMode == LayoutMode.party
                        ? 1
                        : 2,
                refreshRoom: refrashRoom,
                roomType:roomDataUpdates['room_type']??''  ,
                layoutMode: layoutMode,
              );
            }),
        ValueListenableBuilder(
            valueListenable: LuckyBoxVariables.updateLuckyBox,
            builder: (context, edit, _) {
              if (LuckyBoxVariables.luckyBoxMap['luckyBoxes'].isNotEmpty) {
                return LuckyBox(
                    luckyBoxRemovecontroller: LuckyBoxVariables.luckyBoxRemovecontroller);
              } else {
                return const SizedBox();
              }
            }),
        MusicWidget(room: widget.room,controllerMusice: controllerMusice, destroyMusic:destroyMusic ,
          refrashRoom:refrashRoom , ),
        Positioned(
            top: ConfigSize.defaultSize! * 35,
            bottom: ConfigSize.defaultSize! * 7,
            right: ConfigSize.defaultSize! * 7,
            left: ConfigSize.defaultSize! * 7,
            child: SVGAImage(animationControllerEntro)),
        Positioned(
            top: ConfigSize.defaultSize! * 18,
            bottom: ConfigSize.defaultSize! * 45,
            right: ConfigSize.defaultSize! * 14,
            child: SVGAImage(PkController.animationControllerRedTeam)),
        Positioned(
            top: ConfigSize.defaultSize! * 18,
            bottom: ConfigSize.defaultSize! * 45,
            left: ConfigSize.defaultSize! * 14,
            child: SVGAImage(
              PkController.animationControllerBlueTeam,
            )),
        Positioned(
            child: SVGAImage(animationControllerGift)),
        IgnorePointer(
          child: ValueListenableBuilder<bool>(
              valueListenable: RoomScreen.isVideoVisible,
              builder: (context, isShow, _) {
                if (isShow) {
                  return AspectRatio(
                    aspectRatio: mp4Controller!.value.aspectRatio,
                    child: VideoPlayer(mp4Controller!),
                  );
                } else {
                  return Container();
                }
              }),
        ),
        Positioned(
            top: ConfigSize.defaultSize! * 35,
            bottom: ConfigSize.defaultSize! * 7,
            right: ConfigSize.defaultSize! * 7,
            left: ConfigSize.defaultSize! * 7,
            child: SVGAImage(animationControllerEntro)),
        ValueListenableBuilder<bool>(
            valueListenable: RoomScreen.showEntro,
            builder: (context, isShow, _) {
              if (isShow) {
                return ShowEntroWidget(userIntroData: userIntroData, offsetAnimationEntro: offsetAnimationEntro);
              } else {
                return const SizedBox();
              }
            }),
        if (showYellowBanner)
          Positioned(
              top: -30,
              left: AppPadding.p30,
              child: ShowYallowBannerWidget(
                  cureentRoomId: widget.room.ownerId!,
                  controllerYallowBanner: yellowBannercontroller,
                  offsetAnimationYallowBanner: offsetAnimationYellowBanner,
                  senderYallowBanner: yallowBannerSender,
                  hasPassword: yallowBanner,
                  myData: widget.myDataModel,
                  ownerId: yallowBanner)),
        ValueListenableBuilder<bool>(
            valueListenable: RoomScreen.showBanner,
            builder: (context, isShow, _) {
              if (isShow) {
                return Positioned(
                    top: ConfigSize.defaultSize! * 7.5,
                    left: AppPadding.p36,
                    child: ShowGiftBannerWidget(
                        isPlural: isPlural,
                        sendDataUser: sendDataUser ??
                            widget.myDataModel.convertToUserObject(),
                        receiverDataUser: receiverDataUser ??
                            widget.myDataModel.convertToUserObject(),
                        giftImage: userBannerData['gift_banner']??'' ,
                        ownerId:userBannerData['owner_id_room_banner']
                             ?? widget.room.ownerId.toString(),
                        controllerBanner: controllerBanner,
                        offsetAnimationBanner: offsetAnimationBanner,
                        isPassword: userBannerData['is_password_room_banner'],
                        roomOwnerId: widget.room.ownerId.toString(),
                        showGift: showGift,
                        roomIntro: widget.room.roomIntro!,
                    ));
              } else {
                return const SizedBox();
              }
            }),
        ValueListenableBuilder(
            valueListenable: LuckyBoxVariables.showBannerLuckyBox,
            builder: (context, showBanner, _) {
              if (showBanner) {
                return Positioned(
                    top: ConfigSize.defaultSize! * 6.95,
                    left: ConfigSize.defaultSize! * 5.78,
                    child: ShowLuckyBannerWidget(
                        sendDataUser: LuckyBoxVariables.sendSuperBox!,
                        superBox: superBox, showBannerLuckyBox: LuckyBoxVariables.showBannerLuckyBox, ownerId: widget.room.ownerId.toString(),));
              } else {
                return const SizedBox();
              }
            }),
        ValueListenableBuilder<bool>(
            valueListenable: showPopUp,
            builder: (context, isShow, _) {
              return AnimatedPositioned(
                duration: const Duration(seconds: 10),
                curve: Curves.linear,
                onEnd: () {
                  showPopUp.value = false;
                },
                top: ConfigSize.defaultSize! * 30,
                left: isShow
                    ? -ConfigSize.defaultSize! * 40
                    : ConfigSize.defaultSize! * 40,
                child: SizedBox(
                    width: ConfigSize.defaultSize! * 40.5,
                    height: ConfigSize.defaultSize! * 40.5,
                    child: PopUpWidget(
                        ownerDataModel: pobUpSender,
                        massage: ZegoInRoomMessageInput.messagePonUp,
                        enterRoomModel: widget.room,
                        vip: pobUpSender?.vip1?.level ?? 8)),
              );
            }),
        ValueListenableBuilder<bool>(
          valueListenable: RoomScreen.isKick,
          builder: (context, isKicked, _) {
            if (isKicked) {
              return Positioned(
                  bottom: ConfigSize.defaultSize! * 6,
                  left: AppPadding.p30,
                  right: AppPadding.p36,
                  child: KickOutUserWidget(
                    durationKickout: durationKickout,
                    isKick: isKicked,
                  ));
            } else {
              return const SizedBox();
            }
          },
        ),
        IgnorePointer(
          child: ValueListenableBuilder<int>(
              valueListenable: RoomScreen.winCircularluckyGift,
              builder: (context, sohw, _) {
                if (sohw != 0) {
                  Future.delayed(const Duration(seconds: 1)).then((value) {
                    return showOverlay(const Align(
                        alignment: Alignment.topCenter,
                        child: LukyGiftWinCircle()));
                  });
                  return const SizedBox();
                } else {
                  return const SizedBox();
                }
              }),
        ),
      ]);
    }, listener: (context, state) {
      if (state is ErrorSendGiftStates) {
        errorToast(context: context, title: state.errorMessage);
      } else if (state is SuccessSendGiftStates) {
        if (state.successMessage.contains("كسبت")) {
          ZegoUIKit().sendInRoomMessage(state.successMessage, true);
        } else {
          ZegoUIKit().sendInRoomMessage(state.successMessage, false);
        }
      }
    });
  }

  ZegoLiveAudioRoomSeatConfig getSeatConfig() {
    if (layoutMode == LayoutMode.hostTopCenter) {
      return ZegoLiveAudioRoomSeatConfig(
        foregroundBuilder: (context, size, user, extraInfo) {
          if (user?.id == null && PkController.showPK.value) {
            if (RoomScreen.teamRed.contains(extraInfo['index'])) {
              return const  TeamRed();
            } else if (RoomScreen.teamBlue.contains(extraInfo['index'])) {
              return const  TeamBlue();
            } else {
              return Container();
            }
          } else if (user?.id == null && !PkController.showPK.value) {
            return NoneUserOnSeat(
              extraInfo: extraInfo,
            );
          } else {
            return UserForgroundCach(user: user);
          }
        },
        // avatarBuilder: avatarBuilder,
        backgroundBuilder: (BuildContext context, Size size,
            ZegoUIKitUser? user, Map extraInfo) {
          return Container();
        },
      );
    } else if (layoutMode == LayoutMode.party) {
      return ZegoLiveAudioRoomSeatConfig(
        foregroundBuilder: (context, size, user, extraInfo) {
          if (user?.id == null) {
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
    } else if (layoutMode == LayoutMode.seats12) {
      return ZegoLiveAudioRoomSeatConfig(
        foregroundBuilder: (context, size, user, extraInfo) {
          if (user?.id == null) {
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

enum LayoutMode { hostTopCenter, party, seats12 }

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
