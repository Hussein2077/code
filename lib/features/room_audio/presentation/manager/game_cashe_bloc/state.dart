import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/home/data/model/svga_data_model_.dart';

abstract class CacheStates extends Equatable {
  const CacheStates();

  @override
  List<Object> get props => [];
}

class ExtraDataInitial extends CacheStates {}
class ExtraDataLoading extends CacheStates {}

class ExtraDataSuccess extends CacheStates {
  final SvgaDataModel svgaDataModel;

  const ExtraDataSuccess(this.svgaDataModel);

  @override
  List<Object> get props => [svgaDataModel];
}

class ExtraDataError extends CacheStates {
  final String error;

  const ExtraDataError(this.error);

  @override
  List<Object> get props => [error];
}