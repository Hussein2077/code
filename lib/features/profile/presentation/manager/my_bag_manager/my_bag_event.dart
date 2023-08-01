
import 'package:equatable/equatable.dart';

abstract class MyBagEvent extends Equatable {
  const MyBagEvent();

  @override
  List<Object> get props => [];
}



class GetFramesMyBagEvent extends MyBagEvent {
  final String type;

  const GetFramesMyBagEvent({required this.type});
}

class GetBubbleBackPackMyBagEvent extends MyBagEvent {
  final String type;

  const GetBubbleBackPackMyBagEvent({required this.type});
}

class GetEntrieMyBagEvent extends MyBagEvent {
  final String type;
  const GetEntrieMyBagEvent({required this.type});
}