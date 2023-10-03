
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/all_main_classes_model.dart';

class CreateRoomStates extends Equatable {
  final List<AllMainClassesModel> typesRoom ;
  final String typesErrorMessage ;
  final RequestState typesRoomState ;
  final String createSuccecRoom ;
  final String createRoomErrorMessage ;
  final RequestState createRoomState ;

  const CreateRoomStates(
      {
      this.typesRoom =const [],
      this.typesErrorMessage='',
      this.typesRoomState=RequestState.loading,
      this.createSuccecRoom='',
      this.createRoomErrorMessage='',
      this.createRoomState=RequestState.loading
      });


  CreateRoomStates copyWith({
    List<AllMainClassesModel>? typesRoom,
    RequestState? typesRoomState,
    String? typesErrorMessage,
    String? createSuccecRoom,
    RequestState? createRoomState,
    String? createRoomErrorMessage,
  }) {
    return CreateRoomStates(
        typesRoom: typesRoom ?? this.typesRoom,
        typesRoomState: typesRoomState ?? this.typesRoomState,
        typesErrorMessage: typesErrorMessage ?? this.typesErrorMessage,
      createSuccecRoom: createSuccecRoom ?? this.createSuccecRoom,
      createRoomState: createRoomState ?? this.createRoomState,
      createRoomErrorMessage: createRoomErrorMessage ?? this.createRoomErrorMessage,
    );
  }

  @override
  List<Object?> get props => [typesRoom,typesErrorMessage,typesRoomState,createRoomErrorMessage,createRoomState,createSuccecRoom];
}
