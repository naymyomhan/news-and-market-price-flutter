import 'package:json_annotation/json_annotation.dart';

part 'marquee_model.g.dart';

@JsonSerializable()
class MarqueeModel {
  final bool success;
  final String message;
  final String data;

  MarqueeModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory MarqueeModel.fromJson(Map<String, dynamic> json) => _$MarqueeModelFromJson(json);
  Map<String, dynamic> toJson() => _$MarqueeModelToJson(this);
}
