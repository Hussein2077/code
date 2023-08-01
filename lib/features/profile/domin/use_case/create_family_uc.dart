import 'dart:io';
import 'package:dartz/dartz.dart';

import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';


class CreateFamilyUC extends BaseUseCase<String, CreateFamilyPramiter> {
  BaseRepositoryProfile baseRepositoryProfile;

  CreateFamilyUC({required this.baseRepositoryProfile});

  @override
  Future<Either<String, Failure>> call(CreateFamilyPramiter parameter) async {
    final result = await baseRepositoryProfile.createFamily(parameter);

    return result;
  }
}

class CreateFamilyPramiter extends Equatable {
  final String name;
  final String introduce;
  // final String notice ;
  final File image;

  const CreateFamilyPramiter(
      {required this.name, required this.introduce, required this.image});

  @override
  List<Object?> get props => [name, introduce, image];
}
