import 'package:equatable/equatable.dart';

abstract class TopEvents extends Equatable{

}



class GetDiamondsHourEvent extends TopEvents{
  final String sendOrReceiver ;
  final String date ;
  final String isHome;

  GetDiamondsHourEvent({required this.sendOrReceiver,
    required this.date,required  this.isHome});

  @override
  List<Object?> get props => [sendOrReceiver,date,isHome];
}

class GetDiamondsDayEvent extends TopEvents{
  final String sendOrReceiver ;
  final String date ;
  final String isHome;

  GetDiamondsDayEvent({required this.sendOrReceiver,
    required this.date,required  this.isHome});

  @override
  List<Object?> get props => [sendOrReceiver,date,isHome];
}
class GetDiamondsWeeklyEvent extends TopEvents{
  final String sendOrReceiver ;
  final String date ;
  final String isHome;

  GetDiamondsWeeklyEvent({required this.sendOrReceiver,
    required this.date,required  this.isHome});

  @override
  List<Object?> get props => [sendOrReceiver,date,isHome];
}
class GetDiamondsMonthlyEvent extends TopEvents{
  final String sendOrReceiver ;
  final String date ;
  final String isHome;

  GetDiamondsMonthlyEvent({required this.sendOrReceiver,
    required this.date,required  this.isHome});

  @override
  List<Object?> get props => [sendOrReceiver,date,isHome];
}

class GetCoinsHourEvent extends TopEvents{
  final String sendOrReceiver ;
  final String date ;
  final String isHome;

  GetCoinsHourEvent({required this.sendOrReceiver,
    required this.date,required  this.isHome});

  @override
  List<Object?> get props => [sendOrReceiver,date,isHome];
}

class GetCoinsDayEvent extends TopEvents{
  final String sendOrReceiver ;
  final String date ;
  final String isHome;

  GetCoinsDayEvent({required this.sendOrReceiver,
    required this.date,required  this.isHome});

  @override
  List<Object?> get props => [sendOrReceiver,date,isHome];
}
class GetCoinsWeeklyEvent extends TopEvents{
  final String sendOrReceiver ;
  final String date ;
  final String isHome;

  GetCoinsWeeklyEvent({required this.sendOrReceiver,
    required this.date,required  this.isHome});

  @override
  List<Object?> get props => [sendOrReceiver,date,isHome];
}
class GetCoinsMonthlyEvent extends TopEvents{
  final String sendOrReceiver ;
  final String date ;
  final String isHome;

  GetCoinsMonthlyEvent({required this.sendOrReceiver,
    required this.date,required  this.isHome});

  @override
  List<Object?> get props => [sendOrReceiver,date,isHome];
}

class LoadMoreEvent extends TopEvents {
  final String sendOrReceiver ;
  final String date ;
  final String isHome;

  LoadMoreEvent({required  this.date,required this.isHome,required this.sendOrReceiver});

  @override

  List<Object?> get props => [date,isHome,sendOrReceiver];


}