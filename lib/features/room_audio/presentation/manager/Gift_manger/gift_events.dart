
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

class GiftesFamousEvent extends GiftEvent {
 int type ;

 GiftesFamousEvent({required this.type});

 @override
 List<Object?> get props => [type];
}

class GiftesLuckyEvent extends GiftEvent {
 int type ;

 GiftesLuckyEvent({required this.type});

 @override
 List<Object?> get props => [type];
}

class GiftesMomentEvent extends GiftEvent {
 int type ;

 GiftesMomentEvent({required this.type});
 @override
 List<Object?> get props => [type];
}