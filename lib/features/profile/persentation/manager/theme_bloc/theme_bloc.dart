import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../component/settings/component/mode_screen/mode_screen.dart';

enum ThemeToggle { light, dark }

class ThemeCubit extends Cubit<ThemeToggle> {
  ThemeCubit() : super(ThemeToggle.light);

  void toggleTheme(int selectedMode)async {

    if (ModeScreen.selectedMode==0){
    emit(ThemeToggle.light);
    }
    else {
      emit(ThemeToggle.dark);
    }

    // emit(state == ThemeToggle.light ? ThemeToggle.dark : ThemeToggle.light);
  }
  // void darkTheme(){
  //   emit(ThemeToggle.dark );
  //
  // }
  // void lightTheme(){
  //   emit(ThemeToggle.light );
  // }
}
