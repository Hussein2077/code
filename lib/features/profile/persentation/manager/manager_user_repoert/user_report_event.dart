
import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class UserReportEvent extends Equatable {
  const UserReportEvent();

  @override
  List<Object> get props => [];
}

class UserReporetEvent extends UserReportEvent {
   final String ?id ;
 final String? typeReporet ;
 final File? image ;
 final String? reporetContetnt ;


 const UserReporetEvent ({this.id , this.image , this.reporetContetnt , this.typeReporet});
}