import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

import '../../../../../core/error/failures.dart';

class InvitUsecase {
  BaseRepositoryProfile baseRepositoryProfile;
  InvitUsecase({required this.baseRepositoryProfile});

  Future<Either<String, Failure>> call(id) async {
    final result = await baseRepositoryProfile.invitCode(id);
    return result;
  }
}