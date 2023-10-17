

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/gifts/widgets/gift_bottom_bar.dart';

import '../../../../../../../core/utils/config_size.dart';


class NormalCandy extends StatefulWidget {
  final  void Function(int?) sendGift ;
  const NormalCandy({required this.sendGift, Key? key}) : super(key: key);

  @override
  NormalCandyState createState() => NormalCandyState();
}

class NormalCandyState extends State<NormalCandy>with TickerProviderStateMixin {
  int compo = 1;
  Timer? timer;
  Timer? timerDuration;
  late final AnimationController animationController;

  double percent = 0;



  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
    showWidget();
    super.initState();
  }
  @override
   void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (compo != 0)
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                    text: 'Compo X  ',
                    style: TextStyle(color: Colors.white)),
                TextSpan(
                    text: compo.toString(),
                    style: const TextStyle(color: Colors.yellow)),
              ],
            ),
          ),
        SizedBox(
          width: ConfigSize.defaultSize! * 2,
        ),
        InkWell(
          onTap: () {
            setState(() {
              if (timerDuration != null) {
                timerDuration!.cancel();
              }
              showWidget();
              percent = 0;
              compo++;
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: [

              RotationTransition(

                turns: animationController,
                child: Container(
                  width: ConfigSize.defaultSize! *7.8,
                  height: ConfigSize.defaultSize! * 7.8,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(
                            AssetsPath.sweetCandy,
                          ),
                          fit: BoxFit.fill)),
                ),
              ),
              CircularPercentIndicator(
                radius: ConfigSize.defaultSize! * 3.4,
                lineWidth: 3,
                animation: true,
                curve: Curves.ease,
                animateFromLastPercent: true,
                addAutomaticKeepAlive: true,
                percent: percent<1?percent:1,
                backgroundColor: Colors.grey,
                progressColor: Colors.yellow,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void showWidget() {

    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer.periodic(const Duration(milliseconds:1 ), (timer) {
      setState(() {
        percent = percent + 0.0017;
      });
    });
    timerDuration = Timer(const Duration(milliseconds:2500 ), () {
      setState(() {
        if (compo != 0) {
         widget.sendGift(compo);
        }
        timer!.cancel();
        percent = 0;
        compo = 0;
        GiftBottomBar.typeCandy.value = TypeCandy.non;
      });
    });




    GiftBottomBar.typeCandy.value = TypeCandy.normalCandy;


  }
}
