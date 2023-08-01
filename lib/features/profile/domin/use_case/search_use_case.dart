


import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/data/model/search_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

class SearchUseCase extends BaseUseCase<SearchModel,String>{

   BaseRepositoryProfile baseRepositoryProfile;


  SearchUseCase({required this.baseRepositoryProfile});

  @override
  Future<Either<SearchModel, Failure>> call(String parameter) async {
    final result=  await baseRepositoryProfile.search(parameter);
    return result ;
  }


}