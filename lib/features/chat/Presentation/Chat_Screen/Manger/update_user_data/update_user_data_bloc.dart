import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/chat/Presentation/Chat_Screen/Manger/update_user_data/update_user_data_event.dart';
import 'package:tik_chat_v2/features/chat/Presentation/Chat_Screen/Manger/update_user_data/update_user_data_state.dart';



class UpdateUserDataBloc extends Bloc<BaseUpdateUserDataEvent, UpdateUserDataState> {
  UpdateUserDataBloc() : super(UpdateUserDataInitial()) {
    on<UpdateUserDataEvent>((event, emit) {

      CometChatUIKit.updateUser(User(name: event.name , avatar: event.avatar , ));



    });
  }
}
