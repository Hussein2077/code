
import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

class ActiveNotificationUseCase {
  BaseRepositoryProfile baseRepositoryProfile;
  ActiveNotificationUseCase({required this.baseRepositoryProfile});
  Future<Either<bool, Failure>> activeNotification() async {
    final result = await baseRepositoryProfile.activeNotification();
    return result;
  }
}