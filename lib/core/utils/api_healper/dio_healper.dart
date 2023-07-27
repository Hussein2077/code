import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:tik_chat_v2/core/error/exceptions.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/error/failures_string.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';

class DioHelper {
  Future<Map<String, String>> header() async {
    String key = await Methods().getlocalization();
    String token = await Methods().returnUserToken();
    log(token);

    final devicedata = await initPlatformState(); // to get information device
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "device": devicedata,
      "X-localization": key
    };
    return headers;
  }

  Future<String> initPlatformState() async {
    AndroidDeviceInfo deviceAndroidData;
    IosDeviceInfo deviceIosData;
    String deviceToken = '';
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        Methods().setPlatform(platForm: StringManager.android);
        deviceAndroidData = await deviceInfoPlugin.androidInfo;
        deviceToken = deviceAndroidData.fingerprint;
        return deviceToken;
      } else if (Platform.isIOS) {
        Methods().setPlatform(platForm: StringManager.iphone);
        deviceIosData = await deviceInfoPlugin.iosInfo;
        deviceToken = deviceIosData.identifierForVendor ?? 'noIosDeviceToken';
        return deviceToken;
      } else {
        deviceToken = 'noDeviceToken';
        return deviceToken;
      }
    } on PlatformException {
      deviceToken = 'noDeviceToken';
      throw ServerException();
    }
  }

  Map<String, dynamic> readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'serialNumber': build.serialNumber,
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
      'displaySizeInches':
          ((build.displayMetrics.sizeInches * 10).roundToDouble() / 10),
      'displayWidthPixels': build.displayMetrics.widthPx,
      'displayWidthInches': build.displayMetrics.widthInches,
      'displayHeightPixels': build.displayMetrics.heightPx,
      'displayHeightInches': build.displayMetrics.heightInches,
      'displayXDpi': build.displayMetrics.xDpi,
      'displayYDpi': build.displayMetrics.yDpi,
    };
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
        return failure.errorMessage ?? StringManager.unexcepectedError;
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
    log(response!.data.toString());
    log("statescode${response.statusCode}");
    switch (response.statusCode) {
      case 500:
        throw ServerException();
      case 401:
        throw UnauthorizedException();
      default:
        throw ErrorModelException.fromJson(response.data);
    }
  }
}
