
import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}


class ChangeThemeEvent extends ThemeEvent {
  final String type ; 
  const ChangeThemeEvent({required this.type});
}
