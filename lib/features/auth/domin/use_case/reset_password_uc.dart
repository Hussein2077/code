import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/auth/domin/repo/base_repo.dart';



class ResetPasswordUc extends BaseUseCase<String,ResetPasswordPramiter>{


  BaseRepository baseRepository ;


  ResetPasswordUc({ required this.baseRepository});

  @override
  Future<Either<String, Failure>> call(ResetPasswordPramiter parameter)async {
    final result =await baseRepository.resetPassword(parameter);
    return result ;
  }



}

class ResetPasswordPramiter extends Equatable{
  final String phone;
  final String password;
  final String code ;

  const ResetPasswordPramiter({required this.phone,required this.password,required this.code,});

  @override

  List<Object?> get props => [phone,password,code,];


}