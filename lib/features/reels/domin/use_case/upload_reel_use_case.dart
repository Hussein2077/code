import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/reels/domin/repository/base_repository_reels.dart';

class UploadReelUseCase {
  BaseRepositoryReels baseRepositoryReel;

  UploadReelUseCase({required this.baseRepositoryReel});

  Future<Either<String, Failure>> uploadReel(UploadReelParamiter uploadReelParamiter) async {
    final result = await baseRepositoryReel.uploadReel(uploadReelParamiter);
    return result;
  }
}

class UploadReelParamiter extends Equatable {

  final File reel;

  final String description;
  final List<int> categories ; 

  const UploadReelParamiter({required this.reel, required this.description, required this.categories});

  @override
  List<Object> get props => [reel, description];


}