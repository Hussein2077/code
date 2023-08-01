


import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/error/failures.dart';

abstract class BaseUseCase<T,Parameter>{

Future<Either<T,Failure>> call(Parameter parameter);

}

class Noparamiter extends Equatable {
  const Noparamiter();

  @override
  List<Object?> get props => [];


}