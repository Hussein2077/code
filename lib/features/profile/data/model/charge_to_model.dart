import 'package:equatable/equatable.dart';

class ChargeToModel extends Equatable{

 final String message ;

  const ChargeToModel({required this.message});

  factory ChargeToModel.fromJason(Map<String,dynamic>jason){

    return ChargeToModel(message: jason['message']);
  }


  @override
  List<Object?> get props => [
    message,
  ];
}