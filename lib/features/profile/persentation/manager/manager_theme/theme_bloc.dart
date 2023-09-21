

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_theme/theme_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_theme/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial()) {
    on<ChangeThemeEvent>((event, emit) {
      // log(e)
      if (event.type == "light"){
        emit(LightThemeState());
      }else if (event.type=="dark") {
        emit(DarkThemeState());
      }

    });
  }
}
