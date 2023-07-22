import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/auth/domin/repo/base_repo.dart';



class ForgetPasswordUc extends BaseUseCase<String,ForgetPasswordPramiter>{


  BaseRepository baseRepository ;


  ForgetPasswordUc({ required this.baseRepository});

  @override
  Future<Either<String, Failure>> call(ForgetPasswordPramiter parameter)async {
    final result =await baseRepository.forgetPassword(parameter);

    return result ;
  }



}








class ForgetPasswordPramiter extends Equatable{
  final String phone;
  final String password;
  final String vrCode ;
  final String credential ;

  const ForgetPasswordPramiter({required this.phone,required this.password,required this.vrCode,required this.credential});

  @override

  List<Object?> get props => [phone,password,vrCode,credential];


}