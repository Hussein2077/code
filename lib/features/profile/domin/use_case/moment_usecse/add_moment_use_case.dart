

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

class AddMomentUseCase extends BaseUseCase<String,AddMomentPrameter>{
  
     BaseRepositoryProfile baseRepositoryProfile;
      AddMomentUseCase({required this.baseRepositoryProfile});

  @override
  Future<Either<String, Failure>> call(AddMomentPrameter parameter) async{
    final result = await baseRepositoryProfile.addMoment(parameter);
   
   return result ; 
   
  }


}












class AddMomentPrameter {
  final String moment ;
  final String userId ; 
  const AddMomentPrameter({required this.moment , required this.userId});
  
  
}