

import 'package:dartz/dartz.dart';

import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

class BoundPlatformUC {


  BaseRepositoryProfile baseRepositoryProfile;
  BoundPlatformUC({required this.baseRepositoryProfile});


  Future<Either<String,Failure>> boundFacebook ()async{
    final result = await baseRepositoryProfile.bountFacebook();

    return result ;
  }

  Future<Either<String,Failure>> boundGmail ()async{
    final result = await baseRepositoryProfile.bountGmail();

    return result ;
  }

  Future<Either<String,Failure>> changePassword(BoundNumberPramiter boundNumberPramiter) async{
    final result = await baseRepositoryProfile.ChangePassword(boundNumberPramiter);
    return result ;
  }
  Future<Either<String,Failure>> changePhone(BoundNumberPramiter boundNumberPramiter) async{
    final result = await baseRepositoryProfile.ChangePhone(boundNumberPramiter);
    return result ;
  }


  Future<Either<String,Failure>> boundNumber(BoundNumberPramiter boundNumberPramiter) async{
    final result = await baseRepositoryProfile.bountNumber(boundNumberPramiter);
    return result ;
  }







}

class  BoundNumberPramiter extends Equatable{

  final String? phoneNumber ;
  final String? password ;
  final String? vrCode ;
  final String? currentPhone ;
  final String? credintial ;


  const BoundNumberPramiter({  this.credintial, this.phoneNumber, this.currentPhone, this.password, this.vrCode});

  @override
  List<Object?> get props => [  phoneNumber,password,vrCode];


}