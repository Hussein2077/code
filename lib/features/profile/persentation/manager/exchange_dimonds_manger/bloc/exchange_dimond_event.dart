

import 'package:equatable/equatable.dart';

abstract class BaseExchangeDimondEvent extends Equatable {
  const BaseExchangeDimondEvent();

  @override
  List<Object> get props => [];
}

class ExchangeDimondEvent extends BaseExchangeDimondEvent{
  final String itemId  ; 
  const ExchangeDimondEvent({required this.itemId  });
}
