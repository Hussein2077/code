
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/moment/domain/repository/base_repository_moment.dart';



class AddMomentUseCase extends BaseUseCase<String,AddMomentPrameter>{

  BaseRepositoryMoment baseRepositoryMoment;
      AddMomentUseCase({required this.baseRepositoryMoment});

  @override
  Future<Either<String, Failure>> call(AddMomentPrameter parameter) async{
    final result = await baseRepositoryMoment.addMoment(parameter);
   return result ;
   
  }


}












class AddMomentPrameter {
  final String? moment ;
  final File? momentImage ;
  final String userId ;
  const AddMomentPrameter({
     this.moment ,
     this.momentImage ,
    required this.userId});
  
  
}