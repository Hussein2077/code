
import 'package:equatable/equatable.dart';

abstract class BaseFamilyRemoveUserEvent extends Equatable {
  const BaseFamilyRemoveUserEvent();

  @override
  List<Object> get props => [];
}

class removerFamilyUser extends BaseFamilyRemoveUserEvent {
  final String uId;
  final String familyId;
  const removerFamilyUser({required this.uId, required this.familyId});
}
