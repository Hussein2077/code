

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/features/auth/data/model/auth_with_apple_model.dart';
import 'package:tik_chat_v2/features/auth/data/model/auth_with_google_model.dart';
import 'package:tik_chat_v2/features/auth/data/model/auth_with_huawei_model.dart';
import 'package:tik_chat_v2/features/auth/data/model/country_model.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/add_info_use_case.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/forget_password_check_code_us.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/forget_password_usecase.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/register_verification_us.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/register_with_phone_usecase.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/reset_password_uc.dart';

abstract class BaseRepository {
  Future<Either<Unit, Failure>> resendCode(String uuid);

  Future<Either<Unit, Failure>> registerVerification(
      RegisterVerificationModel registerVerificationModel);

  Future<Either<MyDataModel, Failure>> registerWithPhone(
      AuthPramiter authPramiter);

  Future<Either<MyDataModel, Failure>> loginWithPhone(
      AuthPramiter authPramiter);

  Future<Either<MyDataModel, Failure>> addInformation(
      InformationPramiter informationPramiter);

  Future<Either<AuthWithGoogleModel, Failure>> siginWithGoogle();

  Future<Either<AuthWithHuaweiModel, Failure>> sigInWithHuawei();

  Future<Either<AuthWithAppleModel, Failure>> siginWithApple();

  Future<Either<MyDataModel, Failure>> siginWithFacebook();

  Future<Either<String, Failure>> logOut();
  Future<Either<String, Failure>> privacyPolicy();
  Future<Either<String, Failure>> deleteAccount();
  Future<Either<GetAllCountriesBase, Failure>> getAllCountries();
  Future<Either<String, Failure>> forgetPasswordCheckCode(
      ForgetPasswordCheckCodeParameters forgetPasswordCheckCodeParameters);

  Future<Either<String, Failure>> forgetPassword(String phone);
  Future<Either<String, Failure>> resetPassword(
      ResetPasswordPramiter resetPasswordPramiter);
}
