
import 'package:equatable/equatable.dart';

abstract class UserBadgesEvent extends Equatable {
  const UserBadgesEvent();

  @override
  List<Object> get props => [];
}

class  GetUserBadges extends UserBadgesEvent  {
  final String id ;
  const GetUserBadges({required this.id});
}