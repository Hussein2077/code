import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/auth/data/model/auth_with_huawei_model.dart';
import 'package:tik_chat_v2/features/auth/domin/repo/base_repo.dart';

class SignInWithHuaweiUC extends BaseUseCase<AuthWithHuaweiModel,Noparamiter>{

  BaseRepository baseRepository ;


  SignInWithHuaweiUC({ required this.baseRepository});

  @override
  Future<Either<AuthWithHuaweiModel, Failure>> call(Noparamiter parameter) async{

    final result =  await baseRepository.sigInWithHuawei() ;

    return result ;
  }


}