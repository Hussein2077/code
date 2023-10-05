
 import 'package:equatable/equatable.dart';

 abstract class AdminRoomEvents  extends Equatable{
  @override
  List<Object?> get props => [];

}

class AddAdminEvent extends AdminRoomEvents{
   final String ownerId ;
   final String userId ;

   AddAdminEvent({required this.ownerId,required this.userId});
}


 class RemoveAdminEvent extends AdminRoomEvents{
   final String ownerId ;
   final String userId ;

   RemoveAdminEvent({required this.ownerId,required this.userId});
 }

 class GetAdminsEvent extends AdminRoomEvents{
   final String ownerId ;

   GetAdminsEvent({required this.ownerId});
 }