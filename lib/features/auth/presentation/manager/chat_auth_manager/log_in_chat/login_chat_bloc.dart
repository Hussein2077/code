import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/chat_auth_manager/log_in_chat/login_chat_event.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/chat_auth_manager/log_in_chat/login_chat_state.dart';
import 'package:tik_chat_v2/features/chat/user_chat/chat_theme_integration.dart';

import '../../../../../chat/user_chat/chat_page.dart';

class LoginChatBloc extends Bloc<BaseLoginChatEvent, LoginChatState> {
  LoginChatBloc() : super(LoginChatInitial()) {
    on<LoginChatEvent>((event, emit) async {
      if (ChatThemeIntegration.disableChat) {
        log("displayChat");

      } else {
        String? notifecationId = await FirebaseMessaging.instance.getToken();

        CometChatUIKit.createUser(
            User(
                name: event.name,
                uid: event.id.toString(),
                avatar: event.avatar,
                metadata: {"notification_id": notifecationId}),
            onSuccess: (User user) {
          log("User created successfully ${user.name}");

          CometChatUIKit.login(event.id.toString(), onSuccess: (User user) {
            log("User logged in successfully  ${user.name}");

          }, onError: (CometChatException e) {
            log("Login failed with exception: ${e.message}");
          });
        }, onError: (CometChatException e) {
          log("Creating new user failed with exception: ${e.message}");
          CometChatUIKit.login(event.id.toString(), onSuccess: (User user) {




            log("User logged in successfully  ${user.name}");
          }, onError: (CometChatException e) {
            log("Login failed with exception: ${e.message}");
          });
        });
      }
    });
  }
}
