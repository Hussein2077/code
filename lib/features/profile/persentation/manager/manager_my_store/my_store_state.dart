
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/profile/data/model/agency_my_store.dart';

abstract class MyStoreState extends Equatable {
  const MyStoreState();
  
  @override
  List<Object> get props => [];
}

class MyStoreInitial extends MyStoreState {}


class MyStoreLoadingState extends MyStoreState {}
class MyStoreSucssesState extends MyStoreState {
  final AgencyMyStoreModel myStore ; 
  const MyStoreSucssesState({required this.myStore });
}
class MyStoreErrorState extends MyStoreState {
  final String error ; 
  const MyStoreErrorState({required this.error });
}
