// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/model/room_user_messages_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/aristocracy_level.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/gredin_text_vip.dart';
import 'package:tik_chat_v2/core/widgets/level_continer.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/games/lucky_draw/comment_body.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/profile/message_room_profile.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/profile/widgets/anonymous_dialog.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/games/brick_paper_scissors.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/games/dic_game.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/defines/message.dart';

class MessagesChached extends StatelessWidget {
  ZegoInRoomMessage message;
  String vip;
  String sender;
  String receiver;
  String bubble;
  String frame;
  MyDataModel myDataModel;
  LayoutMode layoutMode;
  EnterRoomModel room;

  MessagesChached(
      {super.key,
      required this.message,
      required this.vip,
      required this.sender,
      required this.receiver,
      required this.bubble,
      required this.frame,
      required this.myDataModel,
      required this.layoutMode,
      required this.room});

  static Map<String, RoomUserMesseagesModel> usersMessagesRoom = {};

  List<TextSpan> spans = [];

  @override
  Widget build(BuildContext context) {
    bool changeTheme = message.changeTheme ?? false;
    bool isGame = message.games != GamesInRoom.normal;
    List<String> words = message.message.split(" ");
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
        (message.user.id.startsWith('-1'))
            ? bottomDailog(
                widget: const AnonymousDialog(), context: context,
                // height: ConfigSize.screenHeight!*0.3
              )
            : bottomDailog(
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
                          MessagesChached
                              .usersMessagesRoom[message.user.id]?.image ??
                          ""),
                ),
                SizedBox(
                  width: ConfigSize.defaultSize,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: ConfigSize.defaultSize! * 1.5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GradientTextVip(
                          text: message.user.name,
                          isVip: message.user.inRoomAttributes.value['vip'] ==
                                  ''
                              ? false
                              : message.user.inRoomAttributes.value['vip'] ==
                                      '8'
                                  ? true
                                  : false,
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic,
                              fontSize: AppPadding.p10),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          width: ConfigSize.defaultSize! - 3,
                        ),
                        room.ownerId.toString() == message.user.id
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: Image.asset(AssetsPath.hostMark))
                            : const SizedBox(),
                        AristocracyLevel(
                            level: vip == ""
                                ? MessagesChached
                                        .usersMessagesRoom[message.user.id]
                                        ?.vipLevel ??
                                    0
                                : int.parse(vip)),
                        const SizedBox(
                          width: 1,
                        ),
                        // if ((RoomScreen.usersMessagesRoom[message.user.id]
                        //     ?.senderLevelImg ??
                        //     '') !=
                        //     '')
                        SizedBox(
                          width: ConfigSize.defaultSize! * 4,
                          height: ConfigSize.defaultSize! * 2,
                          child: LevelContainer(
                            image: sender == ""
                                ? MessagesChached
                                        .usersMessagesRoom[message.user.id]
                                        ?.senderLevelImg ??
                                    ''
                                : sender,
                          ),
                        ),
                        const SizedBox(
                          width: 1,
                        ),
                        // if ((RoomScreen.usersMessagesRoom[message.user.id]
                        //     ?.revicerLevelImg ??
                        //     '') !=
                        //     '')
                        //   SizedBox(
                        //     width: ConfigSize.defaultSize! * 4,
                        //     height: ConfigSize.defaultSize! * 2,
                        //     child: LevelContainer(
                        //       image: receiver == ""
                        //           ? RoomScreen.usersMessagesRoom[message.user.id]
                        //           ?.revicerLevelImg ??
                        //           ''
                        //           : receiver,
                        //     ),
                        //   ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            if (isGame)
              isGamesWidget(message),
            (bubble == "" && changeTheme == false && !isGame)
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

                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 4),
                      child: SelectableText.rich(
                        TextSpan(children: spans),
                      ),
                    ),
                  )
                : changeTheme && !isGame
                    ? Padding(
                        padding: EdgeInsets.only(
                            left: ConfigSize.defaultSize! * 3,
                            top: ConfigSize.defaultSize! - 4,
                            bottom: ConfigSize.defaultSize! - 4,
                            right: ConfigSize.defaultSize! - 4),
                        child: Container(
                          // width: ConfigSize.defaultSize!*33,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  ConfigSize.defaultSize!),
                              color: ColorManager.deepBlue),

                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 4),
                          child: SelectableText.rich(
                            TextSpan(children: spans),
                          ),
                        ),
                      )
                    : !isGame
                        ? Padding(
                            padding: EdgeInsets.only(
                                left: AppPadding.p24,
                                top: AppPadding.p2,
                                bottom: AppPadding.p2,
                                right: AppPadding.p2),
                            child: CachedNetworkImage(
                                imageUrl: ConstentApi().getImage(bubble == ""
                                    ? MessagesChached
                                        .usersMessagesRoom[message.user.id]
                                        ?.bubble
                                    : bubble),
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.fill),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              ConfigSize.defaultSize! + 15,
                                          vertical: ConfigSize.defaultSize!),
                                      child: SelectableText.rich(
                                        TextSpan(children: spans),
                                      ),
                                    ),
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
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
                                errorWidget: (context, url, error) =>
                                    const Center(
                                      child: Icon(Icons.error),
                                    )),
                          )
                        : const SizedBox(),
          ],
        ),
      ),
    );
  }
  Widget isGamesWidget(ZegoInRoomMessage message){
    switch (message.games) {
      case GamesInRoom.luckyDrawGame:
        return CommentBody(room: room);
      case GamesInRoom.dicGame:
        return SizedBox(
          height: ConfigSize.defaultSize! * 5,
          width: ConfigSize.defaultSize! * 5,
          child: DiceGame(
            randomNum: int.parse(message.message[0]),
          ),
        );
      case GamesInRoom.rpsGame:
        return SizedBox(
          height: ConfigSize.defaultSize! * 5,
          width: ConfigSize.defaultSize! * 5,
          child: BrickPaperScissorsGame(
            randomNum: int.parse(message.message[0]),
          ),
        );
      case GamesInRoom.spinGame:
        return SizedBox(
          child: Row(
            children: [
              SelectableText.rich(
                TextSpan(children: spans),
              ),
              Image.asset(AssetsPath.turntableIcon, scale: 2,),
            ],
          ),
        );
      default:
        return const SizedBox();
    }
  }
}
