

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/data/model/fixed_target_report.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';


class FixedTargetReportUseCase {

  BaseRepositoryProfile  FixedTargetReportReport ;


  FixedTargetReportUseCase({required this.FixedTargetReportReport});

  Future<Either<FixedTargetReportModel, Failure>> call(String date) async {

    final result = await FixedTargetReportReport.getFixedTargetReport(date);

    return result;

  }

}