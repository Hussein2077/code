import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/data/model/agency_my_store.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

class GetMyStoreUseCase {


  BaseRepositoryProfile baseRepositoryProfile ;


  GetMyStoreUseCase({ required this.baseRepositoryProfile});

  Future<Either<AgencyMyStoreModel, Failure>> getMyStore()async {
     final result= await baseRepositoryProfile.myStore() ;
     return result ;
  }


}