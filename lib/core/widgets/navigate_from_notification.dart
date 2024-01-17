import 'dart:convert';
import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/navigation_service.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/features/moment/presentation/componants/comments/moment_comments_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_vip_center/vip_center_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_vip_center/vip_center_events.dart';
import 'package:tik_chat_v2/features/reels/persentation/components/comments/comment_bottomsheet.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reel_comments/get_reel_comments_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reel_comments/get_reel_comments_event.dart';
import 'package:tik_chat_v2/main_screen/main_screen.dart';
import 'package:tik_chat_v2/splash.dart';

navigateFromNotification(RemoteMessage message) {
  Map<String, dynamic> data = jsonDecode(message.data['data']);

  log('${data}oooooo');
  String messageTypeDecode = jsonDecode(message.data['message-type']);
  switch (messageTypeDecode) {
    case 'send-notifaction':
      SplashScreen.initPage = 2 ;
      getIt<NavigationService>().navigatorKey.currentState!.pushNamed(
          Routes.mainScreen,
          );
      break ;
    case "enter-room":
      getIt<NavigationService>().navigatorKey.currentState!.pushNamed(
          Routes.roomHandler,
          arguments: RoomHandlerPramiter(
              ownerRoomId: data['owner_id'].toString(),
              myDataModel: MyDataModel.getInstance()));
      break;
    case "visit-profile":
      getIt<NavigationService>().navigatorKey.currentState!.pushNamed(
            Routes.vistorScreen,
          );
      break;
    case "follow":
      getIt<NavigationService>()
          .navigatorKey
          .currentState!
          .pushNamed(Routes.fff, arguments: StringManager.followers.tr());
      break;
    case "followBack":
      getIt<NavigationService>()
          .navigatorKey
          .currentState!
          .pushNamed(Routes.fff, arguments: StringManager.friends.tr());
      break;
    case "system-msg":
      getIt<NavigationService>().navigatorKey.currentState!.pushNamed(
            Routes.messages,
          );
      break;
    case "send-moment-gift":
      whenNavigateToMoment(data);
      getIt<NavigationService>().navigatorKey.currentState!.pushNamed(
            Routes.mainScreen,
          );
      break;
    case "mall-send":
      getIt<NavigationService>()
          .navigatorKey
          .currentState!
          .pushNamed(Routes.myBag, arguments: MyDataModel.getInstance());
      break;

    case "request-join-family":
      getIt<NavigationService>().navigatorKey.currentState!.pushNamed(
          Routes.familyRequests,
          arguments: data['family_id'].toString());
      break;
    case "accept-user-family":
    case "family":
      getIt<NavigationService>()
          .navigatorKey
          .currentState!
          .pushNamed(Routes.familyRanking, arguments: data['family_id']);
      break;
    case "accept-agency-app":
      getIt<NavigationService>()
          .navigatorKey
          .currentState!
          .pushNamed(Routes.agencyScreen, arguments: MyDataModel.getInstance());
      break;
    case "charge-action-notifaction":
      getIt<NavigationService>()
          .navigatorKey
          .currentState!
          .pushNamed(Routes.coins, arguments: data['coins'] ?? "");
      break;
    case "ban-user":
    case "remove-ban-user":
  //no navigate here, this is my decision don't navigate.
      break;
    case "vips":
      BlocProvider.of<VipCenterBloc>(
          getIt<NavigationService>().navigatorKey.currentContext!)
          .add(GetVipCenterEvent());
      getIt<NavigationService>().navigatorKey.currentState!.pushNamed(
            Routes.vip,
          );
      break;
    case "family-level-upgrade":
      getIt<NavigationService>()
          .navigatorKey
          .currentState!
          .pushNamed(Routes.familyProfile, arguments: data['family_id']);
      break;
    case "ware-vip":
      getIt<NavigationService>()
          .navigatorKey
          .currentState!
          .pushNamed(Routes.myBag, arguments: MyDataModel.getInstance());
      break;
    case "achieve-target":
    case "achieve-target-monthly":
      getIt<NavigationService>().navigatorKey.currentState!.pushNamed(
            Routes.incomeScreen,
          );
      break;
    case "live-time-users-tokens-data":
      //todo what it navigate
      break;
    case "moment-comment":
      whenNavigateToMoment(data);
      getIt<NavigationService>().navigatorKey.currentState!.pushNamed(
            Routes.mainScreen,
          );
      Future.delayed(const Duration(seconds: 3), () {
        bottomDailog(
            context: getIt<NavigationService>().navigatorKey.currentContext!,
            height: ConfigSize.screenHeight! * .7,
            widget: MomentCommentsScreen(
              momentId: data['moment_id'].toString(),
            ),
            color: Theme.of(
                    getIt<NavigationService>().navigatorKey.currentContext!)
                .colorScheme
                .background);
      });
      break;
    case "like moment":
      whenNavigateToMoment(data);
      getIt<NavigationService>().navigatorKey.currentState!.pushNamed(
            Routes.mainScreen,
          );
      break;
    case "like-real":
      whenNavigateToReels(data);
      getIt<NavigationService>().navigatorKey.currentState!.pushNamed(
            Routes.mainScreen,
          );
      break;
    case "real-comment":
      whenNavigateToReels(data);
      getIt<NavigationService>().navigatorKey.currentState!.pushNamed(
            Routes.mainScreen,
          );
      Future.delayed(const Duration(seconds: 3), () {
        BlocProvider.of<GetReelCommentsBloc>(
          getIt<NavigationService>().navigatorKey.currentContext!,
        ).add(GetReelsCommentsEvent(reelId: data['real_id'].toString()));
        showModalBottomSheet(
            barrierColor: Colors.transparent,
            context: getIt<NavigationService>().navigatorKey.currentContext!,
            builder: (ctx) {
              return CommentBottomSheet(
                reelId: data['real_id'].toString(),
              );
            });
      });
      break;
  }
}

whenNavigateToMoment(Map<String, dynamic> data) {
  SplashScreen.initPage = 4;
  MainScreen.momentId = data['moment_id'].toString();
}

whenNavigateToReels(Map<String, dynamic> data) {
  SplashScreen.initPage = 1;
  MainScreen.reelId = data['real_id'].toString();
}
