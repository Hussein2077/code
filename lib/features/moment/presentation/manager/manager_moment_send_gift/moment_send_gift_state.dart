import 'package:equatable/equatable.dart';

abstract class MomentSendGiftStates extends Equatable{
  const MomentSendGiftStates();
  @override
  List<Object> get props => [];
}

class MomentSEndGiftInitialState extends MomentSendGiftStates{
}
class MomentSEndGiftLoadingState extends MomentSendGiftStates{}
class MomentSendGiftSucssesState extends MomentSendGiftStates{
  final String sucssesMessage;
 const MomentSendGiftSucssesState({required this.sucssesMessage});
}
class MomentSEndGiftErrorState extends MomentSendGiftStates{

  final String errorMessage;
  const MomentSEndGiftErrorState({required this.errorMessage});
}
