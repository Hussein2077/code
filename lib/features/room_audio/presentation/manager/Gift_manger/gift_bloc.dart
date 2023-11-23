import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/getGiftes_useCase.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/Gift_manger/gift_events.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/Gift_manger/gift_states.dart';



class GiftBloc extends Bloc<GiftEvent,GiftsState>
{

  final GiftsUseCase giftsUseCase ;


  GiftBloc({required this.giftsUseCase}): super(GetGiftInitial()){

    on<GiftesNormalEvent>(getNormalGift);
    on<GiftesHotEvent>(gethotGift);
    on<GiftesCountryEvent>(getCountryGift);
    on<GiftesFamousEvent>(getFamousGift);
    on<GiftesLuckyEvent>(getLuckyGift) ;
    on<GiftesMomentEvent>(getMomentGift);

  }

  FutureOr<void> gethotGift(GiftesHotEvent event, emit)async {

    emit(GetHotGifLoading());

    final result = await giftsUseCase.call(event.type);

    result.fold((l) => emit(GetHotGifSucsses(data: l)),
            (r) => emit(GetHotGifError(error: DioHelper().getTypeOfFailure(r))));

  }

  FutureOr<void> getNormalGift(GiftesNormalEvent event, emit)async {
    emit(GetNormalGifLoading());

    final result = await giftsUseCase.call(event.type);

    result.fold((l) => emit(GetNormalGifSucsses(data: l)),
            (r) => emit(GetNormalGifError(error: DioHelper().getTypeOfFailure(r))));

  }

  FutureOr<void> getCountryGift(GiftesCountryEvent event, emit)async {
    emit(GetCountryGifLoading());
    final result = await giftsUseCase.call(event.type);
    result.fold((l) => emit(GetCountryGifSucsses(data: l)),
            (r) => emit(GetCountryGifError(error: DioHelper().getTypeOfFailure(r))));
  }

  FutureOr<void> getFamousGift(GiftesFamousEvent event, emit)async {
    emit(GetFamousGifLoading());
    final result = await giftsUseCase.call(event.type);
    result.fold((l) => emit(GetFamousGifSucsses(data: l)),
            (r) => emit(GetFamousGifError(error: DioHelper().getTypeOfFailure(r))));
  }

  FutureOr<void> getLuckyGift(GiftesLuckyEvent event, emit)async {
    emit(GetLuckyGifLoading());
    final result = await giftsUseCase.call(event.type);
    result.fold((l) => emit(GetLuckyGifSucsses(data: l)),
            (r) => emit(GetLuckyGifError(error: DioHelper().getTypeOfFailure(r))));
  }

  FutureOr<void> getMomentGift(GiftesMomentEvent event, emit) async {
    emit(GetMomentGifLoading());
    final result = await giftsUseCase.call(event.type);
    result.fold(
            (l) => emit(GetMomentGifSucsses(data: l)),
            (r) => emit(GetMomentGifError(error: DioHelper().getTypeOfFailure(r))));
  }


}