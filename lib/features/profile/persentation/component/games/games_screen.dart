// ignore_for_file: must_be_immutable, use_build_context_synchronously, unnecessary_brace_in_string_interps

import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/widgets/force_rotate_widget.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pageView_games/dialog_games.dart';

class GamesScreen extends StatelessWidget {
  GamesScreen({super.key});


  List<String> gamesImages= [
    AssetsPath.teenPatti,
    AssetsPath.roulette,
    AssetsPath.carRace,
    AssetsPath.updown,
    AssetsPath.ludo,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWithOnlyTitle(title: StringManager.games.tr()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1.4,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: gamesImages.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: (){
                        joinToGames(index, context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage(gamesImages[index]),
                                fit: BoxFit.fill
                            )
                        ),
                      ),
                    ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  StringManager.gameroom,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                      color: const Color(0xff1B181F),
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    heightFactor: 1.9,
                    child: Image.asset(fit: BoxFit.cover, AssetsPath.comingSoon),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  void joinToGames(int index, BuildContext context)async {
    String token = await Methods.instance.returnUserToken() ;
    if(index==0){
      log("url${StringManager.teenPatti}${token}");

      Navigator.push(context,
          MaterialPageRoute(builder: ((context) => const ForceRotateWidget(widget: WebViewInRoom(url: 'http://167.172.6.20/Test/Tik-Chat-Seven-full/index.html?token=694|SbQAJQ2rGaE0BVxfa0NC6XGcwFH3EeodH6xaIHE6fa8214a0&sound=0&language=ar',),))));
     // Navigator.push(context, MaterialPageRoute(builder: ((context) => WebViewInRoom(url: 'http://167.172.6.20/Test/Tik-Chat-Seven-full/index.html?token=694|SbQAJQ2rGaE0BVxfa0NC6XGcwFH3EeodH6xaIHE6fa8214a0&sound=0&language=ar',))));

    }else if(index ==1){
      log("url${StringManager.roulette}${token}");
      Navigator.push(context, MaterialPageRoute(builder: ((context) => WebViewInRoom(url: '${StringManager.roulette}${token}',))));

    }else if(index==2){
      log("url${StringManager.carRace}${token}");
      Navigator.push(context, MaterialPageRoute(builder: ((context) => WebViewInRoom(url: '${StringManager.carRace}${token}',))));

    }else if (index ==3){
      log("url${StringManager.updown}${token}");
      Navigator.push(context, MaterialPageRoute(builder: ((context) => WebViewInRoom(url: '${StringManager.updown}${token}',))));

    }else if(index ==4){
      log("url${StringManager.ludo}${token}");
      Navigator.push(context, MaterialPageRoute(builder: ((context) => WebViewInRoom(url: '${StringManager.ludo}${token}',))));

    }
  }

}
