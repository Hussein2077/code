// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/Conter_Time_pk_Widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/pk_widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/room_screen_controler.dart';

class PkController{
  static int timeMinutePK = 0;
  static int timeSecondPK = 0;
  static int scoreTeam1 = 0;
  static int scoreTeam2 = 0;
  static double precantgeTeam1 = 0.5;
  static double precantgeTeam2 = 0.5;
  static bool winRedTeam = false;
  static bool winBlueTeam = false;
  static late SVGAAnimationController animationControllerRedTeam;
  static late SVGAAnimationController animationControllerBlueTeam;
  static double scoreBlue = 0.5;
  static double scoreRed = 0.5;
  static List<int> teamBlue = [1, 2, 5, 6];
  static List<int> teamRed = [3, 4, 7, 8];
  static ValueNotifier<bool> isPK = ValueNotifier<bool>(false);
  static ValueNotifier<bool> showPK = ValueNotifier<bool>(false);
  static ValueNotifier<int> updatePKNotifier = ValueNotifier<int>(0);
}

const String showPkKey = "showPK";
const String hidePkKey = "hidePK";
const String startPkKey = "startPK";
const String updatePkKey = "updatePk";
const String closePkKey = "closePk";
const String timePkKey = "PkTime";

activePK() {
  PkController.isPK.value ? PkController.isPK.value = false : PkController.isPK.value = true;
}

ShowPkKey(){
  PkController.showPK.value = true;
  PkController.isPK.value = true;
}

StartPkKey(Map<String, dynamic> result, String ownerId, BuildContext context){
  PkController.timeMinutePK = int.parse(result[messageContent][timePkKey]);
  PkController.timeSecondPK = 0;
  PkController.scoreTeam2 = 0;
  PkController.precantgeTeam1 = 0.5;
  PkController.precantgeTeam2 = 0.5;
  PKWidget.isStartPK.value = true;
  PkController.scoreTeam1 = 0;
  PkController.updatePKNotifier.value = PkController.updatePKNotifier.value + 1;
  getIt<SetTimerPK>().start(context, ownerId);
}

void restorePKData() {
  PkController.scoreTeam2 = 0;
  PkController.precantgeTeam1 = 0.5;
  PkController.precantgeTeam2 = 0.5;
  PkController.scoreTeam1 = 0;
}

HidePkKey(){
  PkController.showPK.value = false;
  restorePKData();
  PkController.isPK.value = false;
}

UpdatePkKey(Map<String, dynamic> result){
  PkController.scoreTeam2 = result[messageContent]['scoreTeam2'];
  PkController.precantgeTeam1 =
      double.parse(result[messageContent]['percentagepk_team1']);
  PkController.precantgeTeam2 =
      double.parse(result[messageContent]['percentagepk_team2']);
  PkController.scoreTeam1 = result[messageContent]['scoreTeam1'];
  PkController.updatePKNotifier.value =
      PkController.updatePKNotifier.value + 1;
}

ClosePkKey(Map<String, dynamic> result){
  PkController.scoreTeam2 = result[messageContent]['scoreTeam2'];
  PkController.precantgeTeam1 =
      double.parse(result[messageContent]['percentagepk_team1']);
  PkController.precantgeTeam2 =
      double.parse(result[messageContent]['percentagepk_team2']);
  PKWidget.isStartPK.value = false;
  PkController.scoreTeam1 = result[messageContent]['scoreTeam1'];
  PkController.updatePKNotifier.value =
      PkController.updatePKNotifier.value + 1;
  if (result[messageContent]['winner_Team'] == 2) {
    loadAnimationBlueTeam("images/WIN.svga");
    loadAnimationRedTeam("images/LOSE.svga");
  } else if (result[messageContent]['winner_Team'] == 1) {
    loadAnimationBlueTeam("images/LOSE.svga");
    loadAnimationRedTeam("images/WIN.svga");
  } else {
    loadAnimationBlueTeam("files/ce611dcb83b465805d552565d0705be4.svga");
    loadAnimationRedTeam("files/091e42c561800ca052493228e2165d70.svga");
  }
  getIt<SetTimerPK>().timer.cancel();
}


//todo change this image
Future<void> loadAnimationRedTeam(String img) async {
  final videoItem = await SVGAParser.shared
      .decodeFromURL("https://yai.rstar-soft.com/public/storage/$img");
  PkController.animationControllerRedTeam.videoItem = videoItem;
  PkController.animationControllerRedTeam.forward().whenComplete(() {
    return PkController.animationControllerRedTeam.videoItem = null;
  });
}

Future<void> loadAnimationBlueTeam(String img) async {
  //todo update this url
  final videoItem = await SVGAParser.shared
      .decodeFromURL("https://yai.rstar-soft.com/public/storage/$img");
  PkController.animationControllerBlueTeam.videoItem = videoItem;
  PkController.animationControllerBlueTeam.forward().whenComplete(() {
    return PkController.animationControllerBlueTeam.videoItem = null;
  });
}