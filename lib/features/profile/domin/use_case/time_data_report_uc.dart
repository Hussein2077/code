

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/data/model/get_time_entities.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';


class TimeDataReportUseCases extends BaseUseCase<TimeDataReport,String>{

  BaseRepositoryProfile  getTimeDataReport ;


  TimeDataReportUseCases({required this.getTimeDataReport});

  @override
  Future<Either<TimeDataReport, Failure>> call(String parameter) async {

    final result = await getTimeDataReport.getTimeDataReport(parameter);

    return result;

  }

}