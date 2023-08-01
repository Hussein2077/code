

import 'package:equatable/equatable.dart';

abstract class CounrtyEvent extends Equatable {
  const CounrtyEvent();

  @override
  List<Object> get props => [];
}
class GetAllCountryEvent extends CounrtyEvent{}
