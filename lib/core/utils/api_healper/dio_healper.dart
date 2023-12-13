import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:tik_chat_v2/core/error/exceptions.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/error/failures_string.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/main.dart';

class DioHelper {
  Future<Map<String, String>> header() async {
    String key = await Methods.instance.getLocalization();
    String token = await Methods.instance.returnUserToken();

    if (kDebugMode) {
      log(token + "######");
      log(key + "lang");
    }
    final devicedata = await initPlatformState();
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "device": devicedata ?? 'noToken',
      "Accept": 'application/json',
      "X-localization": key,
    };
    return headers;
  }

  Future<String?> initPlatformState() async {
    String? deviceId;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
    } on PlatformException {
      deviceId = 'Failed to get deviceId';
    }

    return deviceId;
  }

  String getTypeOfFailure(
    Failure failure,
  ) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return Strings.serverFailureMessage.tr();
      case UnauthorizedFailure:
        Navigator.pushNamedAndRemoveUntil(
            navigatorKey.currentContext!,
            Routes.login,
            (Route<dynamic> route) => false,
            arguments: const LoginPramiter(
                isLoginFromAnotherAccountAndBuildFailure: false));

        return Strings.unauthorizedFailureMassage.tr();
      case SiginGoogleFailure:
        return Strings.signinGoogleFailureMessage.tr();
      case SiginFacebookFailure:
        return Strings.signinFacebookFailureMessage.tr();
      case SiginAppleFailure:
        return Strings.signinAppleFailureMessage.tr();
      case InternetFailure:
        return Strings.checkYourInternet.tr();
      case AnotherAccountMessageFailure:
        Navigator.pushNamedAndRemoveUntil(
            navigatorKey.currentContext!,
            Routes.login,
            (Route<dynamic> route) => false,
            arguments: const LoginPramiter(
                isLoginFromAnotherAccountAndBuildFailure: true));
        return Strings.anotherAccountLoggedIn.tr();
      case SiginHuaweiFailure:
        return Strings.signinHuaweiFailureMessage.tr();
      case BanFailure:
        // log("ModalRoute.of(GlobalContextService.navigatorKey.currentContext!)?.settings.name${ModalRoute.of(GlobalContextService.navigatorKey.currentContext!)?.settings.name}");
        // if(ModalRoute.of(GlobalContextService.navigatorKey.currentContext!)?.settings.name == null){
        //   showDialog(
        //       context: GlobalContextService.navigatorKey.currentContext!,
        //       builder: (context) {
        //         return PopUpDialog(
        //           headerText:failure.errorMessage??"",
        //           accpetText: () {
        //             Navigator.pop(context);
        //           },
        //           accpettitle: StringManager.ok.tr(),
        //         );
        //       });
        // }else{
        //   Navigator.pushNamedAndRemoveUntil(
        //       GlobalContextService.navigatorKey.currentContext!,
        //       Routes.login,
        //           (Route<dynamic> route) => false,
        //       arguments:   LoginPramiter(isBaned: true,error:failure.errorMessage??"" ));
        // }
        return failure.errorMessage??"";
      default:
        return failure.errorMessage ?? StringManager.unexcepectedError.tr();
    }
  }

  static Failure buildFailure(dynamic e, {String? message1}) {
    switch (e.runtimeType) {
      case ServerException:
        return ServerFailure();
      case UnauthorizedException:
        return UnauthorizedFailure();
      case SiginFacebookException:
        return SiginFacebookFailure();
      case SiginGoogleException:
        return SiginGoogleFailure();
      case SiginAppleException:
        return SiginAppleFailure();
      case InternetException:
        return InternetFailure();
      case AnotherAccountException:
        return AnotherAccountMessageFailure();
      case SiginHuaweiException:
        return SiginHuaweiFailure();
      case ErrorModelException:
        return ErrorMessageFailure(message: e.errorMessage);
      case BanException:
        return BanFailure(message: e.errorMessage??"");
      default:
        return ErrorMessageFailure(message: e.toString());
    }
  }

  static dynamic handleDioError({DioError? dioError, String? endpointName}) {
    if (kDebugMode) {
      log("dioError${dioError?.message}");
      log('endpointName$endpointName');
    }

    switch (dioError!.type) {
      case DioErrorType.response:
        throw handleStatuesCodeResponse(
            response: dioError.response, endpointName: endpointName);
      case DioErrorType.other:
        throw InternetException();
      case DioErrorType.cancel:
        throw handleStatuesCodeResponse(
            response: dioError.response, endpointName: endpointName);

      case DioErrorType.receiveTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.connectTimeout:
        throw ConnectionTimeoutException();
    }
  }

  static Exception handleStatuesCodeResponse(
      {Response? response, String? endpointName}) {
    if (kDebugMode) {
      log("endpointName =$endpointName");
      log("statescode${response?.statusCode}");
      log("errore respomse${response?.data}");
    }
    switch (response?.statusCode) {
      case 500:
        throw ServerException();
      case 401:
        throw UnauthorizedException();
      //todo change this
      case 5555:
        throw AnotherAccountException();
      case 501:
        throw BanException.fromJson(response?.data);
      default:
        if (response?.data.runtimeType == String) {
          throw ErrorModelException(errorMessage: response!.data);
        } else {
          throw ErrorModelException.fromJson(response!.data);
        }
    }
  }
}
