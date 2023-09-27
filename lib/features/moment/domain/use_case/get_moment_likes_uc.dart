


import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_like_model.dart';
import 'package:tik_chat_v2/features/moment/domain/repostoriy/base_repository_moment.dart';

class GetMomentLikeUseCase extends BaseUseCase<List<MomentLikeModel>,GetMomentLikePrameter>{

  BaseRespositryMoment baseRepositoryMoment;
      GetMomentLikeUseCase({required this.baseRepositoryMoment});

  @override
  Future<Either<List<MomentLikeModel>, Failure>> call(GetMomentLikePrameter parameter) async{
    final result = await baseRepositoryMoment.getMomentLike(parameter);
   
   return result ; 
   
  }


}


class GetMomentLikePrameter {
  final String page ;
  final String momentId ; 
  const GetMomentLikePrameter({required this.page , required this.momentId});
  
  
}