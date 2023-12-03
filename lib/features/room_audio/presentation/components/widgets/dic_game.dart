import 'package:flutter/material.dart';
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class DiceGame extends StatefulWidget {
  const DiceGame({super.key, required this.randomNum});

  final int randomNum;

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
  }

  @override
  void initState() {
    animationController = SVGAAnimationController(vsync: this);
    loadAnimation();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Future.delayed(const Duration(seconds: 7), () {
      animationController.videoItem = null;
      setState(() {
        showResultDicGame = true;
      });
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  List<String> dicNum = [
    AssetsPath.dic1,
    AssetsPath.dic2,
    AssetsPath.dic3,
    AssetsPath.dic4,
    AssetsPath.dic5,
    AssetsPath.dic6,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ConfigSize.defaultSize! * 7,
      width: ConfigSize.defaultSize! * 7,
      child: showResultDicGame
          ? Image.asset(dicNum[widget.randomNum])
          : SVGAImage(animationController),
    );
  }
}
