
import 'package:equatable/equatable.dart';

abstract class BaseShowAgencyEvent extends Equatable {
  const BaseShowAgencyEvent();

  @override
  List<Object> get props => [];
}


class ShowAgencyEvent extends BaseShowAgencyEvent{}