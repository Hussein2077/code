import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/features/auth/domin/repo/base_repo.dart';


class RegisterWithPhoneUsecase extends BaseUseCase<OwnerDataModel,AuthPramiter>{
  final BaseRepository baseRepository ;


  RegisterWithPhoneUsecase({required this.baseRepository});

  @override
  Future<Either<OwnerDataModel, Failure>> call(AuthPramiter parameter) async {
    final result = await baseRepository.registerWithPhone(parameter);
    return result ;


  }



}

class AuthPramiter extends Equatable{

 final  String phone ;
 final  String? password;
 final  String? code;
 final String? credential ;


 const AuthPramiter({required this.phone, this.password, this.code, this.credential});

  @override
  List<Object?> get props => [phone ,password,code,credential];

}