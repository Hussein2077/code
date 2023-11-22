
import 'package:equatable/equatable.dart';

abstract class PrivacyPolicyState extends Equatable {
  const PrivacyPolicyState();
  
  @override
  List<Object> get props => [];
}

class PrivacyPolicyInitial extends PrivacyPolicyState {}
class PrivacyPolicyLoadingState extends PrivacyPolicyState {}
class PrivacyPolicySucssesState extends PrivacyPolicyState {
  final String message ;
  const PrivacyPolicySucssesState({required this.message});
}
class PrivacyPolicyErrorState extends PrivacyPolicyState {
  final String error ; 
  const PrivacyPolicyErrorState ({required this.error});
}


