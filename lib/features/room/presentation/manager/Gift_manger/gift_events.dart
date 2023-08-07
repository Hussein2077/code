
import 'package:equatable/equatable.dart';

abstract class GiftEvent extends Equatable{

}


class GiftesNormalEvent extends GiftEvent {
 final int type ;

    GiftesNormalEvent({required this.type});

  @override
  List<Object?> get props => [type];
}

class GiftesHotEvent extends GiftEvent {
 final int type ;

  GiftesHotEvent({required this.type});

  @override
  List<Object?> get props => [type];
}

class GiftesCountryEvent extends GiftEvent {
 final int type ;

  GiftesCountryEvent({required this.type});

  @override
  List<Object?> get props => [type];
}