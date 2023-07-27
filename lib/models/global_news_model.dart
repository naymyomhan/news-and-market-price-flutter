import 'package:json_annotation/json_annotation.dart';

part 'global_news_model.g.dart';

@JsonSerializable()
class GlobalNewsModel {
  final bool success;
  final String message;
  final List<GlobalNewsModelList> data;

  GlobalNewsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GlobalNewsModel.fromJson(Map<String, dynamic> json) => _$GlobalNewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$GlobalNewsModelToJson(this);
}

@JsonSerializable()
class GlobalNewsModelList {
  final int id;
  final String title;
  final String description;
  final String newsDetails;
  final String imageUrl;
  final String newsType;
  final String createdAt;

  GlobalNewsModelList({
    required this.id,
    required this.title,
    required this.description,
    required this.newsDetails,
    required this.imageUrl,
    required this.newsType,
    required this.createdAt,
  });

  factory GlobalNewsModelList.fromJson(Map<String, dynamic> json) => _$GlobalNewsModelListFromJson(json);
  Map<String, dynamic> toJson() => _$GlobalNewsModelListToJson(this);
}
