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
  bool? isLoginFromAnotherAccountAndBuildFailure = false;

  Future<Map<String, String>> header() async {
    String key = await Methods().getLocalization();
    String token = await Methods().returnUserToken();

    if (kDebugMode) {
      log(token);

    }
    log('$key log(key)');
    final devicedata = await initPlatformState();
    log(devicedata.toString());
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      // "device": devicedata??'noToken',
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
        return Strings.serverFailureMessage;
      case UnauthorizedFailure:
        Navigator.pushNamedAndRemoveUntil(
            GlobalContextService.navigatorKey.currentContext!,
            Routes.login,
            (Route<dynamic> route) => false,
            arguments: LoginPramiter(
                isLoginFromAnotherAccountAndBuildFailure:
                isLoginFromAnotherAccountAndBuildFailure = false));

        return Strings.unauthorizedFailureMassage;
      case SiginGoogleFailure:
        return Strings.signinGoogleFailureMessage;
      case SiginFacebookFailure:
        return Strings.signinFacebookFailureMessage;
      case SiginAppleFailure:
        return Strings.signinAppleFailureMessage;
      case InternetFailure:
        return Strings.checkYourInternet;
      case AnotherAccountMessageFailure:
        Navigator.pushNamedAndRemoveUntil(
            GlobalContextService.navigatorKey.currentContext!,
            Routes.login,
                (Route<dynamic> route) => false,
            arguments: LoginPramiter(
                isLoginFromAnotherAccountAndBuildFailure:
                isLoginFromAnotherAccountAndBuildFailure = true));
        return Strings.anotherAccountLoggedIn;
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
      case ErrorModelException:
        return ErrorMessageFailure(message: e.errorMessage);

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
      case 402:
        throw AnotherAccountException();
      default:
        if (response?.data.runtimeType == String) {
          throw ErrorModelException(errorMessage: response!.data);
        } else {
          throw ErrorModelException.fromJson(response!.data);
        }
    }
  }
}
