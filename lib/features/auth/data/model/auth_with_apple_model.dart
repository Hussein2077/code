import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';

class AuthWithAppleModel {
  final AuthorizationCredentialAppleID userData ; 
  final MyDataModel apiUserData ;

  AuthWithAppleModel({required this.apiUserData , required this.userData});
}