
import 'package:equatable/equatable.dart';

abstract class DeleteFamilyState extends Equatable {
  const DeleteFamilyState();

  @override
  List<Object> get props => [];
}

class DeleteFamilyInitial extends DeleteFamilyState {}

class DeleteFamilySucssesStete extends DeleteFamilyState {
  final String massage;
  const DeleteFamilySucssesStete({required this.massage});
}

class DeleteFamilyErrorSate extends DeleteFamilyState {
  final String massage;
  const DeleteFamilyErrorSate({required this.massage});
}
