import 'package:json_annotation/json_annotation.dart';

part 'items_model.g.dart';

@JsonSerializable()
class ItemsModel {
  final bool success;
  final String message;
  final List<String> data;

  ItemsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ItemsModel.fromJson(Map<String, dynamic> json) => _$ItemsModelFromJson(json);
  Map<String, dynamic> toJson() => _$ItemsModelToJson(this);
}
