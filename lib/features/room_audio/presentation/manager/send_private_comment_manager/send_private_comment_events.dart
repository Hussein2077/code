import 'package:equatable/equatable.dart';

abstract class SendPrivateCommentEvents extends Equatable {
  const SendPrivateCommentEvents();
}

class InitEvent extends SendPrivateCommentEvents{
  @override
  List<Object?> get props => [];

}

class SnedPrivateComment extends SendPrivateCommentEvents{
  final String message;
  final String userId ;
  final String roomId ;


  SnedPrivateComment({required this.message,required this.userId, required this.roomId});

  @override
  List<Object?> get props => [message,userId,roomId];

}