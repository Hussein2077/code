import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/moment/domain/repository/base_repository_moment.dart';


class DeleteMomentUseCase extends BaseUseCase<String,String>{

  BaseRepositoryMoment baseRepositoryMoment;
      DeleteMomentUseCase({required this.baseRepositoryMoment});

  @override
  Future<Either<String, Failure>> call(String parameter) async{
    final result = await baseRepositoryMoment.deleteMoment(parameter);
   
   return result ; 
   
  }


}