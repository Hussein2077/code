



import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/profile/data/model/search_model.dart';



abstract class SearchStates extends Equatable{}


class InitialSearchStates extends SearchStates{
  @override
  List<Object?> get props => [];

}
class LoadingSearchStates extends SearchStates{
  @override
  List<Object?> get props => [];

}
class SuccessSearchStates extends SearchStates{
  final SearchModel data ;
  


  SuccessSearchStates({required this.data});

  @override
  List<Object?> get props => [data];

}
class ErrorSearchStates extends SearchStates{
  final  String errorMessage ;


  ErrorSearchStates({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];

}

  class LoadingHistoryStates extends SearchStates{
  @override
  List<Object?> get props => [];

}
class SuccessHistoryStates extends SearchStates{
  final List<String> listSearches ;


  SuccessHistoryStates({required this.listSearches});

  @override
  List<Object?> get props => [listSearches];

}

class ErrorHistoryStates extends SearchStates{
 final  String errorMessage ;


 ErrorHistoryStates({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];

}

class LoadingEmptyStates extends SearchStates{

  @override
  List<Object?> get props => [];
}
class SuccessEmptyStates extends SearchStates{
  final String successMessage ;


  SuccessEmptyStates({required this.successMessage});

  @override
  List<Object?> get props => [successMessage];

}

class ErrorEmptyStates extends SearchStates{
  final  String errorMessage ;


  ErrorEmptyStates({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];

}