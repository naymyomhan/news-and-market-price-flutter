import 'package:json_annotation/json_annotation.dart';

part 'cities_model.g.dart';

@JsonSerializable()
class CitiesModel {
  final bool error;
  final String msg;
  final List<String> data;

  CitiesModel({
    required this.error,
    required this.msg,
    required this.data,
  });

  factory CitiesModel.fromJson(Map<String, dynamic> json) =>
      _$CitiesModelFromJson(json);
  Map<String, dynamic> toJson() => _$CitiesModelToJson(this);
}
