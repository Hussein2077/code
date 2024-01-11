// ignore_for_file: must_be_immutable
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vap2/flutter_vap.dart';
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/gifts/widgets/gift_bottom_bar.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/gifts/widgets/gift_users.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/games/collect_coin_animation/collect_coin_animation.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/heaser_room/header_room.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/heaser_room/owner_room/owner_room.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/host_time_counter/host_timer_counter_controller.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/lucky_box/lucky_box_controller.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/lucky_box/widgets/lucky_box.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/lucky_gift/widgets/lucky_candy.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/lucky_gift/widgets/lucky_gift_banner_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/lucky_gift/widgets/lucky_gift_win_circle.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/lucky_gift/widgets/lucky_gift_with_overlay.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/lucky_gift/widgets/show_gift_banner_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/lucky_gift/widgets/show_lucky_banner_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/lucky_gift/widgets/show_yallow_banner_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pageView_games/dialog_games.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pageView_games/pageview_games.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/pk_functions.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/kick_out_user_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/show_entro_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/viewbackground%20widgets/music_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/widgets/viewbackground%20widgets/pop_up_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_lucky_gift_banner/lucky_gift_banner_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_lucky_gift_banner/lucky_gift_banner_state.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/send_gift_manger/send_gift_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/send_gift_manger/send_gift_states.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/send_private_comment_manager/send_private_comment_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/send_private_comment_manager/send_private_comment_states.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/message/message_input.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/uikit_service.dart';
import 'package:video_player/video_player.dart';

class ViewbackgroundWidget extends StatefulWidget {
  EnterRoomModel room;
  Map<String, String> roomDataUpdates;
  Map<String, dynamic> userBannerData;
  Map<String, dynamic> superBox;
  LayoutMode layoutMode;
  AnimationController controllerMusice;
  SVGAAnimationController animationControllerEntro;
  SVGAAnimationController animationControllerGift;
  static VideoPlayerController? mp4Controller;
  Map<String, dynamic> yallowBanner;
  Map<String, bool> showYellowBanner;
  Map<String, String> userIntroData;
  Animation<Offset> offsetAnimationEntro;
  AnimationController yellowBannercontroller;
  Animation<Offset> offsetAnimationYellowBanner;
  UserDataModel? yallowBannerSender;
  Map<String, bool> isPlural;
  AnimationController controllerBanner;
  Animation<Offset> offsetAnimationBanner;
  AnimationController luckGiftBannderController;
  Animation<Offset> offsetLuckGiftAnimationBanner;
  ValueNotifier<bool> showPopUp;
  Map<String, dynamic>? popUpData;
  Map<String, int> durationKickout;

  ViewbackgroundWidget({
    super.key,
    required this.room,
    required this.roomDataUpdates,
    required this.userBannerData,
    required this.superBox,
    required this.layoutMode,
    required this.controllerMusice,
    required this.animationControllerEntro,
    required this.animationControllerGift,
    required this.yallowBanner,
    required this.showYellowBanner,
    required this.userIntroData,
    required this.offsetAnimationEntro,
    required this.yellowBannercontroller,
    required this.offsetAnimationYellowBanner,
    required this.yallowBannerSender,
    required this.isPlural,
    required this.controllerBanner,
    required this.offsetAnimationBanner,
    required this.luckGiftBannderController,
    required this.offsetLuckGiftAnimationBanner,
    required this.showPopUp,
    required this.popUpData,
    required this.durationKickout,
  });

  static ValueNotifier<bool> isKick = ValueNotifier<bool>(false);

  @override
  State<ViewbackgroundWidget> createState() => _ViewbackgroundWidgetState();
}

class _ViewbackgroundWidgetState extends State<ViewbackgroundWidget> {
  bool showGift = false; // to show gift

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
  Widget build(BuildContext context) {
    return BlocListener<SendPrivateCommentBloc, SendPrivateCommentStates>(
      listener: (context, state) {
        if (state is SendPrivateCommentSucssesState) {
          ZegoUIKit.instance.sendInRoomMessage(
              "${StringManager.privateCommentKey}${state.data.data!.toUserId} ${state.data.data!.message}");
          Navigator.pop(context);
        }
      },
      child:
          BlocConsumer<SendGiftBloc, SendGiftStates>(builder: (context, state) {
        return Stack(children: [
          SizedBox(
            width: ConfigSize.defaultSize! * 92.5,
            height: ConfigSize.defaultSize! * 92.5,
            //height: ConfigSize.defaultSize! * 92.5,
          ),

          ValueListenableBuilder<int>(
            valueListenable: GiftUser.updateView,
            builder: (context, price, _) {
              if (GiftUser.userOnMicsForGifts[MyDataModel.getInstance().id] !=
                  null) {
                return Container(
                  padding: const EdgeInsets.all(2),
                  margin: EdgeInsets.only(
                      top: ConfigSize.defaultSize!,
                      left: MediaQuery.of(context).size.width / 2.355),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius:
                        BorderRadius.circular(ConfigSize.defaultSize!),
                  ),
                  child: StreamBuilder<int>(
                    stream: getIt<CounterBloc>().counterStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          Methods.instance
                              .formatSecondsTime(snapshot.data ?? 0),
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w700),
                        );
                      }
                      return Text(Methods.instance
                          .formatSecondsTime(getIt<CounterBloc>().counter));
                    },
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),

            Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                    padding: EdgeInsets.only(
                        right: 0, bottom: ConfigSize.defaultSize! * 2),
                    child: const PageViewGames())),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(bottom: ConfigSize.defaultSize! * 10),
                child: InkWell(
                  onTap: () async {
                    String token = await Methods.instance.returnUserToken();
                    showModalBottomSheet<void>(
                        context: context,
                        isDismissible: false,
                        backgroundColor: Colors.black,
                        isScrollControlled: true, // This is important to make it full screen

                        builder: (BuildContext context) {
                          return SizedBox(

                              child: WebViewInRoom(
                                url: '${StringManager.fruitGame}$token',
                              )
                          );
                        }
                    );
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(AssetsPath.fruitsGame))),
                    width: ConfigSize.defaultSize! * 6,
                    height: ConfigSize.defaultSize! * 6,
                  ),
                ),
              ),
            ),
            ValueListenableBuilder(
                valueListenable: OwnerOfRoom.editRoom,
                builder: (context, editValue, _) {
                  return HeaderRoom(
                    roomName: widget.roomDataUpdates['room_name'] ?? '',
                    room: widget.room,
                    myDataModel: MyDataModel.getInstance(),
                    introRoom: widget.roomDataUpdates['room_intro'] ?? '',
                    roomImg: widget.roomDataUpdates['room_img'] ?? '',
                    roomMode: widget.layoutMode == LayoutMode.hostTopCenter
                        ? 0
                        : widget.layoutMode == LayoutMode.party
                            ? 1
                            : 2,
                    roomType: widget.roomDataUpdates['room_type'] ?? '',
                    layoutMode: widget.layoutMode,
                  );
                }),
            ValueListenableBuilder(
                valueListenable: LuckyBoxVariables.updateLuckyBox,
                builder: (context, edit, _) {
                  if (LuckyBoxVariables.luckyBoxMap['luckyBoxes'].isNotEmpty) {
                    return LuckyBox(
                        luckyBoxRemovecontroller:
                            LuckyBoxVariables.luckyBoxRemovecontroller);
                  } else {
                    return const SizedBox();
                  }
                }),
            MusicWidget(
              room: widget.room,
              controllerMusice: widget.controllerMusice,
            ),
            Positioned(
                top: ConfigSize.defaultSize! * 35,
                bottom: ConfigSize.defaultSize! * 7,
                right: ConfigSize.defaultSize! * 7,
                left: ConfigSize.defaultSize! * 7,
                child: SVGAImage(widget.animationControllerEntro)),
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
            Positioned(child: SVGAImage(widget.animationControllerGift)),
            IgnorePointer(
              child: ValueListenableBuilder<bool>(
                  valueListenable: RoomScreen.isVideoVisible,
                  builder: (context, isShow, _) {
                    if (isShow) {
                      return AspectRatio(
                        aspectRatio:
                            ViewbackgroundWidget.mp4Controller!.value.aspectRatio,
                        child: VideoPlayer(ViewbackgroundWidget.mp4Controller!),
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
                child: SVGAImage(widget.animationControllerEntro)),
            ValueListenableBuilder<bool>(
                valueListenable: ShowEntroWidget.showEntro,
                builder: (context, isShow, _) {
                  if (isShow) {
                    return ShowEntroWidget(
                        userIntroData: widget.userIntroData,
                        offsetAnimationEntro: widget.offsetAnimationEntro);
                  } else {
                    return const SizedBox();
                  }
                }),
            if (widget.showYellowBanner['showYellowBanner']!)
           // Positioned(
           //         top: -48,
           //         child:
                   ShowYallowBannerWidget(
                       cureentRoomId: widget.room.ownerId!,
                       controllerYallowBanner: widget.yellowBannercontroller,
                       offsetAnimationYallowBanner:
                       widget.offsetAnimationYellowBanner,
                       senderYallowBanner: widget.yallowBannerSender,
                       hasPassword: widget.yallowBanner,
                       myData: MyDataModel.getInstance(),
                       ownerId: widget.yallowBanner) ,
             // ) ,
            ValueListenableBuilder<bool>(
                valueListenable: RoomScreen.showBanner,
                builder: (context, isShow, _) {
                  if (isShow) {
                    return Positioned(
                        top: ConfigSize.defaultSize! * 7.5,
                        left: AppPadding.p36,
                        child: ShowGiftBannerWidget(
                          isPlural: widget.isPlural['isPlural']!,
                          sendDataUser: widget.userBannerData['user_data_sender'],
                          receiverDataUser:
                              widget.userBannerData['user_data_receiver'],
                          giftImage: widget.userBannerData['gift_banner'] ?? '',
                          ownerId:
                              widget.userBannerData['owner_id_room_banner'] == ''
                                  ? widget.room.ownerId.toString()
                                  : widget.userBannerData['owner_id_room_banner'],
                          controllerBanner: widget.controllerBanner,
                          offsetAnimationBanner: widget.offsetAnimationBanner,
                          isPassword:
                              widget.userBannerData['is_password_room_banner'],
                          roomOwnerId: widget.room.ownerId.toString(),
                          showGift: showGift,
                          roomIntro: widget.room.roomIntro!,
                        ));
                  } else {
                    return const SizedBox();
                  }
                }),
            BlocConsumer<LuckyGiftBannerBloc, LuckyGiftBannerState>(
              listener: (context, state) {
                if (state is SendLuckyGiftSucssesState) {
                  LuckyCandy.recieverName = state.data.receiverName;
                  LuckyCandy.winCounter = LuckyCandy.winCounter + 1;
                  if (state.data.isWin && !state.data.isPopular) {
                    // ZegoUIKit().sendInRoomMessage(state.data.coomentMesasge, false);
                    LuckyGiftWinCircle.winCoin = state.data.winCoin;
                    LuckyCandy.winCircularluckyGift.value =
                        LuckyCandy.winCircularluckyGift.value + 1;
                  } else if (state.data.isWin && state.data.isPopular) {
                    ZegoUIKit().sendInRoomMessage(
                      state.data.message,
                    );
                    //  ZegoUIKit().sendInRoomMessage(state.data.coomentMesasge, false);
                    //   LuckyCandy.recieverName = state.data.receiverName;
                    //   LuckyCandy.winPopularCounter = LuckyCandy.winPopularCounter + 1;
                  } else {
                    //  ZegoUIKit().sendInRoomMessage(state.data.coomentMesasge, false);
                  }
                  if (state.isFirst == 1) {
                    widget.luckGiftBannderController.forward();
                  }
                }
              } else if (state is SendLuckyGiftErrorStateState) {
                errorToast(context: context, title: state.error);
              }
            },
            builder: (context, state) {
              if (state is SendLuckyGiftSucssesState) {
                return Positioned(
                    top: ConfigSize.defaultSize! * 50,
                    left: 0,
                    child: LuckGiftBannerWidget(
                        reciverName: state.data.receiverName,
                        giftNum: state.giftNum,
                        giftImage: state.data.giftImage,
                        controllerBanner: widget.luckGiftBannderController,
                        offsetAnimationBanner:
                            widget.offsetLuckGiftAnimationBanner));
              } else {
                return const SizedBox();
              }
            },
          ),
          ValueListenableBuilder(
              valueListenable: LuckyBoxVariables.showBannerLuckyBox,
              builder: (context, showBanner, _) {
                if (showBanner) {
                  return Positioned(
                      top: ConfigSize.defaultSize! * 6.95,
                      left: ConfigSize.defaultSize! * 5.78,
                      child: ShowLuckyBannerWidget(
                        sendDataUser: LuckyBoxVariables.sendSuperBox ??
                            MyDataModel.getInstance().convertToUserObject(),
                        superBox: widget.superBox,
                        showBannerLuckyBox:
                            LuckyBoxVariables.showBannerLuckyBox,
                        ownerId: widget.room.ownerId.toString(),
                      ));
                } else {
                  return const SizedBox();
                }
              }),
          ValueListenableBuilder<bool>(
              valueListenable: widget.showPopUp,
              builder: (context, isShow, _) {
                return AnimatedPositioned(
                  duration: const Duration(seconds: 10),
                  curve: Curves.linear,
                  onEnd: () {
                    widget.showPopUp.value = false;
                  },
                  top: ConfigSize.defaultSize! * 30,
                  left: isShow
                      ? -ConfigSize.defaultSize! * 40
                      : ConfigSize.defaultSize! * 40,
                  child: SizedBox(
                      width: ConfigSize.defaultSize! * 40.5,
                      height: ConfigSize.defaultSize! * 40.5,
                      child: PopUpWidget(
                          ownerDataModel: widget.popUpData?['pop_up_sender'] ??
                              MyDataModel.getInstance().convertToUserObject(),
                          massage: ZegoInRoomMessageInput.messagePonUp,
                          enterRoomModel: widget.room,
                          vip: widget.popUpData?['pop_up_sender'] == null
                              ? 0
                              : widget.popUpData!['pop_up_sender'].vip1!.level!
                          // == null ? 8 : widget.pobUpSender!.vip1!.level!
                          )),
                );
              }),
          Positioned(
            bottom: ConfigSize.defaultSize! * 12,
            left: ConfigSize.screenWidth! * 0.45,
            child: ValueListenableBuilder<TypeCandy>(
                valueListenable: GiftBottomBar.typeCandy,
                builder: (BuildContext context, TypeCandy typeCabdy, _) {
                  if (typeCabdy == TypeCandy.luckyCandy) {
                    return LuckyCandy(
                        roomData: widget.room,
                        luckGiftBannderController:
                            widget.luckGiftBannderController);
                  } else {
                    return const IgnorePointer(child: SizedBox());
                  }
                }),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: ViewbackgroundWidget.isKick,
            builder: (context, isKicked, _) {
              if (isKicked) {
                return Positioned(
                    bottom: ConfigSize.defaultSize! * 6,
                    left: AppPadding.p30,
                    right: AppPadding.p36,
                    child: KickOutUserWidget(
                      durationKickout: widget.durationKickout,
                      isKick: isKicked,
                    ));
              } else {
                return const SizedBox();
              }
            },
          ),
          IgnorePointer(
            child: ValueListenableBuilder<int>(
                valueListenable: LuckyCandy.winCircularluckyGift,
                builder: (context, sohw, _) {
                  if (sohw != 0) {
                    Future.delayed(const Duration(seconds: 1)).then((value) {
                      return showOverlay(const Align(
                          alignment: Alignment.topCenter,
                          child: LuckyGiftWinCircle()));
                    });
                    return const SizedBox();
                  } else {
                    return const SizedBox();
                  }
                }),
          ),
          IgnorePointer(
            child: ValueListenableBuilder<bool>(
                valueListenable: RoomScreen.happyNewYearGif,
                builder: (context, sohw, _) {
                  if (sohw) {
                    return Image.asset(AssetsPath.happyNewYearIntro);
                  } else {
                    return const SizedBox();
                  }
                }),
          ),
          IgnorePointer(
            child: ValueListenableBuilder<bool>(
                valueListenable: RoomScreen.happyNewYearVideo,
                builder: (context, sohw, _) {
                  if (sohw) {
                    late VideoPlayerController _controller;
                    _controller = VideoPlayerController.asset(
                        AssetsPath.happyNewYearVideo)
                      ..initialize().then((_) {
                        _controller.play();
                        _controller.addListener(() {
                          if (_controller.value.position ==
                              _controller.value.duration) {
                            _controller.dispose();
                            RoomScreen.happyNewYearVideo.value = false;
                          }
                        });
                      });
                    return Center(
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
          ),
          const IgnorePointer(
            child: LuckyGiftWithOverlay(),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: RoomScreen.isWinnerShowWidget,
            builder: (context, isShow, _) {
              if (isShow) {
                return const IgnorePointer(child: CoinCollectAnimate());
              } else {
                return const SizedBox();
              }
            },
          ),
          IgnorePointer(
            // VapView can set the width and height through the outer package Container() to limit the width and height of the pop-up video
            child: VapView(onVapViewCreated: (controller) {
              RoomScreen.vapViewController = controller;
            }),
          ),
        ]);
      }, listener: (context, state) {
        if (state is ErrorSendGiftStates) {
          errorToast(context: context, title: state.errorMessage);
        } else if (state is SuccessSendGiftStates) {
          ZegoUIKit().sendInRoomMessage(
            state.successMessage,
          );
        }
      }),
    );
  }
}
