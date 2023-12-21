import 'package:equatable/equatable.dart';

abstract class BadgesEvent extends Equatable {
  const BadgesEvent();

  @override
  List<Object> get props => [];
}


class AchievementEvent extends BadgesEvent{
  final  String type ;


  const AchievementEvent({required this.type});



}

class HonorEvent extends BadgesEvent{
  final  String type ;


  const HonorEvent({required this.type});

}

class ActivityEvent extends BadgesEvent{
  final  String type ;


  const ActivityEvent({required this.type});



}
