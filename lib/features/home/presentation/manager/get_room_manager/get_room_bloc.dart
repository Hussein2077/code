import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/home/domin/use_case/get_all_rooms_uc.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/get_room_manager/get_room_events.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/get_room_manager/get_room_states.dart';



class GetRoomsBloc extends Bloc<GetRoomEvents,GetRoomsStates>{

  final AllRoomsUsecase allRoomsUsecase;
  int page = 1 ;
  bool isLoadMore= false ;

  GetRoomsBloc({required this.allRoomsUsecase}):super(const GetRoomsStates()){
   // scrollController.addListener(() {
   //   log("hhhhhhhhhhhhhhhhhhhhhhhhhhhin pagination ");
   // //  add(LoadMoreRoomsEvent());
   // });
    on<GetRoomsEvent>(getRooms);
    on<LoadMoreRoomsEvent>(loadMoreRooms) ;

  }

  FutureOr<void> getRooms(GetRoomsEvent event, Emitter<GetRoomsStates> emit) async{
    emit(const GetRoomsStates(rooms: [] , getRoomsState:RequestState.loading,errorMessage:"roomsIsEmpty"));
    final result = await allRoomsUsecase.getAllRooms(countryId: event.countryId,page: 1,typeGetRooms: event.typeGetRooms);
    result.fold((l) => emit(GetRoomsStates(errorMessage: DioHelper().getTypeOfFailure(l) ,
        getRoomsState: RequestState.error)),
            (r) => emit(GetRoomsStates(rooms: r.data!, getRoomsState: RequestState.loaded , errorMessage: "roomsIsEmpty")));
    page = 1 ;
  }


  FutureOr<void> loadMoreRooms(LoadMoreRoomsEvent event, Emitter<GetRoomsStates> emit) async{
    // log(scrollController.position.pixels.toString() +":::"+scrollController.position.maxScrollExtent.toString());
    // if(scrollController.position.pixels == scrollController.position.maxScrollExtent  ){
    //      log("loaddding");
    //       isLoadMore = true ;
    //       page++ ;
    //       final result = await allRoomsUsecase.getAllRooms(countryId: event.countryId,page: page);
    //       result.fold((l) => emit(GetRoomsStates(errorMessage: Methods().getTypeOfFailure(l) , getRoomsState: RequestState.loaded)),
    //               (r) {
    //           if(r.data!.length == 0){
    //             log("empty rooms");
    //             emit(GetRoomsStates(rooms: state.rooms, getRoomsState: RequestState.loaded , errorMessage: "roomsIsEmpty"));
    //             isLoadMore = false ;
    //           } else{
    //             emit(GetRoomsStates(rooms: [...state.rooms,...r.data!], getRoomsState: RequestState.loaded));
    //           }
    //
    //               }) ;
    //
    //     }

    isLoadMore = true ;
                emit(GetRoomsStates(rooms: [...state.rooms,], getRoomsState: RequestState.loaded,errorMessage: ""));

    page++ ;
    final result = await allRoomsUsecase.getAllRooms(countryId: event.countryId,page: page,typeGetRooms: event.typeGetRooms);
    result.fold((l) => emit(GetRoomsStates(errorMessage: DioHelper().getTypeOfFailure(l) , getRoomsState: RequestState.error)),
            (r) {
          if(r.data!.isEmpty){
            emit(GetRoomsStates(rooms: state.rooms, getRoomsState: RequestState.loaded , errorMessage: ""));
            isLoadMore = false ;
          } else{

            isLoadMore = false ;
            emit(GetRoomsStates(rooms: [...state.rooms,...r.data!], getRoomsState: RequestState.loaded,errorMessage: ""));

          }

        }) ;

  }
}