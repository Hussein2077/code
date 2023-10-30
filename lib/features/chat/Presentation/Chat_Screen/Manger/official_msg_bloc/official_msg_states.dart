

import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/chat/data/models/official_msgs_model.dart';




class getOfficialMsgsStates extends Equatable {
  final OfficialSystemModel? data ;
  final RequestState officialMsgsState;
  final  String errorMessge ;

  getOfficialMsgsStates(
      { this.data ,
        this.officialMsgsState=RequestState.loading,
        this.errorMessge=""});

  @override
  List<Object?> get props => [data,officialMsgsState,errorMessge];




}