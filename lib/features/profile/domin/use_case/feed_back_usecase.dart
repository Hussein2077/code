import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

import '../../../../core/Base_Use_Case/Base_Use_Case.dart';
import '../../../../core/error/failures.dart';

class FeedBackUseCase extends BaseUseCase<String,FeedBackPramiter>{

  BaseRepositoryProfile baseRepository ;


  FeedBackUseCase({ required this.baseRepository});

  @override
  Future<Either<String, Failure>> call(FeedBackPramiter parameter) async {
   final result = await baseRepository.feedBack(parameter);

   return result ;
  }


}

class FeedBackPramiter extends Equatable{

 final String ?content ;
 final String? phoneNumber ;
 final File? image ;
 final int? userId ;
 final String? description ; 


 const FeedBackPramiter({ this.description,  this.content, this.phoneNumber, this.image,this.userId});

  @override
  List<Object?> get props => [content ,phoneNumber,image,userId , description];

}