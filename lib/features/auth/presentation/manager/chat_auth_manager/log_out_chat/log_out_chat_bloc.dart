import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/chat_auth_manager/log_out_chat/log_out_chat_event.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/chat_auth_manager/log_out_chat/log_out_chat_event.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/chat_auth_manager/log_out_chat/log_out_chat_state.dart';


class LogOutChatBloc extends Bloc<BaseLogOutChatEvent, LogOutChatState> {
  LogOutChatBloc() : super(LogOutChatInitial()) {
    on<LogOutChatEvent>((event, emit) async{
      User? _user = await CometChat.getLoggedInUser();
      try {
        if (_user != null) {
          await CometChatUIKit.logout();
        }
      } catch (_) {}    });
  }
}
