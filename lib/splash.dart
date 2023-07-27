import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/screen_back_ground.dart';
import 'package:tik_chat_v2/features/home/data/model/config_model.dart';
import 'package:tik_chat_v2/features/home/domin/use_case/get_confige_uc.dart';

class SplashScreen extends StatefulWidget {
  static bool isDark = false ; 
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String errorMessage = "" ;
  ConfigModel configModel = const ConfigModel();

  @override
  void initState() {
    
        loadResources();

    Timer(const Duration(seconds: 4), () {
        if((configModel.isForce??false)){
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.login, (route) => false,
                  // arguments: LoginPramiter(
                  //     isForceUpdate: configModel.isForce,
                  //     isUpdate: true)
                      );
            }
            else if (!(configModel.isLastVersion??false)
                &&(configModel.isAuth??false)){
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.mainScreen, (route) => false ,
                  // arguments:MainPramiter(
                  //     isUpdate:true,
                  //     isCachEmojie: configModel.updateEmojieCach,
                  //     isCachEntro: configModel.updateEntroCach,
                  //     isCachExtra: configModel.updateExtraCach,
                  //     isCachFrame: configModel.updateFrameCach,
                  //     isChachGift: configModel.updateGiftCache
                  // )
                   );
            }
            else if(!(configModel.isAuth??false)){
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.login, (route) => false,
                  // arguments: const  LoginPramiter(
                  // isForceUpdate: false,
                  // isUpdate:false)
                  );
            }
            else if ((configModel.isAuth??false)){
        
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.mainScreen, (route) => false ,
                  // arguments:MainPramiter(
                  //     isUpdate:false,
                  //     isCachEmojie: configModel.updateEmojieCach,
                  //     isCachEntro: configModel.updateEntroCach,
                  //     isCachExtra: configModel.updateExtraCach,
                  //     isCachFrame: configModel.updateFrameCach,
                  //     isChachGift: configModel.updateGiftCache
                  // )
                   );
            }
      // Navigator.pushNamed(context, Routes.login);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
        ConfigSize().init(context);

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














  Future<void> loadResources() async {
    
    final result = await GetConfigeAppUseCase(
        homeRepo: getIt()).call(ConfigModelBody(
        appVersion: StringManager.versionApp.toString(),
    ));
    result.fold((l) => configModel =l,
            (r) => errorMessage = DioHelper().getTypeOfFailure(r));



  }

}
