




import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';

abstract class GetMomentAllState  {
     final List<MomentModel>? data ;
    GetMomentAllState(this.data);
}

 class GetMomentAllInitial extends GetMomentAllState {
   GetMomentAllInitial(super.data);

 }
 class GetMomentAllLoadingState extends GetMomentAllState {
   GetMomentAllLoadingState(super.data);

 }
 class GetMomentAllSucssesState extends GetMomentAllState {
   GetMomentAllSucssesState({required data}) : super(data);

  
 }
 class GetMomentAllErrorState extends GetMomentAllState {
    final String errorMassage ;

    GetMomentAllErrorState( super.data, this.errorMassage);

 }
