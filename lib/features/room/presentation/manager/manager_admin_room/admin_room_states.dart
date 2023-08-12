import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';


abstract class AdminRoomStates extends Equatable{

}


class InitialAdminRoomState extends AdminRoomStates{
  @override
  List<Object?> get props => [];

}
class LoadindAddAdminRoomState extends AdminRoomStates{
  @override
  List<Object?> get props => [];

}
class SuccessAddAdminRoomState extends AdminRoomStates{
  @override
  List<Object?> get props => [];

}
class ErrorAddAdminRoomState extends AdminRoomStates{
  String errorMessage ;

  ErrorAddAdminRoomState({required this.errorMessage});

  @override
  List<Object?> get props => [ errorMessage];

}
class LoadingRemoveAdminRoomState extends AdminRoomStates{
  @override
  List<Object?> get props => [];

}
class SuccessRemoveAdminRoomState extends AdminRoomStates{
  @override
  List<Object?> get props => [];

}
class ErrorRemoveAdminRoomState extends AdminRoomStates{
  String errorMessage ;

  ErrorRemoveAdminRoomState({required this.errorMessage});

  @override
  List<Object?> get props => [ errorMessage];

}
class LoadingAdminsRoomState extends AdminRoomStates{
  @override
  List<Object?> get props => [];

}
class SuccessAdminsRoomState extends AdminRoomStates{

  final List<UserDataModel> admins ;


  SuccessAdminsRoomState({required this.admins});

  @override
  List<Object?> get props => [admins];

}
class ErrorAdminsRoomState extends AdminRoomStates{
  String errorMessage ;

  ErrorAdminsRoomState({required this.errorMessage});

  @override
  List<Object?> get props => [ errorMessage];

}