

import 'package:equatable/equatable.dart';

class PKModel extends Equatable {
  final int? timeMPk ;
  final int? timeSPk ;
  final int? team1Score;
  final int? team2Score ;
  final dynamic percentageTeam1 ;
  final dynamic percentageTeam2 ;
  final int? pkId ;

  const PKModel({ this.timeMPk, this.timeSPk, this.team1Score,  this.team2Score,
      this.percentageTeam2 , this.percentageTeam1, this.pkId});



  factory PKModel.fromJson(Map<String,dynamic> jsonData){

    return  PKModel(
        timeMPk: jsonData['m'],
        timeSPk: jsonData['s'],
        team1Score: jsonData['team1_score'],
        team2Score: jsonData['team2_score'],
        percentageTeam1: jsonData['t1_scale'],
        percentageTeam2: jsonData['t2_scale'],
        pkId:  jsonData['id']
    );
  }


  @override
  List<Object?> get props => [team1Score,team2Score,timeSPk,timeMPk,percentageTeam1,percentageTeam2,pkId];






}