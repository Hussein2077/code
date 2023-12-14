
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/games/brick_paper_scissors/user_selection_screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/games/dice/user_selection_screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/games/lucky_draw/lucky_draw_game_screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/games/spin_wheel/spin_wheel_game_screen.dart';

class ActivityGamesDialog extends StatelessWidget {
  final EnterRoomModel roomData;
  ActivityGamesDialog({super.key, required this.roomData});


  @override
  Widget build(BuildContext context) {
    List<Widget> gamesColumnList = [
      gamesColumn(
          image: AssetsPath.diceIcon,
          name: StringManager.diceGame.tr(),
          onTap: () {
            Navigator.pop(context);
            bottomDailog(context: context, widget: UserSelectionDiceScreen(roomData: roomData));
          }),
      gamesColumn(
          image: AssetsPath.guessingIcon,
          name: StringManager.rps.tr(),
          onTap: () {
            Navigator.pop(context);
            bottomDailog(context: context, widget: UserSelectionScreen(roomData: roomData));
          }),
      gamesColumn(
          image: AssetsPath.lotteryIcon,
          name: StringManager.luckyPull.tr(),
          onTap: () {
            Navigator.pop(context);
            bottomDailog(context: context, widget: LuckyDrawGameScreen(room: roomData,));
          }),
      gamesColumn(
          image: AssetsPath.turntableIcon,
          name: StringManager.turntable.tr(),
          onTap: () {
            Navigator.pop(context);
            bottomDailog(context: context, widget: SpinWheelGameScreen(roomData: roomData));
          }),
    ];
    return Container(
      height: ConfigSize.screenHeight! * .35,
      width: ConfigSize.screenWidth! * .9,
      decoration: BoxDecoration(
          color: ColorManager.darkBlack,
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 2)),
      child: GridView.builder(
        itemCount: gamesColumnList.length,
        itemBuilder: (context, index) {
          return gamesColumnList[index];
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisSpacing: ConfigSize.defaultSize! * 2),
      ),
    );
  }

  Widget gamesColumn(
      {required String image, required String name, void Function()? onTap}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ConfigSize.defaultSize!),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Expanded(
                child: Image.asset(
              image,
              scale: 1.2,
            )),
            SizedBox(
              height: ConfigSize.defaultSize! * .3,
            ),
            Text(
              name,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: ConfigSize.defaultSize!,
                  color: ColorManager.whiteColor),
            ),
            SizedBox(
              height: ConfigSize.defaultSize! * .5,
            ),
          ],
        ),
      ),
    );
  }
}
