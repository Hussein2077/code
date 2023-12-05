import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_chat_event.dart';
part 'login_chat_state.dart';

class LoginChatBloc extends Bloc<LoginChatEvent, LoginChatState> {
  LoginChatBloc() : super(LoginChatInitial()) {
    on<LoginChatEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
