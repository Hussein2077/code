
import 'package:equatable/equatable.dart';

abstract class FamilyMemberEvent extends Equatable {
  const FamilyMemberEvent();

  @override
  List<Object> get props => [];
}

class GetFamilyMemberEvent extends FamilyMemberEvent {
  final String familyId;
  const GetFamilyMemberEvent({
    required this.familyId,
  });
}

class GetMoreFamilyMemberEvent extends FamilyMemberEvent {
  final String familyId;
  final String page;
  const GetMoreFamilyMemberEvent({
    required this.familyId,
    required this.page ,
  });
}
