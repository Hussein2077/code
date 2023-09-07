import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

class AddMomentCommentUseCase extends BaseUseCase<String,AddMomentCommentPrameter>{
  
     BaseRepositoryProfile baseRepositoryProfile;
      AddMomentCommentUseCase({required this.baseRepositoryProfile});

  @override
  Future<Either<String, Failure>> call(AddMomentCommentPrameter parameter) async{
    final result = await baseRepositoryProfile.addMomentComment(parameter);
   
   return result ; 
   
  }


}












class AddMomentCommentPrameter {
  final String comment ;
  final String momentId ; 
  const AddMomentCommentPrameter({required this.comment , required this.momentId});
  
  
}