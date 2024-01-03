import 'package:equatable/equatable.dart';

abstract class AddOrDeleteBlockListState extends Equatable {
  const AddOrDeleteBlockListState();

  @override
  List<Object> get props => [];
}

class AddOrDeleteBlockListInitial extends AddOrDeleteBlockListState {}

class AddBlockListLoadingState extends AddOrDeleteBlockListState {}

class AddBlockListErrorState extends AddOrDeleteBlockListState {
  final String errorMassage;

  const AddBlockListErrorState({required this.errorMassage});
}

class AddBlockListSuccessState extends AddOrDeleteBlockListState {
  final String message;

  const AddBlockListSuccessState({required this.message});
}
//delete
class DeleteBlockListLoadingState extends AddOrDeleteBlockListState {}

class DeleteBlockListErrorState extends AddOrDeleteBlockListState {
  final String errorMassage;

  const DeleteBlockListErrorState({required this.errorMassage});
}

class DeleteBlockListSuccessState extends AddOrDeleteBlockListState {
  final String message;

  const DeleteBlockListSuccessState({required this.message});
}