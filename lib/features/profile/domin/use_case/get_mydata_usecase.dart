import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';



class GetmyDataUsecase extends BaseUseCase<MyDataModel,Noparamiter>{

  BaseRepositoryProfile baseRepositoryProfile ;
  GetmyDataUsecase({required this.baseRepositoryProfile});

  @override
  Future<Either<MyDataModel, Failure>> call(Noparamiter parameter)  async {

     final result = await baseRepositoryProfile.getmyData(parameter);
     return result ;
  }



}