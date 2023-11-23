import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/gifts_model.dart';



abstract class GiftsState extends Equatable {
  const GiftsState();

  @override
  List<Object> get props => [];
}

class GetGiftInitial extends GiftsState {}


class GetNormalGifLoading extends GiftsState {}

class GetNormalGifSucsses extends GiftsState {
  final List<GiftsModel> data;
  const GetNormalGifSucsses({required this.data});
}
class GetNormalGifError extends GiftsState {
  final String error ;
  const GetNormalGifError ({required this.error});
}


class GetHotGifLoading extends GiftsState {}

class GetHotGifSucsses extends GiftsState {
  final List<GiftsModel> data;
  const GetHotGifSucsses({required this.data});
}
class GetHotGifError extends GiftsState {
  final String error ;
  const GetHotGifError ({required this.error});
}


class GetCountryGifLoading extends GiftsState {}

class GetCountryGifSucsses extends GiftsState {
  final List<GiftsModel> data;
  const GetCountryGifSucsses({required this.data});
}
class GetCountryGifError extends GiftsState {
  final String error ;
  const GetCountryGifError ({required this.error});
}

class GetFamousGifLoading extends GiftsState {}

class GetFamousGifSucsses extends GiftsState {
  final List<GiftsModel> data;
  const GetFamousGifSucsses({required this.data});
}
class GetFamousGifError extends GiftsState {
  final String error ;
  const GetFamousGifError ({required this.error});
}

class GetLuckyGifLoading extends GiftsState {}

class GetLuckyGifSucsses extends GiftsState {
  final List<GiftsModel> data;
  const GetLuckyGifSucsses({required this.data});
}
class GetLuckyGifError extends GiftsState {
  final String error ;
  const GetLuckyGifError ({required this.error});
}

class GetMomentGifLoading extends GiftsState {}

class GetMomentGifSucsses extends GiftsState {
  final List<GiftsModel> data;
  const GetMomentGifSucsses({required this.data});
}
class GetMomentGifError extends GiftsState {
  final String error ;
  const GetMomentGifError ({required this.error});
}