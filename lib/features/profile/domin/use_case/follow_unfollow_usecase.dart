

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';


class FollowOrUnFollowUsecase{
  final BaseRepositoryProfile relationRepo;

  FollowOrUnFollowUsecase({required this.relationRepo});

  Future<Either<Failure, String>>  follow({required String userId})async{
    return await relationRepo.follow(userId: userId);
  }
  Future<Either<Failure, String>>  unFollow({required String userId})async{
    return await relationRepo.unFollow(userId: userId);
  }
}