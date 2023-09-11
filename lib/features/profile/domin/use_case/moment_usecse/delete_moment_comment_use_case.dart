import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

class DeleteMomentCommentUseCase extends BaseUseCase<String,DeleteMomentCommentPrameter>{
  
     BaseRepositoryProfile baseRepositoryProfile;
      DeleteMomentCommentUseCase({required this.baseRepositoryProfile});

  @override
  Future<Either<String, Failure>> call(DeleteMomentCommentPrameter parameter) async{
    final result = await baseRepositoryProfile.deleteMomentComment(parameter);
   
   return result ; 
   
  }


}












class DeleteMomentCommentPrameter {
  final String commentId ;
  final String momentId ; 
  const DeleteMomentCommentPrameter({required this.commentId , required this.momentId});
  
  
}