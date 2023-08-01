import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/model/vip_center_model.dart';


abstract class VipStates extends Equatable {
  const VipStates();
  @override
  List<Object?> get props => [];
}

class VipStatesInitialState extends VipStates{
  const VipStatesInitialState ();
}
class VipStatesLoadingState extends VipStates{
  const VipStatesLoadingState ();
}
class VipStatesSuccessState extends VipStates{
  final List<VipCenterModel> vipData ;
  const VipStatesSuccessState ({required this.vipData});
}
class VipStatesErrorState extends VipStates{
  final String message ;
  const VipStatesErrorState ({required this.message});
}



