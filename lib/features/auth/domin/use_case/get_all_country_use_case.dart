import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/auth/data/model/country_model.dart';
import 'package:tik_chat_v2/features/auth/domin/repo/base_repo.dart';

class GetAllCountriesUC
    extends BaseUseCase<GetAllCountriesBase, Noparamiter> {
  BaseRepository baseRepository;

  GetAllCountriesUC({required this.baseRepository});

  @override
  Future<Either<GetAllCountriesBase, Failure>> call(
      Noparamiter parameter) async {
    final result = await baseRepository.getAllCountries();
    return result;
  }
}
