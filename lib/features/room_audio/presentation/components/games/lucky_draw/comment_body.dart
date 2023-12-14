import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/gifts/widgets/Gift_Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/games/lucky_draw/lucky_draw_game_screen.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class CommentBody extends StatefulWidget {
  EnterRoomModel room;
  Map<int, SelecteUsers> items;
  int winner;
  int id;
  void Function()? exitDailog ;

  CommentBody(
      {super.key,
      required this.room,
      required this.items,
      required this.winner,
      required this.id,
         this.exitDailog ,

      });

  @override
  State<CommentBody> createState() => _CommentBodyState();
}

class _CommentBodyState extends State<CommentBody> {
  final _wheelNotifier = BehaviorSubject<int>();
  String selectedItem = "";
  bool animationEnded = false;

  bool isTimerFinished = false;
  int start = 10;

  @override
  void initState() {
    _wheelNotifier.add(widget.winner);
    super.initState();
  }

  @override
  void dispose() {
    _wheelNotifier.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              width: ConfigSize.defaultSize! * 25,
              height: ConfigSize.defaultSize! * 30,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      StringManager.result.tr(),
                      style: const TextStyle(
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 5,
                              color: Colors.red,
                              offset: Offset(2, 2),
                            ),
                            Shadow(
                              blurRadius: 5,
                              color: Colors.red,
                              offset: Offset(-2, -2),
                            ),
                            Shadow(
                              blurRadius: 5,
                              color: Colors.red,
                              offset: Offset(2, -2),
                            ),
                            Shadow(
                              blurRadius: 5,
                              color: Colors.red,
                              offset: Offset(-2, 2),
                            ),
                          ],
                          fontSize: 20),
                    ),
                    Text(
                      "${StringManager.timeRemains.tr()} ${start.toString()}",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: ConfigSize.defaultSize! * 1.3),
                    ),
                    Text(
                      "${StringManager.participants.tr()} ${widget.items.length}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      "${StringManager.luckyUsers.tr()} 1",
                      style: const TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: ConfigSize.defaultSize! * 18,
                      child: FortuneBar(
                        selected: _wheelNotifier.stream,
                        height: ConfigSize.defaultSize! * 10,
                        physics: DirectionalPanPhysics.horizontal(),
                        animateFirst: false,
                        //start animation when open screen
                        onAnimationEnd: () {
                          setState(() {
                            animationEnded = true;
                            Timer.periodic(
                              const Duration(seconds: 1),
                              (Timer timer) {
                                if (start == 0) {
                                  setState(() {
                                    timer.cancel();
                                    isTimerFinished = true;
                                    // Navigator.pop(context);
                                  });
                                } else {
                                  if (mounted) {
                                    setState(() {
                                      start--;
                                    });
                                  }
                                }
                              },
                            );
                          });
                        },
                        items: [
                          for (var it in widget.items.values)
                            FortuneItem(
                              child: Container(
                                color: Colors.transparent,
                                child: Column(
                                  children: [
                                    UserImage(image: it.image),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(it.name, style: const TextStyle(overflow: TextOverflow.ellipsis),),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (animationEnded)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            bottomDailog(
                                context: context,
                                widget: GiftScreen(
                                  roomData: widget.room,
                                  userId: widget.items[widget.id]!.userId.toString(),
                                  myDataModel: MyDataModel.getInstance(),
                                  userImage: widget.items[widget.id]!.image,
                                  listAllUsers: null,
                                  isSingleUser: true,
                                ));
                          },
                          child: Image.asset(
                            AssetsPath.sendGiftIconProfile,
                            scale: 2,
                          ),
                        ),
                      ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
