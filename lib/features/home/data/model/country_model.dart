import 'package:equatable/equatable.dart';

class CountryModel extends Equatable {
  final int? id;
  final String? name;
   final String? flag;

  const CountryModel(
      {required this.id,
      required this.name,
      required this.flag,
      });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id'],
      name: json['name'],
      flag: json['flag'],
    );
  }

  @override
  List<Object?> get props => [id, name, flag,];
}
