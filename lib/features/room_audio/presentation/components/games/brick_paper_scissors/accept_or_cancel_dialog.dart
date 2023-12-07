// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/mall/widget/cashed_network_circle.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/cancel_game_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/start_game_uc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/game_manager/game_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/game_manager/game_event.dart';

class AcceptOrCancelDialog extends StatelessWidget {
   String coins;
   String senderImage;
   String senderName;
   String toId;
   String gameRecordId;
   AcceptOrCancelDialog({super.key, required this.coins, required this.senderImage, required this.senderName, required this.toId, required this.gameRecordId});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ConfigSize.defaultSize!),
      ),
      child: Container(
        height: ConfigSize.defaultSize! * 25,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: ColorManager.bageGriedinet),
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize!),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(vertical: ConfigSize.defaultSize!),
                child: Text(
                  "${StringManager.rps.tr()} ${StringManager.games.tr()}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: ConfigSize.defaultSize! * 1.7,
                      overflow: TextOverflow.fade),
                )),

            CachedNetworkImgeCircular(
              hight: ConfigSize.defaultSize! * 6,
              width: ConfigSize.defaultSize! * 6,
              image: senderImage,
            ),

            // CircleAvatar(
            //   radius: ConfigSize.defaultSize! * 3,
            //   //TODO Add User Image
            // ),
            SizedBox(height: ConfigSize.defaultSize!,),
            Text(
              senderName,
              style: const TextStyle(
                color: Colors.white
              ),
            ),
            Text(
              "${StringManager.numberOfCoins.tr()} : $coins",
              style: const TextStyle(
                  color: Colors.white
              ),
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                    InkWell(
                        onTap: () {
                          BlocProvider.of<GameBloc>(context).add(CancelGame(cancelGamePramiter: CancelGamePramiter(
                              gameId: gameRecordId
                          )));
                        },
                        child: Text(
                          StringManager.cancel.tr(),
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                            fontSize: ConfigSize.defaultSize! * 1.7,
                          ),
                        )),
                  InkWell(
                      onTap: () {
                        BlocProvider.of<GameBloc>(context).add(StartGame(startGamePramiter: StartGamePramiter(
                            gameId: gameRecordId
                        )));
                      },
                      child: Text(
                        StringManager.accept.tr(),
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: ConfigSize.defaultSize! * 1.7,
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
