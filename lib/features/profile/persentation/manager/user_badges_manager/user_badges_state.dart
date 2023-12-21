import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/profile/data/model/user_badges_model.dart';

abstract class UserBadgesState extends Equatable {
  const UserBadgesState();
  
  @override
  List<Object> get props => [];
}

 class UserBadgesInitial extends UserBadgesState {}
 class UserBadgesLoadingState extends UserBadgesState {}
 class UserBadgesErrorState extends UserBadgesState {
  final String error ;
  const UserBadgesErrorState({required this.error });
 }
 class UserBadgesSucssesState extends UserBadgesState {
  final UserBadgesModel badges ;
  const UserBadgesSucssesState({required this.badges});

 }
