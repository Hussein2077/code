import 'dart:convert';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/navigation_service.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';

navigateFromNotification(RemoteMessage message) {
  Map<String, dynamic> data =  jsonDecode(message.data['data']);
  log('${message.data['data']}dattt');
  log('${ data['owner_id']}oooooo');
  String messageTypeDecode = jsonDecode(message.data['message-type']);
  switch (messageTypeDecode) {
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
      //todo navigate to this moment
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
          .pushNamed(Routes.familyProfile, arguments: data['family_id']);
      break;
    case "accept-agency-app":
      getIt<NavigationService>()
          .navigatorKey
          .currentState!
          .pushNamed(Routes.agencyScreen, arguments: MyDataModel.getInstance());
      break;
    case "charge-action-notifaction":
      getIt<NavigationService>().navigatorKey.currentState!.pushNamed(
            Routes.coins,arguments: data['coins']??""
          );
      break;
    case "ban-user":
    case "remove-ban-user":
      //todo which navigate
      break;
    case "vips":
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
      case "send-notification-withImage":
      getIt<NavigationService>()
          .navigatorKey
          .currentState!
          .pushNamed(Routes.myBag, arguments: MyDataModel.getInstance());
      break;
      case "achieve-target":
      getIt<NavigationService>()
          .navigatorKey
          .currentState!
          .pushNamed(Routes.myBag, arguments: MyDataModel.getInstance());
      break;
      case "achieve-target-monthly":
      getIt<NavigationService>()
          .navigatorKey
          .currentState!
          .pushNamed(Routes.myBag, arguments: MyDataModel.getInstance());
      break;
    case "live-time-users-tokens-data":
      getIt<NavigationService>()
          .navigatorKey
          .currentState!
          .pushNamed(Routes.myBag, arguments: MyDataModel.getInstance());
      break;
  }
}
