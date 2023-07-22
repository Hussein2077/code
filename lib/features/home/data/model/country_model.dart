import 'package:equatable/equatable.dart';

class CountryModel extends Equatable {



  final int? id;
  final String? name;
  final String? flag;
  final String? lang;
  final String? phoneCode;

  const CountryModel(
      {required this.id,
        required this.name,
        required this.flag,
        required this.lang,
        this.phoneCode});




  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id : json['id'],
      name : json['name'],
      flag : json['flag'],
      lang : json['lang'],
      phoneCode : json['phone_code'],);

  }
  @override
  List<Object?> get props => [id, name, flag, lang, phoneCode];

}
