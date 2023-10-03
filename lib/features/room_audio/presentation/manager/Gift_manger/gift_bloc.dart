import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/getGiftes_useCase.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/Gift_manger/gift_events.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/Gift_manger/gift_states.dart';



class GiftBloc extends Bloc<GiftEvent,GiftsStates>
{

  final GiftsUseCase giftsUseCase ;


  GiftBloc({required this.giftsUseCase}): super(const GiftsStates()){

    on<GiftesNormalEvent>(gethotGift);
    on<GiftesHotEvent>(getNormalGift);
    on<GiftesCountryEvent>(getCountryGift);
    on<GiftesFamousEvent>(getFamousGift);
    on<GiftesLuckyEvent>(getLuckyGift) ;
  }

  FutureOr<void> gethotGift(GiftesNormalEvent event, Emitter<GiftsStates> emit)async {

    final result = await giftsUseCase.call(event.type);

    result.fold((l) => emit(state.copyWith(dataNormal: l,normalState: RequestState.loaded)),
            (r) => emit(state.copyWith(normalMessage: DioHelper().getTypeOfFailure(r),normalState: RequestState.error)));

  }

  FutureOr<void> getNormalGift(GiftesHotEvent event, Emitter<GiftsStates> emit)async {

    final result = await giftsUseCase.call(event.type);

    result.fold((l) => emit(state.copyWith(dataHot: l,hotState: RequestState.loaded)),
            (r) => emit(state.copyWith(hotMessage: DioHelper().getTypeOfFailure(r),hotState: RequestState.error)));

  }




  FutureOr<void> getCountryGift(GiftesCountryEvent event, Emitter<GiftsStates> emit)async {
    final result = await giftsUseCase.call(event.type);
    result.fold((l) => emit(state.copyWith(dataCountry: l,countryState: RequestState.loaded)),
            (r) => emit(state.copyWith(countryMessage: DioHelper().getTypeOfFailure(r),countryState: RequestState.error)));
  }

  FutureOr<void> getFamousGift(GiftesFamousEvent event, Emitter<GiftsStates> emit)async {
    final result = await giftsUseCase.call(event.type);
    result.fold((l) => emit(state.copyWith(dataFamous: l,famousState: RequestState.loaded)),
            (r) => emit(state.copyWith(famousMessage: DioHelper().getTypeOfFailure(r),famousState: RequestState.error)));
  }
  FutureOr<void> getLuckyGift(GiftesLuckyEvent event, Emitter<GiftsStates> emit)async {
    final result = await giftsUseCase.call(event.type);
    result.fold((l) => emit(state.copyWith(dataLucky: l,luckyState: RequestState.loaded)),
            (r) => emit(state.copyWith(luckyMessage: DioHelper().getTypeOfFailure(r),luckyState: RequestState.error)));
  }

}