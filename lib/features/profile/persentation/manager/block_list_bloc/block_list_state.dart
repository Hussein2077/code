
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/profile/data/model/black_list_model.dart';
abstract class GetBlockListState extends Equatable {
  const GetBlockListState();

  @override
  List<Object> get props => [];
}

class GetBlockListInitial extends GetBlockListState {}

class GetBlockListLoadingState extends GetBlockListState {}
class GetBlockListErrorState extends GetBlockListState {
  final String errorMassage ;
  const GetBlockListErrorState({required this.errorMassage});
}
class GetBlockListSuccessState extends GetBlockListState {
  final  BlackListModel blackListModel ;
  const  GetBlockListSuccessState({required this.blackListModel});
}
