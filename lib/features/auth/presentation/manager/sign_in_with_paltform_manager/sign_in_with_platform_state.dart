
import 'package:equatable/equatable.dart';

import 'package:tik_chat_v2/features/auth/data/model/auth_with_google_model.dart';

abstract class SignInWithPlatformState extends Equatable {
  const SignInWithPlatformState();
  
  @override
  List<Object> get props => [];
}

class SignInWithPlatformInitial extends SignInWithPlatformState {}
class SiginWithPlatFormLoadingState extends SignInWithPlatformState{
  const SiginWithPlatFormLoadingState();
}
class SiginWithGoogleErrorMessageState extends SignInWithPlatformState{
  final String errorMessage ;

  const SiginWithGoogleErrorMessageState({required this.errorMessage});


}

class SiginWithGoogleSuccesMessageState extends SignInWithPlatformState{
final AuthWithGoogleModel userData ; 

  const SiginWithGoogleSuccesMessageState({   required this.userData});

}