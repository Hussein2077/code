import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resours_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/widgets/screen_back_ground.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 4), () {
      Navigator.pushNamed(context, Routes.login);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackGround(
        image: AssetsPath.splashBackGround,
        child: Column(
          children: [
            const Spacer(flex: 10),
            Image.asset(
              AssetsPath.iconAppWithTitle,
              scale: 2.5,
            ),
            const Spacer(
              flex: 1,
            ),
            const Text(
              StringManager.broadcastYourMoment,
              style:  TextStyle(
      fontFamily: 'ElMessiri',
      fontSize: 12,
      color: Colors.white,
    ), 
            ),
            const Spacer(
              flex: 10,
            ),
          ],
        ),
      ),
    );
  }
}
