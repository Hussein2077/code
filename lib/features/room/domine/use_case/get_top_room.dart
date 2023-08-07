
import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/home/data/model/user_top_model.dart';
import 'package:tik_chat_v2/features/home/domin/use_case/get_top_usecase.dart';
import 'package:tik_chat_v2/features/room/domine/Repository/Base_Repository_Profile.dart';



class GetTopRoomUC extends BaseUseCase<List<UserTopModel>,TopPramiter>{
  final BaseRepositoryRoom roomRepo ;


  GetTopRoomUC({required this.roomRepo});

  @override
  Future<Either<List<UserTopModel>, Failure>> call(TopPramiter parameter) async{
     final result = await roomRepo.getTopRankInRoom(parameter);
     return result ;
  }



}