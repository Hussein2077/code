import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/features/chat/Presentation/Chat_Screen/Manger/update_user_data/update_user_data_event.dart';
import 'package:tik_chat_v2/features/chat/Presentation/Chat_Screen/Manger/update_user_data/update_user_data_state.dart';
import 'package:tik_chat_v2/features/chat/user_chat/chat_theme_integration.dart';

class UpdateUserDataBloc
    extends Bloc<BaseUpdateUserDataEvent, UpdateUserDataState> {
  UpdateUserDataBloc() : super(UpdateUserDataInitial()) {
    on<UpdateUserDataEvent>((event, emit) async {
      if (ChatThemeIntegration.disableChat) {
        log("displayChat");
      } else {
        String? notifecationId = await FirebaseMessaging.instance.getToken();


        CometChat.updateCurrentUserDetails(

            onSuccess: (retUser) {
            },
            onError: (excep) {

            },
            User(

            uid: MyDataModel.getInstance().id.toString(),
            name: event.name,
            avatar: event.avatar,
            metadata: {"notification_id": notifecationId}
            )
        );
      }
    });
  }
}
