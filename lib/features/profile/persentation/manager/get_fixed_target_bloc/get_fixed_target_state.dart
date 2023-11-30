



import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/fixed_target_report.dart';

abstract class GetFixedTargetStates{
  final FixedTargetReportModel? data;

  GetFixedTargetStates(this.data);


}

class GetFixedTargetInitial extends GetFixedTargetStates {
  GetFixedTargetInitial(super.data);
}
class GetFixedTargetLoadingState extends GetFixedTargetStates {
  GetFixedTargetLoadingState(super.data);
}
class GetFixedTargetSucssesState extends GetFixedTargetStates {
  GetFixedTargetSucssesState( {required data}):super(data);
}
class GetFixedTargetErrorState extends GetFixedTargetStates {
  final String errorMassage ;
  GetFixedTargetErrorState(super.data, this.errorMassage);
}
