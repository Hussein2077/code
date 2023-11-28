import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';



class GetAllShippingAgentsUseCase {

  BaseRepositoryProfile baseRepositoryProfile;
  GetAllShippingAgentsUseCase({ required this.baseRepositoryProfile});
  Future<Either<List<UserDataModel>, Failure>>
  getAllShippingAgents(GetAllShippingAgentsPram pram) async {
    return await baseRepositoryProfile.getAllShippingAgents(pram: pram);
  }
}

class GetAllShippingAgentsPram {
  final String page ;
  GetAllShippingAgentsPram(this.page);

}