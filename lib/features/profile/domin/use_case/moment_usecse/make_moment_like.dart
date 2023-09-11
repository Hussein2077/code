import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/Base_Use_Case/Base_Use_Case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

class MakeMomentLikeUseCase extends BaseUseCase<String,String>{
  BaseRepositoryProfile baseRepositoryProfile;

  MakeMomentLikeUseCase({required this.baseRepositoryProfile});

  @override
  Future<Either<String, Failure>> call(String parameter)async {


final result = await baseRepositoryProfile.makeMomentLike(parameter);
return result;
  }



} 