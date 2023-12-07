import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/home/data/model/svga_data_model_.dart';

abstract class CacheGameEvent extends Equatable {
  const CacheGameEvent();

  @override
  List<Object> get props => [];
}

class FetchExtraDataEvent extends CacheGameEvent {
  final int type;
  const FetchExtraDataEvent(this.type);
}
