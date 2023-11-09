
import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/moment/domain/repository/base_repository_moment.dart';


class ReportMomentUseCase extends BaseUseCase<String, ReportMomentParam> {
  BaseRepositoryMoment baseRepositoryMoment;
  ReportMomentUseCase({required this.baseRepositoryMoment});
  @override
  Future<Either<String, Failure>> call(ReportMomentParam parameter,) async {
    final result = await baseRepositoryMoment.reportMoment(parameter);
    return result;
  }
}



class ReportMomentParam{
  final String discreption;
  final String momentId;
  final String type;
  const ReportMomentParam({

    required this.discreption,
    required this.momentId,
    required this.type,
});
}

