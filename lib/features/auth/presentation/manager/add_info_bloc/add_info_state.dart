
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';


abstract class AddInfoState extends Equatable {
  const AddInfoState();
  
  @override
  List<Object> get props => [];
}

class AddInfoInitial extends AddInfoState {}

class AddInfoLoadingState extends AddInfoState{
  const AddInfoLoadingState();
}
class AddInfoErrorMessageState extends AddInfoState{
  final String errorMessage ;

  const AddInfoErrorMessageState({required this.errorMessage});

 
}

class AddInfoSuccesMessageState extends AddInfoState{
  final MyDataModel myDataModel ;

  const AddInfoSuccesMessageState({ required this.myDataModel});

}