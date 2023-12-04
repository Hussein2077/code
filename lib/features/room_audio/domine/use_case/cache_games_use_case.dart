import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/home/data/model/svga_data_model_.dart';
import 'package:tik_chat_v2/features/room_audio/domine/Repository/Base_Repository_Profile.dart';

class CacheGamesUc extends BaseUseCase<SvgaDataModel,int>{

  final BaseRepositoryRoom roomRepo;


  CacheGamesUc({required this.roomRepo});

  @override
  Future<Either<SvgaDataModel, Failure>> call(int parameter) async{
    final result =  await roomRepo.cacheGames(parameter);
    return result ;
  }

}