import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/features/auth/domin/repo/base_repo.dart';

class AddInFormationUC extends BaseUseCase<MyDataModel, InformationPramiter> {
  BaseRepository baseRepository;

  AddInFormationUC({required this.baseRepository});

  @override
  Future<Either<MyDataModel, Failure>> call(
      InformationPramiter parameter) async {
    final result = await baseRepository.addInformation(parameter);

    return result;
  }
}

class InformationPramiter extends Equatable {
  final String? bio;
  final String? name;
  final String? date;
  final File? image;
  final int? gender;
  final int? countryID;
  final String? email;

  const InformationPramiter({
    this.bio,
    this.gender,
    this.image,
    this.countryID,
    this.date,
    this.name,
    this.email,
  });

  @override
  List<Object?> get props => [countryID, name, date, image, gender, email];
}
