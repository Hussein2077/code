import 'dart:developer';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:tik_chat_v2/core/error/exceptions.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/error/failures_string.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';

class DioHelper {

  Future<Map<String, String>> header() async {
    String key = await Methods().getlocalization();
    String token = await Methods().returnUserToken();
    if(kDebugMode){
      log(token);
    }


    final devicedata = await initPlatformState();
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "device": devicedata??'noToken',
      "X-localization": key
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

    return deviceId ;
  }


  String getTypeOfFailure(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return Strings.serverFailureMessage;
      case UnauthorizedFailure:
        return Strings.unauthorizedFailureMassage;
      case SiginGoogleFailure:
        return Strings.signinGoogleFailureMessage;
      case SiginFacebookFailure:
        return Strings.signinFacebookFailureMessage;
      case InternetFailure:
        return Strings.checkYourInternet;
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
      case InternetException:
        return InternetFailure();
      case ErrorModelException:
        return ErrorMessageFailure(message: e.errorMessage);
      default:
        return ErrorMessageFailure(message: e.message);
    }
  }

  static dynamic handleDioError(DioError dioError) {
    log('handleDioError: ${dioError.type}');
    switch (dioError.type) {
      case DioErrorType.response:
        throw handleStatuesCodeResponse(dioError.response);
      case DioErrorType.other:
        throw InternetException();
      case DioErrorType.cancel:
        throw handleStatuesCodeResponse(dioError.response);

      case DioErrorType.receiveTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.connectTimeout:
        throw ConnectionTimeoutException();
    }
  }

  static Exception handleStatuesCodeResponse(Response? response) {
    log("statescode${response?.statusCode}");
    log("errore respomse ${response?.data}");
    switch (response?.statusCode) {
      case 500:
        throw ServerException();
      case 401:
        throw UnauthorizedException();

      default:
        if(response?.data.runtimeType == String){
          throw ErrorModelException(errorMessage: response!.data);
        }else{
          throw ErrorModelException.fromJson(response!.data);
        }
    }
  }

}
