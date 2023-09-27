import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/moment/domain/repostoriy/base_repository_moment.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';

class GetMomentUseCase extends BaseUseCase<List<MomentModel>,String>{

  BaseRespositryMoment baseRespositryMoment;
      GetMomentUseCase({required this.baseRespositryMoment});

  @override
  Future<Either<List<MomentModel>, Failure>> call(String parameter) async{
    final result = await baseRespositryMoment.getMoment(parameter);
   
   return result ; 
   
  }


}