
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/profile/data/model/show_family_model.dart';

abstract class ShowFamilyState extends Equatable {
  const ShowFamilyState();

  @override
  List<Object> get props => [];
}

class ShowFamilyInitial extends ShowFamilyState {}

class ShowFamilyLoadingState extends ShowFamilyState {}

class ShowFamilySucssesState extends ShowFamilyState {
  final ShowFamilyModel data;
  const ShowFamilySucssesState({required this.data});
}

class ShowFamilyErrorState extends ShowFamilyState {
  final String error;
  const ShowFamilyErrorState({required this.error});
}
