

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/features/auth/domin/repo/base_repo.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/register_with_phone_usecase.dart';

class LoginWithPhoneUseCase extends BaseUseCase<MyDataModel,AuthPramiter>{

  BaseRepository baseRepository ;


  LoginWithPhoneUseCase({ required this.baseRepository});

  @override
  Future<Either<MyDataModel, Failure>> call(AuthPramiter parameter) async {
   final result = await baseRepository.loginWithPhone(parameter);

   return result ;
  }


}