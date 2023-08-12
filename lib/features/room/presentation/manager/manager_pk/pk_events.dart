import 'package:equatable/equatable.dart';

abstract class PKEvents  extends Equatable {

}


class ShowPKEvent extends PKEvents {
  final String ownerId ;

  ShowPKEvent( {required this.ownerId});

  @override
  List<Object?> get props => [ownerId];

}


class StartPKEvent extends PKEvents {
  final String ownerId ;
  final String time ;

  StartPKEvent( {required this.time, required this.ownerId});

  @override
  List<Object?> get props => [ownerId,time];

}

class ClosePKEvent extends PKEvents {
  final String ownerId ;

  ClosePKEvent( {required this.ownerId});


  @override
  List<Object?> get props => [ownerId];

}

class HidePKEvent extends PKEvents {
  final String ownerId ;

  HidePKEvent( {required this.ownerId});


  @override
  List<Object?> get props => [ownerId];

}