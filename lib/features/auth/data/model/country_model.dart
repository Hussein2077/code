import 'package:equatable/equatable.dart';

class GetAllCountriesBase extends Equatable {
  final List<GetAllCountriesModel> allCounties;
  final List<GetAllCountriesModel> allCountiesSearch;

  const GetAllCountriesBase(
      {required this.allCounties, required this.allCountiesSearch});

  factory GetAllCountriesBase.fromJson(List<dynamic> json) {

    List<GetAllCountriesModel> allResult = [];
    List<GetAllCountriesModel> searcResult = [];

    for (int i = 0; i < json.length; i++) {
      allResult.add(GetAllCountriesModel.fromJson(json[i]));
      searcResult.add(GetAllCountriesModel.fromJsonSearch(json[i]));
    }
    return GetAllCountriesBase(
        allCounties: allResult, allCountiesSearch: searcResult);
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetAllCountriesModel extends Equatable {
  final int? id;
  final String name;
  final String eName;
  final String? flag;

  const GetAllCountriesModel({
    this.id,
    required this.name,
    required this.eName,
    this.flag,
  });

  factory GetAllCountriesModel.fromJson(Map<String, dynamic> json) {
    return GetAllCountriesModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      eName: json['e_name'] ?? "",
      flag: json['flag'] ?? '',
    );
  }

  factory GetAllCountriesModel.fromJsonSearch(Map<String, dynamic> json) {
    return GetAllCountriesModel(
      name: json['name'] ?? "",
      eName: json['e_name'] ?? "",
    );
  }

  SearchCountryObject compareTo() {
    return SearchCountryObject(
      name: name,
      eName: eName,
    );
  }

  @override
  List<Object?> get props => [id, name, eName, flag];
}

class SearchCountryObject {
  final String name;
  final String eName;

  SearchCountryObject({required this.name, required this.eName});
}
