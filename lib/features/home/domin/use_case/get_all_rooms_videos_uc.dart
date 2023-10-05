import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/model/all_rooms_model.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/home/domin/repository/rebostory_ab.dart';




class AllRoomsVideosUsecase{
  final RepoHome repoHome;

  AllRoomsVideosUsecase({required this.repoHome});
  Future<Either<Failure, AllRoomsDataModel>> getAllRoomsVideo({ int? countryId, int? classId, int? typeId, String? search, int? page,TypeGetRooms? typeGetRooms})async{
    return await repoHome.getAllRoomsVideo(countryId: countryId,
      classId: classId,typeId: typeId,
      search: search,
      page:page,
      typeGetRooms: typeGetRooms ,

    );
  }
}