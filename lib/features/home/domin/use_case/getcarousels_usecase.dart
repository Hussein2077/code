
import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/home/data/model/carousels_model.dart';
import 'package:tik_chat_v2/features/home/domin/repository/rebostory_ab.dart';



class GetCarouselsUsecase extends BaseUseCase<List<CarouselsModel>,Noparamiter>{

  final RepoHome repoHome;


  GetCarouselsUsecase({required this.repoHome});

  @override
  Future<Either<List<CarouselsModel>, Failure>> call(Noparamiter parameter) async{
    final result = await repoHome.getCarousels() ;
    return result ;
  }

}