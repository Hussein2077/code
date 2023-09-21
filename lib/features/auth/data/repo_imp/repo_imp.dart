


import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/auth/data/data_soruce/remotly_datasource.dart';
import 'package:tik_chat_v2/features/auth/data/model/auth_with_google_model.dart';
import 'package:tik_chat_v2/features/auth/domin/repo/base_repo.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/add_info_use_case.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/forget_password_usecase.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/register_with_phone_usecase.dart';

class RepositoryImp extends BaseRepository {
  final BaseRemotlyDataSource baseRemotlyDataSource;

  RepositoryImp(
      {required this.baseRemotlyDataSource});

  @override
  Future<Either<Unit, Failure>> sendCode(String phoneNumber)async {
    try {
      await baseRemotlyDataSource.sendCode(phoneNumber);
      return const Left(unit);
    }  on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<MyDataModel, Failure>> registerWithPhone(AuthPramiter authPramiter)async {
   try {
      final result =
          await baseRemotlyDataSource.registerWithCodeAndPhone(authPramiter);
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }
  
  @override
  Future<Either<MyDataModel, Failure>> loginWithPhone(AuthPramiter authPramiter) async{
      try {
      final result =
          await baseRemotlyDataSource.loginWithPassAndPhone(authPramiter);
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<MyDataModel, Failure>> addInformation(InformationPramiter informationPramiter)async {
    try {
      final result = await baseRemotlyDataSource
          .addInformation(informationPramiter);
      return Left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }
  @override
  Future<Either<MyDataModel, Failure>> siginWithApple()async {
    try {
      final result = await baseRemotlyDataSource.sigInWithApple();
      return Left(result);
    } on Exception catch(e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<AuthWithGoogleModel, Failure>> siginWithGoogle() async{
      try {
      final result = await baseRemotlyDataSource.sigInWithGoogle();
      return Left(result);
     } on Exception catch(e) {
       return Right(DioHelper.buildFailure(e));
     }
 
  }
  
  @override
  Future<Either<MyDataModel, Failure>> siginWithFacebook()async {
     try {
      final result = await baseRemotlyDataSource.sigInWithFacebook();
      if (result.id == -1) {
        return Right(SiginFacebookFailure());
      } else {
        return Left(result);
      }
    } on Exception {
      return Right(SiginFacebookFailure());
    }
  }

  @override
  Future<Either<String, Failure>> forgetPassword(ForgetPasswordPramiter forgetPasswordPramiter) async{
    try {
      final result =
          await baseRemotlyDataSource.forgetPassword(forgetPasswordPramiter);
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }
  
  @override
  Future<Either<String, Failure>> logOut() async{
   try {
      final result =
          await baseRemotlyDataSource.logOut();
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }
}