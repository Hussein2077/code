
import 'package:equatable/equatable.dart';

abstract class BaseGetReelsEvent extends Equatable {
  const BaseGetReelsEvent();

  @override
  List<Object> get props => [];
}

class GetReelsEvent extends BaseGetReelsEvent{}
class LoadMoreReelsEvent extends BaseGetReelsEvent{}