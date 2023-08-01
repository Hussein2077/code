import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';



class GetmyDataUsecase extends BaseUseCase<OwnerDataModel,Noparamiter>{

  BaseRepositoryProfile baseRepositoryProfile ;
  GetmyDataUsecase({required this.baseRepositoryProfile});

  @override
  // ignore: avoid_renaming_method_parameters
  Future<Either<OwnerDataModel, Failure>> call(Noparamiter noparamiter)  async {

     final result = await baseRepositoryProfile.getmyData(noparamiter);
     return result ;
  }



}