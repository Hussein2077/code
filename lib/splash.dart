import 'dart:async';
import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/screen_back_ground.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/home/data/model/config_model.dart';
import 'package:tik_chat_v2/features/home/domin/use_case/get_confige_uc.dart';
import 'package:tik_chat_v2/main_screen/main_screen.dart';

class SplashScreen extends StatefulWidget {
  static bool isDark = false;

  static int initPage = 0;
  static Uri? dynamicLink;

  const SplashScreen({super.key});

  static String? appSign;

  static int? appId;

  static late String devicePlatform;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String errorMessage = "";

  ConfigModel? configModel;

  @override
  void initState() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      SplashScreen.devicePlatform = StringManager.androidPlatform;
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      SplashScreen.devicePlatform = StringManager.iOSPlatform;
    }
    Methods().getCurrentTimeZone();
    loadResources().then((value) async {
      if (configModel == null) {
        errorToast(
            context: context, title: StringManager.unexcepectedError.tr());
      } else if ((configModel!.isForce ?? false)) {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.login, (route) => false,
            arguments: LoginPramiter(
                isForceUpdate: configModel!.isForce, isUpdate: true));
      } else if (!(configModel!.isLastVersion ?? false) &&
          (configModel!.isAuth ?? false)) {
        await initDynamicLinks();
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.mainScreen, (route) => false,
            arguments: MainPramiter(
                isUpdate: true,
                isCachEmojie: configModel!.updateEmojieCach,
                isCachEntro: configModel!.updateEntroCach,
                isCachExtra: configModel!.updateExtraCach,
                isCachFrame: configModel!.updateFrameCach,
                isChachGift: configModel!.updateGiftCache,
                actionDynamicLink: SplashScreen.dynamicLink));
      } else if (!(configModel!.isAuth ?? false)) {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.login, (route) => false,
            arguments:
                const LoginPramiter(isForceUpdate: false, isUpdate: false));
      } else if ((configModel!.isAuth ?? false)) {
        await initDynamicLinks();
        log("SplashScreen.dynamicLink" + SplashScreen.dynamicLink.toString());
        if (kDebugMode) {
          log("configModel1${configModel!.updateEntroCach}");
          log("configModel1${configModel!.updateGiftCache}");
          log("configModel1${configModel!.updateFrameCach}");
          log("configModel1${configModel!.updateExtraCach}");
          log("configModel1${configModel!.updateEmojieCach}");
        }
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.mainScreen, (route) => false,
            arguments: MainPramiter(
                isUpdate: false,
                isCachEmojie: configModel!.updateEmojieCach,
                isCachEntro: configModel!.updateEntroCach,
                isCachExtra: configModel!.updateExtraCach,
                isCachFrame: configModel!.updateFrameCach,
                isChachGift: configModel!.updateGiftCache,
                actionDynamicLink: SplashScreen.dynamicLink));
      }
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
            Text(
              StringManager.broadcastYourMoment.tr(),
              style: const TextStyle(
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

  initDynamicLinks() async {
    final _appLinks = AppLinks();

    SplashScreen.dynamicLink = await _appLinks.getLatestAppLink();

    if (SplashScreen.dynamicLink != null) {
      await handleDeepLink(SplashScreen.dynamicLink);
    }
  }

  Future<void> handleDeepLink(Uri? data) async {
    final Uri? deepLink = data;
    final String? action = deepLink?.queryParameters['action'];
    final String? reelId = deepLink?.queryParameters['reel_id'];

    log('action$action');
    if (action == 'show_reel') {
      log("handleDeepLink reelId $reelId");
      showReelDynamicLink(reelId: reelId);
    }
  }

  void showReelDynamicLink({String? reelId}) {
    MainScreen.reelId = reelId ?? '';
    SplashScreen.initPage = 1;
    log("in show reel2");
  }

  Future<void> loadResources() async {
    final result =
        await GetConfigeAppUseCase(homeRepo: getIt()).call(ConfigModelBody(
      appVersion: StringManager.versionApp.toString(),
      devicePlatform: SplashScreen.devicePlatform,
    ));
    result.fold((l) {
      SplashScreen.appId = l.appId;
      SplashScreen.appSign = l.appSign;
      configModel = l;
    }, (r) => errorMessage = DioHelper().getTypeOfFailure(r));
  }
}
