import 'package:equatable/equatable.dart';

abstract class ReportMomentStates extends Equatable{
  const ReportMomentStates();
  @override
  List<Object> get props => [];
}

class ReportMomentInitialState extends ReportMomentStates{
}
class ReportMomentLoadingState extends ReportMomentStates{}
class ReportMomentSucssesState extends ReportMomentStates{
  final String sucssesMessage;
  const ReportMomentSucssesState({required this.sucssesMessage});
}
class ReportMomentErrorState extends ReportMomentStates{

  final String errorMessage;
  const ReportMomentErrorState({required this.errorMessage});
}
