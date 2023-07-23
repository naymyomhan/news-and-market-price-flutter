import 'package:json_annotation/json_annotation.dart';

part 'local_price_model.g.dart';

@JsonSerializable()
class LocalPriceModel {
  final bool success;
  final String message;
  final List<Data> data;

  LocalPriceModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory LocalPriceModel.fromJson(Map<String, dynamic> json) => _$LocalPriceModelFromJson(json);
  Map<String, dynamic> toJson() => _$LocalPriceModelToJson(this);
}

@JsonSerializable()
class Data {
  final int index;
  final String itemName;
  final String priceLocal;
  final String unit;
  final String city;
  final String stateDivision;
  final String date;

  Data({
    required this.index,
    required this.itemName,
    required this.priceLocal,
    required this.unit,
    required this.city,
    required this.stateDivision,
    required this.date,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}
