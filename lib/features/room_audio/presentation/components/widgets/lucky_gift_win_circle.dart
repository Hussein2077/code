
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class LukyGiftWinCircle extends StatefulWidget {
  static String winCoin = '0';

  static late AnimationController animationController;

  const LukyGiftWinCircle({Key? key}) : super(key: key);

  @override
  _LukyGiftWinCircleState createState() => _LukyGiftWinCircleState();
}

class _LukyGiftWinCircleState extends State<LukyGiftWinCircle>
    with SingleTickerProviderStateMixin {

  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();


    LukyGiftWinCircle.animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 0.89, end: 1.0).animate(
      CurvedAnimation(
        parent: LukyGiftWinCircle.animationController,
        curve: Curves.bounceOut,
      ),
    );
    LukyGiftWinCircle.animationController.forward();

  }



  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
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
                    "${LukyGiftWinCircle.winCoin} ",
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
        ));
  }
}
