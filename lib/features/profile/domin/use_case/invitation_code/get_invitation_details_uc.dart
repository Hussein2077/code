import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/features/profile/data/model/invitation_users_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

import '../../../../../core/error/failures.dart';

class GetInvitationsDetailsUsecase {
  BaseRepositoryProfile baseRepositoryProfile;
  GetInvitationsDetailsUsecase({required this.baseRepositoryProfile});

  Future<Either<List<InvitationUsersModel>?, Failure>> call() async {
    final result = await baseRepositoryProfile.getInvitationDetails();
    return result;
  }
}