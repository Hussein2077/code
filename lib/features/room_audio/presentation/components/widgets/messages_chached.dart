// ignore_for_file: must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/model/room_user_messages_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
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
import 'package:tik_chat_v2/features/room_audio/presentation/components/games/brick_paper_scissors/rps_comment_ui.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/games/dice/dic_game.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/profile/message_room_profile.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/profile/widgets/anonymous_dialog.dart';
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
    GamesInRoom CommentType = checkMeesageType(message.message);

    String messageWithOutKeys =
        removeWordFromString(message.message, CommentType);

    bool isGame = (CommentType != GamesInRoom.normal &&
        CommentType != GamesInRoom.luckyGiftComment);

    List<String> words = messageWithOutKeys.split(" ");

    bool isPrivateComment =
        message.message.contains(StringManager.privateCommentKey);

    for (String word in words) {
      if (word.startsWith("@")) {
        spans.add(TextSpan(
            text: "$word ", style: const TextStyle(color: Colors.yellow)));
      } else {
        spans.add(TextSpan(
            text: "$word ", style: const TextStyle(color: Colors.white)));
      }
    }

    if (CommentType == GamesInRoom.luckyGiftComment ||
        CommentType == GamesInRoom.dicGameResult ||
        CommentType == GamesInRoom.spinGame ||
        CommentType == GamesInRoom.rpsGameResult) {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppPadding.p8, vertical: AppPadding.p2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: ConfigSize.defaultSize! * 4,
                  height: ConfigSize.defaultSize! * 5,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(AssetsPath.iconApp),
                    ),
                  ),
                ),
                SizedBox(
                  width: ConfigSize.defaultSize,
                ),
                GradientTextVip(
                  text: "TIK CHAT",
                  isVip: false,
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      fontSize: AppPadding.p10),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AssetsPath.luckyGiftBubble),
                    fit: BoxFit.cover),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: isGamesWidget(CommentType, messageWithOutKeys),
              ),
            ),
          ],
        ),
      );
    } else {
      if (isPrivateComment) {
        String recieverId = message.message
            .split(" ")
            .first
            .replaceAll(StringManager.privateCommentKey, '');
        if ((message.user.id.toString() ==
                MyDataModel.getInstance().id.toString()) ||
            (recieverId == MyDataModel.getInstance().id.toString())) {
          return privateComment(context);
        } else {
          return const SizedBox();
        }
      } else {
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
                              width: ConfigSize.defaultSize! * 15,
                              isVip:
                                  message.user.inRoomAttributes.value['vip'] ==
                                          ''
                                      ? false
                                      : message.user.inRoomAttributes
                                                  .value['vip'] ==
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
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                if (isGame) isGamesWidget(CommentType, messageWithOutKeys),
                (bubble == "" &&
                        CommentType != GamesInRoom.luckyGiftComment &&
                        !isGame)
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
                    : CommentType == GamesInRoom.luckyGiftComment && !isGame
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
                                    imageUrl: ConstentApi().getImage(bubble ==
                                            ""
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
                                              vertical:
                                                  ConfigSize.defaultSize!),
                                          child: SelectableText.rich(
                                            TextSpan(children: spans),
                                          ),
                                        ),
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey[850]!,
                                          highlightColor: Colors.grey[800]!,
                                          child: Container(
                                            width:
                                                ConfigSize.defaultSize! * 5.7,
                                            height:
                                                ConfigSize.defaultSize! * 5.7,
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
    }
  }

  Widget isGamesWidget(GamesInRoom type, String message) {
    switch (type) {
      case GamesInRoom.dicGame:
        return SizedBox(
          height: ConfigSize.defaultSize! * 5,
          width: ConfigSize.defaultSize! * 5,
          child: DiceGame(
            randomNum: int.parse(message),
          ),
        );
      case GamesInRoom.rpsGame:
        return BrickPaperScissorsGame(
          randomNum: int.parse(message),
        );
      case GamesInRoom.spinGame:
        return Row(
          children: [
            SizedBox(
              width: ConfigSize.screenWidth! / 1.5,
              child: SelectableText.rich(
                TextSpan(children: spans),
              ),
            ),
            Image.asset(
              AssetsPath.turntableIcon,
              scale: 2,
            ),
          ],
        );
      case GamesInRoom.dicGameResult:
        return SizedBox(
          child: Row(
            children: [
              SizedBox(
                width: ConfigSize.screenWidth! / 1.5,
                child: SelectableText.rich(
                  TextSpan(children: spans),
                ),
              ),
              Image.asset(
                AssetsPath.diceIcon,
                scale: 2,
              ),
            ],
          ),
        );
      case GamesInRoom.rpsGameResult:
        return SizedBox(
          child: Row(
            children: [
              SizedBox(
                width: ConfigSize.screenWidth! / 1.5,
                child: SelectableText.rich(
                  TextSpan(children: spans),
                ),
              ),
              Image.asset(
                AssetsPath.guessingIcon,
                scale: 2,
              ),
            ],
          ),
        );
      default:
        return const SizedBox();
    }
  }

  Widget privateComment(BuildContext context) {
    return InkWell(
      onTap: () {
        (message.user.id.startsWith('-1'))
            ? bottomDailog(
                widget: const AnonymousDialog(),
                context: context,
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
                          width: ConfigSize.defaultSize! * 15,
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
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: AppPadding.p24,
                  top: AppPadding.p2,
                  bottom: AppPadding.p2,
                  right: AppPadding.p2),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetsPath.privateComment),
                      fit: BoxFit.fill
                  ),
                ),
                padding: EdgeInsets.only(
                  top: ConfigSize.defaultSize!*5
                    ,
                    bottom: ConfigSize.defaultSize!*3.2,
                    left: ConfigSize.defaultSize! *5,
                    right: ConfigSize.defaultSize!*5.5),
                child: Text(

                  message.message
                      .replaceAll(message.message.split(" ").first, ""),
                  style: TextStyle(
                      height : 1.3,
                      color: ColorManager.whiteColor, overflow: TextOverflow.clip , fontSize: ConfigSize.defaultSize!*1.3),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

GamesInRoom checkMeesageType(String message) {
  if (message.contains(StringManager.rpsGameKey)) {
    return GamesInRoom.rpsGame;
  } else if (message.contains(StringManager.diceGameKey)) {
    return GamesInRoom.dicGame;
  } else if (message.contains(StringManager.luckyDrawGameKey)) {
    return GamesInRoom.luckyDrawGame;
  } else if (message.contains(StringManager.spinGameKey)) {
    return GamesInRoom.spinGame;
  } else if (message.contains(StringManager.luckyGiftCommentKey)) {
    return GamesInRoom.luckyGiftComment;
  } else if (message.contains(StringManager.diceGameResultKey)) {
    return GamesInRoom.dicGameResult;
  } else if (message.contains(StringManager.rpsGameResultKey)) {
    return GamesInRoom.rpsGameResult;
  } else {
    return GamesInRoom.normal;
  }
}

String removeWordFromString(String sentence, GamesInRoom commentType) {
  switch (commentType) {
    case GamesInRoom.luckyDrawGame:
      final pattern = RegExp('\\b${StringManager.luckyDrawGameKey}\\b',
          caseSensitive: false);
      return sentence.replaceAll(pattern, '');
    case GamesInRoom.dicGame:
      final pattern =
          RegExp('\\b${StringManager.diceGameKey}\\b', caseSensitive: false);
      return sentence.replaceAll(pattern, '');
    case GamesInRoom.rpsGame:
      final pattern =
          RegExp('\\b${StringManager.rpsGameKey}\\b', caseSensitive: false);
      return sentence.replaceAll(pattern, '');
    case GamesInRoom.spinGame:
      final pattern =
          RegExp('\\b${StringManager.spinGameKey}\\b', caseSensitive: false);
      return sentence.replaceAll(pattern, '');
    case GamesInRoom.dicGameResult:
      final pattern = RegExp('\\b${StringManager.diceGameResultKey}\\b',
          caseSensitive: false);
      return sentence.replaceAll(pattern, '');
    case GamesInRoom.rpsGameResult:
      final pattern = RegExp('\\b${StringManager.rpsGameResultKey}\\b',
          caseSensitive: false);
      return sentence.replaceAll(pattern, '');
    default:
      return sentence;
  }
}
