import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/home/data/model/country_model.dart';
import 'package:tik_chat_v2/features/home/domin/repository/rebostory_ab.dart';



class GetCountryUseCase extends BaseUseCase<List<CountryModel> , Noparamiter>{
  RepoHome roomRepo ;


  GetCountryUseCase({ required this.roomRepo});
  
  @override
  Future<Either<List<CountryModel>, Failure>> call(Noparamiter parameter) async{
   final result = await roomRepo.getCountry() ;

    return result ;
  }
  

}