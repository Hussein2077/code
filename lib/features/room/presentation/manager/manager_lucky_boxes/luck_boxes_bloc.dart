import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/room/domine/use_case/get_boxex_uc.dart';
import 'package:tik_chat_v2/features/room/domine/use_case/pickup_box_uc.dart';
import 'package:tik_chat_v2/features/room/domine/use_case/send_box_uc.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manager_lucky_boxes/luck_boxes_events.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manager_lucky_boxes/luck_boxes_states.dart';


class LuckyBoxesBloc extends Bloc<LuckyBoxesEvents,LuckyBoxesStates>{


  final GetBoxexUC getBoxexUC ;
  final SendBoxUC sendBoxUC ;
  final PickupBoxUC pickupBoxUC ;

  LuckyBoxesBloc({required  this.getBoxexUC, required this.sendBoxUC ,required this.pickupBoxUC}):super(InitialLuckyBoxesState()){
    on<GetBoxesEvent>(getBoxes);
    on<SendBoxesEvent>(sendBox) ;
    on<PickupBoxesEvent>(pickUpBox);
  }




  FutureOr<void> getBoxes(GetBoxesEvent event, Emitter<LuckyBoxesStates> emit) async {
     emit (LoadingLuckyBoxesState());

     final resutl = await getBoxexUC.call(const  Noparamiter());
     resutl.fold((l) => emit(SuccessLuckyBoxesState(boxLuckyModel: l)),
             (r) => emit(ErrorLuckyBoxesState(errorMessage: DioHelper().getTypeOfFailure(r))));

  }

  FutureOr<void> sendBox(SendBoxesEvent event, Emitter<LuckyBoxesStates> emit) async {
     emit(LoadingSendBoxesState());
     final resutl = await sendBoxUC.call(LuckyBoxPramiter(boxId: event.boxId, ownerId: event.ownerId, quintity: event.quintity)) ;
     resutl.fold((l) => emit(SuccessSendBoxesState(succeccMessage: StringManager.successfulOperation.tr())),
             (r) => emit(ErrorSendBoxesState(errorMessage: DioHelper().getTypeOfFailure(r))));
  }

  FutureOr<void> pickUpBox(PickupBoxesEvent event, Emitter<LuckyBoxesStates> emit) async {

    emit(LoadingPickUpBoxesState());
    final resutl = await pickupBoxUC.call(event.boxId);
    resutl.fold((l) => emit(SuccessPickUpBoxesState(succeccMessage: l)),
            (r) => emit(ErrorPickUpBoxesState(errorMessage: DioHelper().getTypeOfFailure(r))));

  }
}