import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/model/all_rooms_model.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/home/data/data_source/home_remote_data_source.dart';
import 'package:tik_chat_v2/features/home/data/model/carousels_model.dart';
import 'package:tik_chat_v2/features/home/data/model/config_model.dart';
import 'package:tik_chat_v2/features/home/data/model/country_model.dart';
import 'package:tik_chat_v2/features/home/data/model/user_rank_model.dart';
import 'package:tik_chat_v2/features/home/domin/repository/rebostory_ab.dart';
import 'package:tik_chat_v2/features/home/domin/use_case/creat_room_usecase.dart';
import 'package:tik_chat_v2/features/home/domin/use_case/get_top_usecase.dart';



class HomeRepostoryImp implements RepoHome{
  final HomeRemoteDataSours homeRemoteDataSours;

  HomeRepostoryImp( {required this.homeRemoteDataSours});


  @override
  Future<Either<Failure, AllRoomsDataModel>> getAllRooms(
      {int? countryId, int? classId, int? typeId, String? search, int? page ,
        TypeGetRooms? typeGetRooms}) async {
    try {
      final failureOrDone = await homeRemoteDataSours.getAllRooms(
          typeGetRooms: typeGetRooms,
          page:  page,
          countryId: countryId,
          classId: classId,
          typeId: typeId,
          search: search);
      return Right(failureOrDone);
    } on Exception catch (e) {
      return Left(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<List<CountryModel>, Failure>> getCountry() async {
    try {
      final result = await homeRemoteDataSours.getAllCountry();
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<List<CarouselsModel>, Failure>> getCarousels() async {
    try {
      final result = await homeRemoteDataSours.getCarousel();
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<RankingModel, Failure>> getTopRank(
      TopPramiter topPramiter) async {
    try {
      final result = await homeRemoteDataSours.getTop(topPramiter);
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
    

  }


  @override
  Future<Either<ConfigModel, Failure>> getConfigApp(
      ConfigModelBody configModelBody) async {
    try {
      final result = await homeRemoteDataSours.getConfigApp(configModelBody);
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }


  }

  @override
  Future<Either<Failure, String>> createroom(
      {CreateRoomPramiter? creatRoomPramiter}) async {
    try {
      final failureOrDone = await homeRemoteDataSours.createRoom(
          creatRoomPramiter: creatRoomPramiter!);
      return Right(failureOrDone);
    } on Exception catch (e) {
      return Left(DioHelper.buildFailure(e));
    }

  }
}