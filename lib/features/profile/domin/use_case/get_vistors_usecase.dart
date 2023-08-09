import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';



class GetVistorUseCase {
  BaseRepositoryProfile baseRepositoryProfile;
  GetVistorUseCase({required this.baseRepositoryProfile , });
  Future<Either<List<UserDataModel>, Failure>> getVistors({String? page}) async {
    final result = await baseRepositoryProfile.getVistors(page :page );
    return result ;
  }
}