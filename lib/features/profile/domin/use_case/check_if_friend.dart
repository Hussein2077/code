

import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

class CheckIfFriend {
  BaseRepositoryProfile baseRepositoryProfile;

  CheckIfFriend({required this.baseRepositoryProfile});

  Future<bool> chechIfFriends(String parameter) async {
    final result = await baseRepositoryProfile.checkIfFriend(parameter);
    return result;
  }
}
