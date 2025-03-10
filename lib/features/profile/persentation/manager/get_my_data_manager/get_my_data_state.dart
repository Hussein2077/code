
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';


abstract class GetMyDataState extends Equatable {
  const GetMyDataState();
  
  @override
  List<Object> get props => [];
}

class GetMyDataInitial extends GetMyDataState {}

class GetMyDataLoadingState extends GetMyDataState {}
class GetMyDataErrorState extends GetMyDataState {
final String errorMassage ; 
const GetMyDataErrorState({required this.errorMassage});
}
class GetMyDataSucssesState extends GetMyDataState {
  final  MyDataModel myDataModel ;
  const  GetMyDataSucssesState({required this.myDataModel});
}
