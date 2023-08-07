
import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/features/room/data/model/gifts_model.dart';
import 'package:tik_chat_v2/features/room/domine/Repository/Base_Repository_Profile.dart';

import 'package:tik_chat_v2/core/error/failures.dart';


class GiftsUseCase extends BaseUseCase<List<GiftsModel>, int >{


  final BaseRepositoryRoom roomRepo;


  GiftsUseCase({required this.roomRepo});

  @override
  Future<Either<List<GiftsModel>, Failure>> call(int parameter)async {
   final result = await roomRepo.getGifts(parameter);
   return result ;
  }



}