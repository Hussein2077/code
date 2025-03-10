import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/home/domin/repository/rebostory_ab.dart';



class CreateRoomUsecase{
  final RepoHome repoHome;

  CreateRoomUsecase({required this.repoHome});
  Future<Either<Failure,String>> createRoom({required CreateRoomPramiter creatRoomPramiter})async{
    return await repoHome.createroom(creatRoomPramiter: creatRoomPramiter);
  }
}

class CreateRoomPramiter extends Equatable{
  final String? roomIntero;
  final File? roomCover;
  final String? roomType;
  final String? roomName ;
  final String? roomPassword ;
  const CreateRoomPramiter({this.roomName,  this.roomIntero,  this.roomCover,this.roomPassword ,this.roomType});

  @override
  List<Object?> get props => [id,roomIntero,roomCover,roomType , roomPassword,roomName];

}