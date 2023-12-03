import 'package:flutter/material.dart';
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class BrickPaperScissorsGame extends StatefulWidget {
  const BrickPaperScissorsGame({super.key, required this.randomNum});

  final int randomNum;

  @override
  State<BrickPaperScissorsGame> createState() => _BrickPaperScissorsGameState();
}

class _BrickPaperScissorsGameState extends State<BrickPaperScissorsGame> with TickerProviderStateMixin {
  late SVGAAnimationController animationController;
  bool showResultGame = false;

  void loadAnimation() async {
    final videoItem =
    await SVGAParser.shared.decodeFromAssets(AssetsPath.fingerGuessing);
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
    Future.delayed(const Duration(seconds: 3), () {
      animationController.videoItem = null;
      setState(() {
        showResultGame = true;
      });
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  List<String> brickPaperNum = [
    AssetsPath.brick,
    AssetsPath.paper,
    AssetsPath.scissors,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ConfigSize.defaultSize! * 7,
      width: ConfigSize.defaultSize! * 7,
      child: showResultGame
          ? Image.asset(brickPaperNum[widget.randomNum])
          : SVGAImage(animationController),
    );
  }
}
