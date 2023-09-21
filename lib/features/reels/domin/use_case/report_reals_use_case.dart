import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/reels/domin/repository/base_repository_reels.dart';

class ReportRealsUseCases {
  BaseRepositoryReels baseRepositoryReel;

  ReportRealsUseCases({required this.baseRepositoryReel});

  Future<Either<String, Failure>> reportReals(ReportRealsParameter realsParameter) async {
    final result = await baseRepositoryReel.reportReals(realsParameter);
    return result;
  }
}

class ReportRealsParameter extends Equatable {

  final String reportedId;
  final String description;
  final String realId;

  const ReportRealsParameter({
    required this.reportedId,
    required this.description,
    required this.realId,
  });

  @override
  List<Object> get props => [reportedId, description, realId];


}