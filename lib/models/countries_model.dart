import 'package:json_annotation/json_annotation.dart';

part 'countries_model.g.dart';

@JsonSerializable()
class CountriesModel {
  final bool error;
  final String msg;
  final List<Data> data;

  CountriesModel({
    required this.error,
    required this.msg,
    required this.data,
  });

  factory CountriesModel.fromJson(Map<String, dynamic> json) => _$CountriesModelFromJson(json);
  Map<String, dynamic> toJson() => _$CountriesModelToJson(this);
}

@JsonSerializable()
class Data {
  final String country;
  final List<String> cities;

  Data({
    required this.country,
    required this.cities,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}
