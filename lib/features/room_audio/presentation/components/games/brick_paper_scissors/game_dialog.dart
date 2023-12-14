// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/send_game_choise_uc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/game_manager/game_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/game_manager/game_event.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/uikit_service.dart';

class GameDialog extends StatefulWidget {
  String gameRecordId;
  GameDialog({super.key, required this.gameRecordId});

  static List<String> brickPaperNum = [
    AssetsPath.brick,
    AssetsPath.paper,
    AssetsPath.scissors,
  ];

  @override
  State<GameDialog> createState() => _GameDialogState();
}

class _GameDialogState extends State<GameDialog> {

  int selected_index = 0;

  bool isTimerFinished = false;
  int start = 10;

  @override
  void initState() {
    Timer.periodic(
      const Duration(seconds: 1), (Timer timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          isTimerFinished = true;
          BlocProvider.of<GameBloc>(context).add(SendGameChoise(sendGameChoisePramiter: SendGameChoisePramiter(
              gameId: widget.gameRecordId,
              answer: selected_index.toString()
          )));
          Navigator.pop(context);
          ZegoUIKit.instance.sendInRoomMessage("${StringManager.rpsGameKey} $selected_index",);
        });
      } else {
        if(mounted){
          setState(() {
            start--;
          });
        }
      }
    },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Dialog(
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
                  padding: EdgeInsets.symmetric(vertical: ConfigSize.defaultSize! * 2),
                  child: Text(
                    "${StringManager.rps.tr()} ${StringManager.games.tr()}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ConfigSize.defaultSize! * 1.7,
                        overflow: TextOverflow.fade),
                  )),

              Text("${StringManager.timeRemains.tr()} ${start.toString()}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: ConfigSize.defaultSize! * 1.3),),

              SizedBox(height: ConfigSize.defaultSize! * 3),

              SizedBox(
                height: ConfigSize.defaultSize! * 7,
                child: ListView.builder(
                    itemCount: GameDialog.brickPaperNum.length,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize! * 2.5),
                        child: InkWell(
                            onTap: (){
                              setState(() {
                                selected_index = index;
                              });
                            },
                            child: Container(
                              width: ConfigSize.defaultSize! * 6,
                              height: ConfigSize.defaultSize! * 6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: selected_index == index ? const Color.fromRGBO(149, 159, 225, 1) : Colors.transparent, width: 2),
                              ),
                              child: Image.asset(GameDialog.brickPaperNum[index]),
                            ),
                        ),
                      );
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
