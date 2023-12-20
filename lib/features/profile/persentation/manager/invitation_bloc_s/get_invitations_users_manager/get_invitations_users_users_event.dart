import 'package:equatable/equatable.dart';

abstract class GetInVitationsEvents extends Equatable {
  const GetInVitationsEvents();

  @override
  List<Object> get props => [];
}

class GetInVitationsUsersDetailsEvent extends GetInVitationsEvents {
  const GetInVitationsUsersDetailsEvent();
}

