
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/home/data/model/carousels_model.dart';


abstract  class CarouselStates extends Equatable{


}
class CarouselInitial extends CarouselStates{
  @override
  List<Object?> get props => [];
}
class GetCarouselSuccesState extends CarouselStates{
  final List<CarouselsModel> carouselsList ;

  GetCarouselSuccesState({required this.carouselsList});

  @override

  List<Object?> get props => [carouselsList];
}
class CarouselLoadingStates extends CarouselStates{

  @override
  List<Object?> get props => [];

}

class GetCarouselErrorState extends CarouselStates{
  final String errorMessage ;

  GetCarouselErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

