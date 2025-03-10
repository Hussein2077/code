import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_comment_model.dart';
import 'package:tik_chat_v2/features/moment/domain/repository/base_repository_moment.dart';


class GetMomentCommentUseCase extends BaseUseCase<List<MomentCommentModel>,GetMomentCommentPrameter>{

  BaseRepositoryMoment baseRepositoryMoment;
      GetMomentCommentUseCase({required this.baseRepositoryMoment});

  @override
  Future<Either<List<MomentCommentModel>, Failure>> call(GetMomentCommentPrameter parameter) async{
    final result = await baseRepositoryMoment.getMomentComment(parameter);
   
   return result ; 
   
  }


}












class GetMomentCommentPrameter {
  final String page ;
  final String momentId ; 
  const GetMomentCommentPrameter({required this.page , required this.momentId});
  
  
}