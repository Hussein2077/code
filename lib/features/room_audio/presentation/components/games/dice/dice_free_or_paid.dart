import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/games/dialog_explained_game.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/games/dice/user_selection_screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/games/widgets/free_or_paid_button.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/uikit_service.dart';

class DiceFreeOrPaid extends StatelessWidget {
  final EnterRoomModel roomData;
  const DiceFreeOrPaid({super.key, required this.roomData});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ConfigSize.screenHeight! * 0.7,
      width: ConfigSize.screenWidth,
      color: Colors.transparent,
      child: Stack(alignment: Alignment.bottomCenter, children: [
        Container(
          height: ConfigSize.screenHeight! * 0.62,
          width: ConfigSize.screenWidth,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: ColorManager.bageGriedinet),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: ConfigSize.defaultSize! * 3,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      bottomDailog(
                          context: context,
                          widget: ExplainGame(
                            explainGame: StringManager.explainGameDice.tr(),
                            iconGame: AssetsPath.diceIcon,
                          ));
                    },
                    icon: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.question_mark_outlined,
                          color: Colors.black,
                          size: ConfigSize.defaultSize! * 3,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: ConfigSize.screenHeight! * 0.1,
              ),
              FreeOrPaidButton(
                text: StringManager.freePlay.tr(),
                onPressed: () {
                  Navigator.pop(context);
                  ZegoUIKit.instance.sendInRoomMessage(
                    "${StringManager.diceGameKey} ${Random().nextInt(6)}",
                  );
                },
              ),
              SizedBox(
                height: ConfigSize.defaultSize! * 2,
              ),
              FreeOrPaidButton(
                text: StringManager.PaidPlay.tr(),
                onPressed: () {
                  Navigator.pop(context);
                  bottomDailog(
                      context: context,
                      widget: UserSelectionDiceScreen(roomData: roomData));
                },
              )
            ],
          ),
        ),
        Positioned(
          top: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AssetsPath.diceIcon,
                scale: .7,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
