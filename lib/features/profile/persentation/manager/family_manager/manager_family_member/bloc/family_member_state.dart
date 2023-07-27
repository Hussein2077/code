
import 'package:tik_chat_v2/features/profile/data/model/family_member_model.dart';


abstract class FamilyMemberState  {
      final FamilyMemberModel? data ; 

  const FamilyMemberState(this.data);

}

class FamilyMemberInitial extends FamilyMemberState {
  FamilyMemberInitial(super.data);
}

class GetFamilyMemberSucssesState extends FamilyMemberState {
 GetFamilyMemberSucssesState({required data}) : super(data);
}

class GetFamilyMemberLoadingState extends FamilyMemberState {
   GetFamilyMemberLoadingState(super.data);
}

class GetFamilyMemberErrorState extends FamilyMemberState {
  final String errorMassage ; 
   GetFamilyMemberErrorState( super.data, this.errorMassage);
}
