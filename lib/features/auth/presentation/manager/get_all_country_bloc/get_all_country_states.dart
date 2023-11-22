import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/auth/data/model/country_model.dart';

abstract class GetAllCountriesStates extends Equatable {
  const GetAllCountriesStates();

  @override
  List<Object> get props => [];
}

class GetAllCountriesInitial extends GetAllCountriesStates {}
class GetAllCountriesLoading extends GetAllCountriesStates {}
class GetAllCountriesError extends GetAllCountriesStates {
  final String error ;
  const GetAllCountriesError ({required this.error});
}
class GetAllCountriesSuccessState extends GetAllCountriesStates {
  final GetAllCountriesBase getAllCountriesModel;

  const GetAllCountriesSuccessState( {required this.getAllCountriesModel,});
}