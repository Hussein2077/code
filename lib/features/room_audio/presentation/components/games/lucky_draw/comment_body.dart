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
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/uikit_service.dart';

class CommentBody extends StatefulWidget {
  EnterRoomModel room;
  CommentBody({super.key, required this.room});

  @override
  State<CommentBody> createState() => _CommentBodyState();
}

class _CommentBodyState extends State<CommentBody> {

  final _wheelNotifier = BehaviorSubject<int>();
  String selectedItem = "";
  bool animationEnded = false;


  @override
  void initState() {

    print(LuckyDrawGameScreen.userSelected.toString());
    _wheelNotifier.add(Fortune.randomInt(0, LuckyDrawGameScreen.userSelected.length));
    super.initState();
  }

  @override
  void dispose() {
    _wheelNotifier.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: ConfigSize.defaultSize! * 3,
          top: ConfigSize.defaultSize! - 4,
          bottom: ConfigSize.defaultSize! - 4,
          right: ConfigSize.defaultSize! - 4),
      child: Container(
        width: ConfigSize.defaultSize! * 25,
        height: ConfigSize.defaultSize! * 25,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(.5),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(StringManager.result.tr(),
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
                  fontSize: 20
              ),
            ),

        Text("Participants: ${LuckyDrawGameScreen.userSelected.length}", style: TextStyle(color: Colors.white),),
        Text("Lucky Users: 1", style: TextStyle(color: Colors.white),),



        SizedBox(
          width: ConfigSize.defaultSize! * 18,
          child: FortuneBar(
            selected: _wheelNotifier.stream,
            height: ConfigSize.defaultSize! * 10,
            physics: DirectionalPanPhysics.horizontal(),
            animateFirst: false, //start animation when open screen
            onAnimationEnd: () {
              setState(() {
                animationEnded = true;
              });
            },
            items: [
              for (var it in LuckyDrawGameScreen.userSelected.values) FortuneItem(
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        UserImage(image: it.image),
                        const SizedBox(height: 5,),
                        Text(it.name),
                      ],
                    ),
                  ),
              ),
            ],
          ),
        ),
            if(animationEnded) Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  bottomDailog(
                      context: context,
                      widget: GiftScreen(
                        roomData: widget.room,
                        userId: LuckyDrawGameScreen.userSelected[_wheelNotifier.value]!.userId.toString(),
                        myDataModel: MyDataModel.getInstance(),
                        userImage: LuckyDrawGameScreen.userSelected[_wheelNotifier.value]!.image,
                        listAllUsers: null,
                        isSingleUser: true,
                      ));
                },
                child:  Image.asset(AssetsPath.sendGiftIconProfile, scale: 2,),
              ),
            ),
          ]
        ),
      ),
    );
  }
}
