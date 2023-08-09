import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';



class GetFriendsOrFollowersUsecase{
  final BaseRepositoryProfile relationRepo;

  GetFriendsOrFollowersUsecase({required this.relationRepo});

  Future<Either<Failure, List<UserDataModel>>>  getFriendsOrFollowers({required String type , String? page})async{
    return await relationRepo.getFriendsOrFollowers(type: type ,page: page);
  }
}