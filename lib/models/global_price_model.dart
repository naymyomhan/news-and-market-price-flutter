import 'package:json_annotation/json_annotation.dart';

part 'global_price_model.g.dart';

@JsonSerializable()
class GlobalPriceModel {
  final bool success;
  final String message;
  final List<Data> data;

  GlobalPriceModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GlobalPriceModel.fromJson(Map<String, dynamic> json) => _$GlobalPriceModelFromJson(json);
  Map<String, dynamic> toJson() => _$GlobalPriceModelToJson(this);
}

@JsonSerializable()
class Data {
  final int index;
  final String itemName;
  final String priceGlobal;
  final String unit;
  final String city;
  final String country;
  final String date;

  Data({
    required this.index,
    required this.itemName,
    required this.priceGlobal,
    required this.unit,
    required this.city,
    required this.country,
    required this.date,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}
