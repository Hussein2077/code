part of 'login_chat_bloc.dart';

abstract class LoginChatState extends Equatable {
  const LoginChatState();
}

class LoginChatInitial extends LoginChatState {
  @override
  List<Object> get props => [];
}
