import 'dart:math';
import 'package:flutter/material.dart';
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';

class DiceGame extends StatefulWidget {
  const DiceGame({super.key});

  @override
  State<DiceGame> createState() => _DiceGameState();
}

class _DiceGameState extends State<DiceGame> with TickerProviderStateMixin {
  late SVGAAnimationController animationController;
  bool showResultDicGame = false;

  void loadAnimation() async {
    final videoItem =
        await SVGAParser.shared.decodeFromAssets(AssetsPath.dicSVGA);
    animationController.videoItem = videoItem;
    animationController
        .repeat() // Try to use .forward() .reverse()
        .whenComplete(() {


      return animationController.videoItem = null;
    });
    Future.delayed(const Duration(seconds: 7),(){
      animationController.videoItem = null;
      showResultDicGame = true;
    });
  }

  @override
  void initState() {
    animationController = SVGAAnimationController(vsync: this);
    loadAnimation();
    super.initState();
    print('${random()}hhhh');
    print('${showResultDicGame}hhhh');
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
  int random(){
    return Random().nextInt(6) + 1;
  }
  @override
  Widget build(BuildContext context) {

     return SizedBox(
      height: 100,
      width: 200,
      child: showResultDicGame
          ? Text(random.toString())
          : SVGAImage(animationController),
    );
  }
}
