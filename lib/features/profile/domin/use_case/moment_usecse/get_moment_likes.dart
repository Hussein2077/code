import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/Base_Use_Case/Base_Use_Case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

class GetMomentLikesUseCase extends BaseUseCase<String,String>{
  BaseRepositoryProfile baseRepositoryProfile;

  GetMomentLikesUseCase({required this.baseRepositoryProfile});

  @override
  Future<Either<String, Failure>> call(String parameter)async {


final result = await baseRepositoryProfile.getMomentLikes(parameter);
return result;
  }



} 