import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/data/model/moment_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

class GetMomentUseCase extends BaseUseCase<List<MomentModel>,String>{
  
     BaseRepositoryProfile baseRepositoryProfile;
      GetMomentUseCase({required this.baseRepositoryProfile});

  @override
  Future<Either<List<MomentModel>, Failure>> call(String parameter) async{
    final result = await baseRepositoryProfile.getMoment(parameter);
   
   return result ; 
   
  }


}