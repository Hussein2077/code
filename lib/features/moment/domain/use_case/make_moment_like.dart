import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/Base_Use_Case/Base_Use_Case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/moment/domain/repostoriy/base_repository_moment.dart';

class MakeMomentLikeUseCase extends BaseUseCase<String,String>{
  BaseRespositryMoment baseRespositryMoment;

  MakeMomentLikeUseCase({required this.baseRespositryMoment});

  @override
  Future<Either<String, Failure>> call(String userId)async {


final result = await baseRespositryMoment.makeMomentLike(userId);
return result;
  }



}