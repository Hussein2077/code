
import 'package:equatable/equatable.dart';

abstract class MallEvent extends Equatable {
  const MallEvent();

  @override
  List<Object> get props => [];
}

class GetCarMallEvent extends MallEvent{
 final  int type ;


  const GetCarMallEvent({required this.type});

  

}
class GetFramesMallEvent extends MallEvent{
  final  int type ;


  const GetFramesMallEvent({required this.type});



}
class GetBubbleMallEvent extends MallEvent{
  final  int type ;


  const GetBubbleMallEvent({required this.type});

 

}