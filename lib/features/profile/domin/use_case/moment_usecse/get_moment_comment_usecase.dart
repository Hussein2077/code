import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/data/model/moment/moment_comment_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

class GetMomentCommentUseCase extends BaseUseCase<List<MomentCommentModel>,GetMomentCommentPrameter>{
  
     BaseRepositoryProfile baseRepositoryProfile;
      GetMomentCommentUseCase({required this.baseRepositoryProfile});

  @override
  Future<Either<List<MomentCommentModel>, Failure>> call(GetMomentCommentPrameter parameter) async{
    final result = await baseRepositoryProfile.getMomentComment(parameter);
   
   return result ; 
   
  }


}












class GetMomentCommentPrameter {
  final String page ;
  final String momentId ; 
  const GetMomentCommentPrameter({required this.page , required this.momentId});
  
  
}