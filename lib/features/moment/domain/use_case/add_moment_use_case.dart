

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/moment/domain/repostoriy/base_repository_moment.dart';

class AddMomentUseCase extends BaseUseCase<String,AddMomentPrameter>{

  BaseRespositryMoment baseRespositryMoment;
      AddMomentUseCase({required this.baseRespositryMoment});

  @override
  Future<Either<String, Failure>> call(AddMomentPrameter parameter) async{
    final result = await baseRespositryMoment.addMoment(parameter);
   
   return result ; 
   
  }


}












class AddMomentPrameter {
  final String moment ;
  final XFile momentImage ;
  final String userId ;
  const AddMomentPrameter({
    required this.momentImage ,
    required this.moment ,
    required this.userId});
  
  
}