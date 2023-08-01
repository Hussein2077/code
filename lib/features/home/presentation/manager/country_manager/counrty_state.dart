


import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/home/data/model/country_model.dart';

abstract class CountryStates extends Equatable {
  const CountryStates();

  @override
  List<Object?> get props => [];
  }

  class CountryInitialState extends CountryStates{
  const CountryInitialState ();
  }
  class CountryLoadingState extends CountryStates{
  const CountryLoadingState();
  }
  class CountryErrorMessageState extends CountryStates{
  final String errorMessage ;

  const CountryErrorMessageState({required this.errorMessage});

  @override
  List<Object?> get props => [ errorMessage];
  }

  class CountrySuccesMessageState extends CountryStates{

  final List<CountryModel> countrys;

  const CountrySuccesMessageState({required  this.countrys});
  @override
  List<Object?> get props => [countrys];
  }


