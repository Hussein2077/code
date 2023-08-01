

import 'package:equatable/equatable.dart';

abstract class SearchEvents extends Equatable{

}





class SearchEvent extends SearchEvents{
 final   String keyWord;

 SearchEvent({required this.keyWord});

  @override
  List<Object?> get props => [keyWord];


}

class  HestoryEvent extends SearchEvents{

 HestoryEvent();

 @override
 List<Object?> get props => [];


}

class  SearchInitEvent extends SearchEvents{

 SearchInitEvent();

 @override
 List<Object?> get props => [];


}

class  EmptyEvent extends SearchEvents{

 EmptyEvent();

 @override
 List<Object?> get props => [];


}