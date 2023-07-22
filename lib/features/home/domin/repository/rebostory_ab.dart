import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/model/all_rooms_model.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/home/data/model/carousels_model.dart';
import 'package:tik_chat_v2/features/home/data/model/config_model.dart';
import 'package:tik_chat_v2/features/home/data/model/country_model.dart';
import 'package:tik_chat_v2/features/home/data/model/user_rank_model.dart';
import 'package:tik_chat_v2/features/home/domin/use_case/get_top_usecase.dart';



abstract class RepoHome{

  Future<Either<RankingModel,Failure>> getTopRank(TopPramiter topPramiter);

  Future<Either<Failure, AllRoomsDataModel>> getAllRooms(
      {int? countryId,
        int? classId,
        int? typeId,
        String? search,
        int? page,
        TypeGetRooms? typeGetRooms});
  Future<Either<List<CountryModel>, Failure>> getCountry();
  Future<Either<List<CarouselsModel>,Failure>> getCarousels();
  Future<Either<ConfigModel,Failure>> getConfigApp(ConfigModelBody configModelBody);

}