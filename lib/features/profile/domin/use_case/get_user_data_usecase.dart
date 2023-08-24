import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';



class GetUserDataUseCase {
  BaseRepositoryProfile baseRepositoryProfile;
  GetUserDataUseCase({required this.baseRepositoryProfile});
  Future<Either<UserDataModel, Failure>> getUserData(String userId ,
) async {
    final result = await baseRepositoryProfile.getUserData( userId: userId  ,);
    return result ;
  }
}
