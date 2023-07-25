

import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/profile/data/model/useitem_model.dart';

abstract class UseItemState extends Equatable {
  const UseItemState();

  @override
  List<Object> get props => [];
}

class UseItemInitial extends UseItemState {}

class UseItemSuccseesState extends UseItemState {
 final UesItemModel data ; 
  const UseItemSuccseesState({required this.data});
}

class UseItemErrorState extends UseItemState {
 final String error;
  const UseItemErrorState({required this.error});
}

class UseItemLoadingState extends UseItemState {}
class UnusedloadingState extends UseItemState {}

class UnusedSucssesState extends UseItemState {
  final String massage;
  const UnusedSucssesState({required this.massage});
}

class UnusedErrorState extends UseItemState {
  final String massage;
  const UnusedErrorState({required this.massage});
}