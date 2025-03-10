import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:huawei_account/huawei_account.dart';
import 'package:tik_chat_v2/core/error/exceptions.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/features/auth/data/model/auth_with_apple_model.dart';
import 'package:tik_chat_v2/features/auth/data/model/auth_with_google_model.dart';
import 'package:tik_chat_v2/features/auth/data/model/auth_with_huawei_model.dart';
import 'package:tik_chat_v2/features/auth/data/model/country_model.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/add_info_use_case.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/register_with_phone_usecase.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

abstract class BaseRemotlyDataSource {
  Future<MyDataModel> registerWithCodeAndPhone(AuthPramiter authPramiter);
  Future<Unit> resendCode(String uuid);
  Future<MyDataModel> loginWithPassAndPhone(AuthPramiter authPramiter);
  Future<MyDataModel> addInformation(InformationPramiter informationPramiter);
  //Future<MyDataModel> sigInWithFacebook();
  Future<AuthWithAppleModel> sigInWithApple();
  Future<AuthWithGoogleModel> sigInWithGoogle();
  Future<AuthWithHuaweiModel> sigInWithHuawei();
  Future<String> logOut();
  Future<String> privacyPolicy();
  Future<String> deleteAccount();
  Future<GetAllCountriesBase> getAllCountries();
  Future<String> forgetPassword(
      {required String phone, required String password, required String code});
  Future<String> forgetPasswordCodeVerification(
      {required String phone, required String code});


}




class RemotlyDataSource extends BaseRemotlyDataSource {
  @override
  Future<Unit> resendCode(String phone) async {
    final body = {"phone": phone};
    try {
      await Dio().post(
        ConstentApi.sendCodeUrl,
        data: body,
      );
      return Future.value(unit);
    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e, endpointName: "resendCode");
    }
  }

  @override
  Future<MyDataModel> registerWithCodeAndPhone(
      AuthPramiter authPramiter) async {
    final body = {
      ConstentApi.phone: authPramiter.phone,
      ConstentApi.password: authPramiter.password,
      ConstentApi.code: authPramiter.code,
    };
    try {
      final response = await Dio().post(
        ConstentApi.signUpUrl,
        data: body,
      );
      Map<String, dynamic> jsonData = response.data;

      MyDataModel userData = MyDataModel.fromMap(jsonData);
      Methods.instance.saveUserToken(authToken: jsonData['data']['auth_token']);
      return userData;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "registerWithCodeAndPhone");
    }
  }

  @override
  Future<MyDataModel> loginWithPassAndPhone(AuthPramiter authPramiter) async {
    final devicedata =
        await DioHelper().initPlatformState(); // to get information device

    final body = {
      ConstentApi.type: ConstentApi.phonePass,
      ConstentApi.phone: authPramiter.phone,
      ConstentApi.password: authPramiter.password,
      'device_token': devicedata
    };
    Map<String, String> headers = await DioHelper().header();

    try {
      final response = await Dio().post(
        options: Options(headers: headers),
        ConstentApi.loginUrl,
        data: body,
      );
      Map<String, dynamic> jsonData = response.data;

      MyDataModel userData = MyDataModel.fromMap(jsonData['data']);
      Methods.instance.saveUserToken(authToken: userData.authToken);

      return userData;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "loginWithPassAndPhone");
    }
  }

  @override
  Future<MyDataModel> addInformation(
      InformationPramiter informationPramiter) async {
    FormData formData;

    if (informationPramiter.image == null) {
      formData = FormData.fromMap({
        'bio': informationPramiter.bio,
        ConstentApi.name: informationPramiter.name,
        ConstentApi.birthday: informationPramiter.date,
        "gender": informationPramiter.gender!,
        'country_id': informationPramiter.countryID,
        if (informationPramiter.email != null)
          "email": informationPramiter.email.toString()
      });
    } else {
      File file = informationPramiter.image!;
      String fileName = file.path.split('/').last;

      formData = FormData.fromMap({
        'bio': informationPramiter.bio,
        "image": await MultipartFile.fromFile(file.path, filename: fileName),
        ConstentApi.name: informationPramiter.name,
        ConstentApi.birthday: informationPramiter.date,
        "gender": informationPramiter.gender!,
        'country_id': informationPramiter.countryID,
        if (informationPramiter.email != null)
          "email": informationPramiter.email
      });
    }

    Map<String, String> headers = await DioHelper().header();

    try {
      final response = await Dio().post(
        ConstentApi.editeUrl,
        data: formData,
        options: Options(headers: headers),
      );

      // MyDataModel userData =
      //     MyDataModel.fromMap(response.data[ConstentApi.data]);

      Methods.instance.saveMyData();
      return MyDataModel();
    } on DioError catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "addInformation");
    }
  }

  @override
  Future<AuthWithGoogleModel> sigInWithGoogle() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _googleSignIn = GoogleSignIn(scopes: ['email']);
    Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

    // // ignore: unused_element
    // Future logout() => _googleSignIn.disconnect();
    final userModel = await login();

    final devicedata =
        await DioHelper().initPlatformState(); // to get information device
    Map<String, String> headers = await DioHelper().header();

    if (userModel == null) {
      throw SiginGoogleException();
    } else {
      final body = {
        ConstentApi.type: "google",
        ConstentApi.name: userModel.displayName,
        "google_id": userModel.id,
        'device_token': devicedata
      };
      try {
        final response = await Dio().post(
          ConstentApi.loginUrl,
          data: body,
          options: Options(
            headers: headers,
          ),
        );

        Map<String, dynamic> resultData = response.data;

        MyDataModel userData = MyDataModel.fromMap(resultData['data']);

        Methods.instance.saveUserToken(authToken: userData.authToken);

        return AuthWithGoogleModel(apiUserData: userData, userData: userModel);
      } on DioError catch (e) {
        throw DioHelper.handleDioError(
            dioError: e, endpointName: "sigInWithGoogle");
      }
    }
  }

  @override
  Future<AuthWithAppleModel> sigInWithApple() async {
    final AuthorizationCredentialAppleID? credential;
    try {
      credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
    } catch (e) {
      log(e.toString());
      throw SiginAppleException();
    }
    final devicedata =
        await DioHelper().initPlatformState(); // to get information device
    Map<String, String> headers = await DioHelper().header();

    final body = {
      ConstentApi.type: "apple",
      ConstentApi.name: credential.givenName,
      "apple_id": credential.authorizationCode,
      'user_id': credential.userIdentifier,
      'device_token': devicedata
    };
    try {
      final response = await Dio().post(
        ConstentApi.loginUrl,
        data: body,
        options: Options(
          headers: headers,
        ),
      );

      Map<String, dynamic> resultData = response.data;

      MyDataModel userData = MyDataModel.fromMap(resultData['data']);

      Methods.instance.saveUserToken(authToken: userData.authToken);

      return AuthWithAppleModel(apiUserData: userData, userData: credential);
    } on DioError catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: 'sigInWithApple');
    }
  }

  // @override
  // Future<MyDataModel> sigInWithFacebook() async {
  //   final LoginResult result =
  //       await FacebookAuth.i.login(permissions: ['email']);
  //   if (result.status == LoginStatus.success) {
  //     final data = await FacebookAuth.i.getUserData();

  //     // to get device info
  //     UserPlatformModel model = UserPlatformModel.fromJson(data);
  //     final devicedata = await DioHelper().initPlatformState();
  //     // final body ={} ;

  //     final body = {
  //       ConstentApi.type: "facebook",
  //       ConstentApi.name: model.name,
  //       "facebook_id": model.id,
  //       'device_token': devicedata
  //     };
  //     Map<String, String> headers = await DioHelper().header();

  //     final response = await Dio().post(
  //       ConstentApi.loginUrl,
  //       data: body,
  //       options: Options(
  //         headers: headers,
  //       ),
  //     );
  //     Map<String, dynamic> resultData = response.data;
  //     bool sussec = resultData["success"];
  //     if (sussec) {
  //       MyDataModel userData = MyDataModel.fromMap(resultData['data']);
  //       Methods.instance.saveUserToken(authToken: userData.authToken);
  //       return userData;
  //     } else {
  //       throw SiginFacebookException();
  //     }
  //   } else {
  //     throw SiginFacebookException();
  //   }
  // }

  @override
  Future<AuthWithHuaweiModel> sigInWithHuawei() async {
    final devicedata = await DioHelper().initPlatformState();
    Map<String, String> headers = await DioHelper().header();

    AccountAuthParamsHelper accountAuthParamsHelper =
        AccountAuthParamsHelper(AccountAuthParams.defaultAuthRequestParam);

    accountAuthParamsHelper.setProfile();

    accountAuthParamsHelper.setEmail();

    accountAuthParamsHelper.setIdToken();

    AccountAuthParams mAuthParam = accountAuthParamsHelper.createParams();

    AccountAuthService accountAuthService =
        AccountAuthManager.getService(mAuthParam);

    AuthAccount account = await accountAuthService.signIn();

    try {
      final body = {
        ConstentApi.type: "huawei",
        ConstentApi.name: account.displayName,
        "huawei_id": account.unionId,
        'device_token': devicedata
      };
      try {
        final response = await Dio().post(
          ConstentApi.loginUrl,
          data: body,
          options: Options(
            headers: headers,
          ),
        );

        Map<String, dynamic> resultData = response.data;

        MyDataModel userData = MyDataModel.fromMap(resultData['data']);

        Methods.instance.saveUserToken(authToken: userData.authToken);

        return AuthWithHuaweiModel(apiUserData: userData, userData: account);
      } on DioError catch (e) {
        throw DioHelper.handleDioError(
            dioError: e, endpointName: "sigInWithHuawei");
      }
    } on Exception catch (e) {
      throw SiginHuaweiException();
    }
  }

  @override
  Future<String> logOut() async {
    Map<String, String> headers = await DioHelper().header();

    try {
      final response = await Dio().post(
        ConstentApi.logOut,
        options: Options(
          headers: headers,
        ),
      );
      Map<String, dynamic> jsonData = response.data;

      return jsonData[ConstentApi.message];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(dioError: e, endpointName: 'logOut');
    }
  }

  @override
  Future<String> privacyPolicy() async {
    try {
      final response = await Dio().get(
        ConstentApi.privacyPolicy,
      );

      return response.data;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: 'privacyPolicy');
    }
  }

  @override
  Future<String> deleteAccount() async {
    Map<String, String> headers = await DioHelper().header();

    try {
      final response = await Dio().get(
        ConstentApi.deleteAccount,
        options: Options(
          headers: headers,
        ),
      );
      Map<String, dynamic> jsonData = response.data;

      return jsonData[ConstentApi.message];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: 'delete account');
    }
  }

  @override
  Future<GetAllCountriesBase> getAllCountries() async {
    Map<String, String> headers = await DioHelper().header();

    try {
      final response = await Dio().get(
        ConstentApi.getAllCountries,
        options: Options(
          headers: headers,
        ),
      );
      List<dynamic> jsonData = response.data;
      return GetAllCountriesBase.fromJson(jsonData);
    } on DioError catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: 'Get All Countries');
    }
  }

  @override
  Future<String> forgetPassword(
      {required String phone,
      required String password,
      required String code}) async {
    final body = {
      ConstentApi.phone: phone,
      ConstentApi.password: password,
      "code": code,
    };
    try {
      final response = await Dio().post(
        ConstentApi.forgetPassword,
        data: body,
      );
      Map<String, dynamic> jsonData = response.data;

      return jsonData[ConstentApi.message] ?? "";
    } on DioError catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: 'forgetPassword');
    }
  }

  @override
  Future<String> forgetPasswordCodeVerification(
      {required String phone, required String code}) async {
    final body = {
      ConstentApi.phone: phone,
      "code": code,
    };
    try {
      final response = await Dio().post(
        ConstentApi.forgetPasswordCodeVerification,
        data: body,
      );
      Map<String, dynamic> jsonData = response.data;

      return jsonData[ConstentApi.message] ?? "";
    } on DioError catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: 'forgetPasswordCodeVerification');
    }
  }
}
