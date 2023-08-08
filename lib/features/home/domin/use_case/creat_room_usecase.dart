import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/home/domin/repository/rebostory_ab.dart';



class CreateRoomUsecase{
  final RepoHome roomRepo;

  CreateRoomUsecase({required this.roomRepo});
  Future<Either<Failure,String>> createRoom({required CreateRoomPramiter creatRoomPramiter})async{
    return await roomRepo.createroom(creatRoomPramiter: creatRoomPramiter);
  }
}

class CreateRoomPramiter extends Equatable{
  final String? roomIntero;
  final File? roomCover;
  final String? roomType;
  final String? roomName ; 

  const CreateRoomPramiter({this.roomName,  this.roomIntero,  this.roomCover, this.roomType});

  @override
  List<Object?> get props => [id,roomIntero,roomCover,roomType , roomName];

}