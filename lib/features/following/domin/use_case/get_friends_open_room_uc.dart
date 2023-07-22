

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/features/following/domin/repository/follwoing_repository.dart';




class GetFriendsOpenRoomUC extends BaseUseCase<List<OwnerDataModel>,int>{


  RepoFollow repoFollow ;


  GetFriendsOpenRoomUC({required this.repoFollow});

  @override
  Future<Either<List<OwnerDataModel>, Failure>> call(int parameter) async {
    final  result = await repoFollow.getFriendsOpenRoom(parameter);
    return result ;
  }



}