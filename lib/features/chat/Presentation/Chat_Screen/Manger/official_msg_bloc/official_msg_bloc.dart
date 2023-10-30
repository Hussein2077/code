

import 'dart:async';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/chat/Presentation/Chat_Screen/Manger/official_msg_bloc/official_msg_events.dart';
import 'package:tik_chat_v2/features/chat/Presentation/Chat_Screen/Manger/official_msg_bloc/official_msg_states.dart';
import 'package:tik_chat_v2/features/chat/domine/usecases/get_officialMsg_UC.dart';

import '../../../../../../core/base_use_case/base_use_case.dart';

class GetOfficialMsgsBloc extends Bloc<OfficailMsgEvents,getOfficialMsgsStates>{

 final GetOfficialMsgUC getOfficialMsgUC ;
 GetOfficialMsgsBloc( { required this.getOfficialMsgUC}): super(  getOfficialMsgsStates()){

    on<getOfficailMsgsEvent>(getOfficialMsgs);

  }

  FutureOr<void> getOfficialMsgs(getOfficailMsgsEvent event, Emitter<getOfficialMsgsStates> emit)  async{

    final result = await getOfficialMsgUC.call(const Noparamiter());
    print(result);
    result.fold(
            (l) => emit(getOfficialMsgsStates(data: l,  officialMsgsState :RequestState.loaded)),
            (r) => emit(getOfficialMsgsStates(officialMsgsState: RequestState.error,
                errorMessge: DioHelper().getTypeOfFailure(r))));


  }
}
