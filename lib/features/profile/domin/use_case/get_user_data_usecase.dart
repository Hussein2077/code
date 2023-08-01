import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';



class GetUserDataUseCase {
  BaseRepositoryProfile baseRepositoryProfile;
  GetUserDataUseCase({required this.baseRepositoryProfile});
  Future<Either<OwnerDataModel, Failure>> getUserData(String userId ,   
) async {
    final result = await baseRepositoryProfile.getUserData( userId: userId  ,);
    return result ;
  }
}
