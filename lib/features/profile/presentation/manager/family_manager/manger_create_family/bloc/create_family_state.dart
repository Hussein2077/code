
import 'package:equatable/equatable.dart';


abstract class CreateFamilyState extends Equatable {
  const CreateFamilyState();

  @override
  List<Object> get props => [];
}

class CreateFamilyInitialState extends CreateFamilyState {}

class CreateFamilySucssesState extends CreateFamilyState {
  final String id;
  const CreateFamilySucssesState({required this.id});
}

class CreateFamilyErrorState extends CreateFamilyState {
  final String massage;
  const CreateFamilyErrorState({required this.massage});
}
class CreateFamilyLoadingState extends CreateFamilyState{
  
}
