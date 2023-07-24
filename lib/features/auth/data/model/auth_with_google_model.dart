import 'package:google_sign_in/google_sign_in.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';

class AuthWithGoogleModel {
    final GoogleSignInAccount userData ; 
  final OwnerDataModel apiUserData ;

  AuthWithGoogleModel({required this.apiUserData , required this.userData});
}