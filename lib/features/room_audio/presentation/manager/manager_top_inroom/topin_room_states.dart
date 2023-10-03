import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/home/data/model/user_top_model.dart';



class GetTopInRoomState extends Equatable{
  final List<UserTopModel> todayUserTopModel ;
  final List<UserTopModel> totalUserTopModel ;
  final RequestState todayState;
  final RequestState totalState;
  final String todayErrorMassage;
  final String totalErrorMassage;

  const GetTopInRoomState(
      {this.todayUserTopModel=const[],
        this.totalUserTopModel=const [],
        this.todayState= RequestState.loading,
        this.totalState= RequestState.loading,
        this.todayErrorMassage="",
        this.totalErrorMassage=""});

  GetTopInRoomState copyWith({
    List<UserTopModel>? todayUserTopModel ,
    List<UserTopModel>? totalUserTopModel ,
    RequestState? todayState,
    RequestState? totalState,
    String? todayErrorMassage,
    String? totalErrorMassage,
  }){
    return GetTopInRoomState(
        todayUserTopModel: todayUserTopModel ?? this.todayUserTopModel,
        todayErrorMassage: todayErrorMassage ?? this.todayErrorMassage,
        todayState: todayState ?? this.todayState,
        totalUserTopModel: totalUserTopModel ?? this.totalUserTopModel,
        totalErrorMassage: totalErrorMassage ?? this.totalErrorMassage,
        totalState: totalState ?? this.totalState

    );
  }

  @override

  List<Object?> get props => [
 todayUserTopModel ,
  totalUserTopModel ,
    todayState,
    totalState,
    todayErrorMassage,
    totalErrorMassage,
  ];

}