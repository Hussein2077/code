
import 'package:equatable/equatable.dart';

abstract class FamilyRoomEvent extends Equatable {
  const FamilyRoomEvent();

  @override
  List<Object> get props => [];
}

class GetFamilyRoomevent extends FamilyRoomEvent {
  final String familyId;
  const GetFamilyRoomevent({required this.familyId});
}
