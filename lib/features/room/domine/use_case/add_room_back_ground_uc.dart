import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room/domine/Repository/Base_Repository_Profile.dart';

class AddRoomBackGroundUseCase {


  final BaseRepositoryRoom roomRepo;

  AddRoomBackGroundUseCase({required this.roomRepo});


  Future<Either<String, Failure>> call(File roomBackGround) async {
    return await roomRepo.addRoomBackGround(roomBackGround) ;
  }
}