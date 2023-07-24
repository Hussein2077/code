import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';


class UserReporetUseCase extends BaseUseCase<String,UserReporetPramiter>{

  BaseRepositoryProfile baseRepository ;


  UserReporetUseCase({ required this.baseRepository});

  @override
  Future<Either<String, Failure>> call(UserReporetPramiter parameter) async {
   final result = await baseRepository.userReporet(parameter);

   return result ;
  }


}

class UserReporetPramiter extends Equatable{

 final String ?id ;
 final String? typeReporet ;
 final File? image ;
 final String? reporetContetnt ;


 const UserReporetPramiter({ this.id, this.typeReporet, this.image,this.reporetContetnt});

  @override
  List<Object?> get props => [id ,typeReporet,image,reporetContetnt];

}