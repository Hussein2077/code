

import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_config_key.dart';

abstract class BaseGetConfigKeysEvent extends Equatable {
  const BaseGetConfigKeysEvent();

  @override
  List<Object> get props => [];
}

class GetConfigKeyEvent extends BaseGetConfigKeysEvent{
  final GetConfigKeyPram getConfigKeyPram ; 
  const GetConfigKeyEvent({required this.getConfigKeyPram});
}
