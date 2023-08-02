
import 'package:equatable/equatable.dart';

abstract class BaseMyStoreEvent extends Equatable {
  const BaseMyStoreEvent();

  @override
  List<Object> get props => [];
}


class GetMyStoreEvent extends BaseMyStoreEvent {
  
}