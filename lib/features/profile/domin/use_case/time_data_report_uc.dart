

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/data/model/get_time_entities.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';


class TimeDataReportUseCases {

  BaseRepositoryProfile  getTimeDataReport ;


  TimeDataReportUseCases({required this.getTimeDataReport});

  Future<Either<TimeDataReport, Failure>> call(String parameter , String userId) async {

    final result = await getTimeDataReport.getTimeDataReport(parameter , userId);

    return result;

  }

}