import 'package:dartz/dartz.dart';

import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

class UpdateFamilyUC extends BaseUseCase<bool, UpdateFamilyPramiter> {
  BaseRepositoryProfile baseRepositoryProfile;

  UpdateFamilyUC({required this.baseRepositoryProfile});

  @override
  Future<Either<bool, Failure>> call(UpdateFamilyPramiter parameter) async {
    final result = await baseRepositoryProfile.updateFamily(parameter);

    return result;
  }
}

class UpdateFamilyPramiter extends Equatable {
  final String name;
  final String introduce;
  final String familyId ; 

  const UpdateFamilyPramiter(
      {required this.name, required this.introduce, required this.familyId});

  @override
  List<Object?> get props => [name, introduce, familyId];
}