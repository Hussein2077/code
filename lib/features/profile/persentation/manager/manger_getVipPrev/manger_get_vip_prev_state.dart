
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/profile/data/model/get_vip_prev.dart';

abstract class MangerGetVipPrevState extends Equatable {
  const MangerGetVipPrevState();
  
  @override
  List<Object> get props => [];
}

class MangerGetVipPrevInitial extends MangerGetVipPrevState {

}

class GetVipPrevLoadingState extends MangerGetVipPrevState{}
class GetVipPrevErrorState extends MangerGetVipPrevState{
  final String error ; 
  const GetVipPrevErrorState({required this.error });
}

class GetVipPrevSucssesState extends MangerGetVipPrevState{
  final GetVipPrevModel data ; 

 const GetVipPrevSucssesState({required this.data });

}
