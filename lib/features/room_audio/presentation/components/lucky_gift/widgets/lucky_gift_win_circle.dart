
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class LuckyGiftWinCircle extends StatefulWidget {
  static String winCoin = '0';

  // static late AnimationController animationController;

  const LuckyGiftWinCircle({Key? key}) : super(key: key);

  @override
  _LuckyGiftWinCircleState createState() => _LuckyGiftWinCircleState();
}

class _LuckyGiftWinCircleState extends State<LuckyGiftWinCircle>
    with SingleTickerProviderStateMixin {

  // late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();


    // LuckyGiftWinCircle.animationController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 100),
    // );
    // _scaleAnimation = Tween<double>(begin: 0.89, end: 1.0).animate(
    //   CurvedAnimation(
    //     parent: LuckyGiftWinCircle.animationController,
    //     curve: Curves.bounceOut,
    //   ),
    // );
    // LuckyGiftWinCircle.animationController.forward();

  }



  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
          width: ConfigSize.defaultSize! * 25,
          height: ConfigSize.defaultSize! * 25,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image:
              DecorationImage(image: AssetImage(AssetsPath.luckyGiftBox))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${StringManager.win.tr()} ",
                style: TextStyle(
                    fontSize: ConfigSize.defaultSize! * 1.6,
                    color: const Color.fromARGB(255, 255, 191, 54),
                    decoration: TextDecoration.none),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${LuckyGiftWinCircle.winCoin} ",
                    style: TextStyle(
                        fontSize: ConfigSize.defaultSize! * 2,
                        color: const Color.fromARGB(255, 255, 191, 54),
                        decoration: TextDecoration.none),
                  ),
                  Image.asset(AssetsPath.goldCoin)
                ],
              )
            ],
          ),
        );
  }
}
