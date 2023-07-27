
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/profile/data/model/family_requests_model.dart';

abstract class FamilyRequestState extends Equatable {
  const FamilyRequestState();

  @override
  List<Object> get props => [];
}

class FamilyRequestInitial extends FamilyRequestState {}

class FamilyRequestLoadingState extends FamilyRequestState {}

class FamilyRequestSUcsessState extends FamilyRequestState {
  final FamilyRequestsModel data;
  const FamilyRequestSUcsessState({required this.data});
}

class FamilyRequestErrorState extends FamilyRequestState {
  final String error;
  const FamilyRequestErrorState({required this.error});
}
