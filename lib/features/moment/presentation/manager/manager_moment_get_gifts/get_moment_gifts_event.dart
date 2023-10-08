import 'package:equatable/equatable.dart';

class BaseGetMomentGiftsEvent extends Equatable{
  const BaseGetMomentGiftsEvent();
  @override
  List<Object> get props => [];
}

class GetMomentGiftsEvent extends BaseGetMomentGiftsEvent{
  final String momentId;
  const GetMomentGiftsEvent({required this.momentId});

}
class LoadMoreMomentGiftsEvent extends BaseGetMomentGiftsEvent{

  final String momentId;
  const LoadMoreMomentGiftsEvent({required this.momentId});

}