
import 'package:equatable/equatable.dart';

abstract class BaseGetMomentILikeItEvent extends Equatable {
  const BaseGetMomentILikeItEvent();

  @override
  List<Object> get props => [];
}

class GetMomentIliKEitEvent extends BaseGetMomentILikeItEvent {
   
  const GetMomentIliKEitEvent();
}


class LoadMoreMomentIlikeItEvent extends BaseGetMomentILikeItEvent{
          const LoadMoreMomentIlikeItEvent();


}