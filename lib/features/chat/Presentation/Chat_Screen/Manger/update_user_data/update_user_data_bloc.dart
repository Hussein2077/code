import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tik_chat_v2/features/chat/Presentation/Chat_Screen/Manger/update_user_data/update_user_data_event.dart';
import 'package:tik_chat_v2/features/chat/Presentation/Chat_Screen/Manger/update_user_data/update_user_data_state.dart';



class UpdateUserDataBloc extends Bloc<BaseUpdateUserDataEvent, UpdateUserDataState> {
  UpdateUserDataBloc() : super(UpdateUserDataInitial()) {
    on<UpdateUserDataEvent>((event, emit) async {
      String? notifecationId = await FirebaseMessaging.instance.getToken() ;

      CometChatUIKit.updateUser(User(name: event.name , avatar: event.avatar , metadata: {"notification_id" :notifecationId } ));



    });
  }
}
