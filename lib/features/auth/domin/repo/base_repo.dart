

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/features/auth/data/model/auth_with_google_model.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/add_info_use_case.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/forget_password_usecase.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/register_with_phone_usecase.dart';

abstract class BaseRepository {
  Future<Either<Unit, Failure>> sendCode(String phoneNumber);

  Future<Either<MyDataModel, Failure>> registerWithPhone(
      AuthPramiter authPramiter);

  Future<Either<MyDataModel, Failure>> loginWithPhone(
      AuthPramiter authPramiter);

  Future<Either<MyDataModel, Failure>> addInformation(
      InformationPramiter informationPramiter);

  Future<Either<AuthWithGoogleModel, Failure>> siginWithGoogle();

  Future<Either<MyDataModel, Failure>> siginWithFacebook();

  Future<Either<String, Failure>> forgetPassword(
      ForgetPasswordPramiter forgetPasswordPramiter);
        Future<Either<String, Failure>> logOut(
       );
}
