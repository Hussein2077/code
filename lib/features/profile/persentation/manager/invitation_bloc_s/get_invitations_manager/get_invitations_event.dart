import 'package:equatable/equatable.dart';

abstract class GetInVitationsEvents extends Equatable {
  const GetInVitationsEvents();

  @override
  List<Object> get props => [];
}

class GetInVitationsDetailsEvent extends GetInVitationsEvents {
  const GetInVitationsDetailsEvent();
}
class GetParentDetailsEvent extends GetInVitationsEvents {
  const GetParentDetailsEvent();
}
