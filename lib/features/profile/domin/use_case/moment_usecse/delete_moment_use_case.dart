import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

class DeleteMomentUseCase extends BaseUseCase<String,String>{
  
     BaseRepositoryProfile baseRepositoryProfile;
      DeleteMomentUseCase({required this.baseRepositoryProfile});

  @override
  Future<Either<String, Failure>> call(String parameter) async{
    final result = await baseRepositoryProfile.deleteMoment(parameter);
   
   return result ; 
   
  }


}