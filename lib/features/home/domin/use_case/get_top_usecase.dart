import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/home/data/model/user_rank_model.dart';

import 'package:tik_chat_v2/features/home/domin/repository/rebostory_ab.dart';



class GetTopUseCase extends BaseUseCase<RankingModel,TopPramiter>{

  final RepoHome exploreExp ;


  GetTopUseCase({required this.exploreExp});

  @override
  Future<Either<RankingModel, Failure>> call(TopPramiter parameter) async{
     final result =  await exploreExp.getTopRank(parameter);
     return result ;
  }
}


class TopPramiter extends Equatable{
  final String sendOrReceiver ;
  final String date ;
  final String isHome;
  final String? roomId ;
  final String? page ;

  const TopPramiter({required this.sendOrReceiver,
    required this.date,required  this.isHome, this.roomId, this.page});

  @override
  List<Object?> get props => [sendOrReceiver,date,isHome,roomId,page];


}