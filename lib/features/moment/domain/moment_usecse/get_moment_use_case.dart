import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';
import 'package:tik_chat_v2/features/moment/domain/repository/base_repository_moment.dart';


class GetMomentUseCase extends BaseUseCase<List<MomentModel>,GetMomentPrameter>{

  BaseRepositoryMoment baseRepositoryMoment;
      GetMomentUseCase({required this.baseRepositoryMoment});

  @override
  Future<Either<List<MomentModel>, Failure>> call(GetMomentPrameter parameter) async{
    final result = await baseRepositoryMoment.getMoment(parameter);
   
   return result ; 
   
  }


}


class GetMomentPrameter {
  final String page ;
  final String? userId ;
  final String type ; 
  const GetMomentPrameter({required this.page ,  this.userId , required this.type});
  
  
}