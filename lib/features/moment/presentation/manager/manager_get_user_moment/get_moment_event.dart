
import 'package:equatable/equatable.dart';

abstract class BaseGetMomentEvent extends Equatable {
  const BaseGetMomentEvent();

  @override
  List<Object> get props => [];
}

class GetUserMomentEvent extends BaseGetMomentEvent {
  final String userId ; 
  const GetUserMomentEvent({required this.userId});
}


class LoadMoreUserMomentEvent extends BaseGetMomentEvent{
      final String userId ;
          const LoadMoreUserMomentEvent({ required this.userId});


}