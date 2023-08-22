import 'package:equatable/equatable.dart';

abstract class PrivacyEvent extends Equatable {}

// class ChangeColorTextEvent extends PrivacyEvent {
//   @override
//   List<Object> get props => [];
// }

// class LastCommunicationTimeEvent extends PrivacyEvent {
//   final String type;

//   LastCommunicationTimeEvent({required this.type});

//   @override
//   List<Object> get props => [];
// }

// class HideCountryEvent extends PrivacyEvent {
//   final String type;

//   HideCountryEvent({required this.type});

//   @override
//   List<Object> get props => [];
// }

// class HideVisitorEvent extends PrivacyEvent {
//   final String type;

//   HideVisitorEvent({required this.type});

//   @override
//   List<Object> get props => [];
// }

// class activeMysteriosManEvent extends PrivacyEvent {
//   final String type;

//   activeMysteriosManEvent({required this.type});

//   @override
//   List<Object> get props => [];
// }

// class disposeMysteriosManEvent extends PrivacyEvent {
//   final String type;

//   disposeMysteriosManEvent({required this.type});

//   @override
//   List<Object> get props => [];
// }

// class DisposeLastCommunicationTimeEvent extends PrivacyEvent {
//   final String type;

//   DisposeLastCommunicationTimeEvent({required this.type});

//   @override
//   List<Object> get props => [];
// }

// class DisposeHideCountryEvent extends PrivacyEvent {
//   final String type;

//   DisposeHideCountryEvent({required this.type});

//   @override
//   List<Object> get props => [];
// }

// class DisposeHideVisitorEvent extends PrivacyEvent {
//   final String type;

//   DisposeHideVisitorEvent({required this.type});

//   @override
//   List<Object> get props => [];
// }

class AtivePrev extends PrivacyEvent {
  final String type ; 
   AtivePrev ({required this.type});
  
  @override
  List<Object?> get props => [type];


}

class DisposeePrev extends PrivacyEvent {
  final String type ; 
   DisposeePrev ({required this.type});
  
  @override
  List<Object?> get props => [type];


}