import 'package:json_annotation/json_annotation.dart';

part 'local_news_model.g.dart';

@JsonSerializable()
class LocalNewsModel {
  final bool success;
  final String message;
  final List<LocalNewsModelList> data;

  LocalNewsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory LocalNewsModel.fromJson(Map<String, dynamic> json) => _$LocalNewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocalNewsModelToJson(this);
}

@JsonSerializable()
class LocalNewsModelList {
  final int id;
  final String title;
  final String description;
  final String newsDetails;
  final String imageUrl;
  final String newsType;
  final String createdAt;

  LocalNewsModelList({
    required this.id,
    required this.title,
    required this.description,
    required this.newsDetails,
    required this.imageUrl,
    required this.newsType,
    required this.createdAt,
  });

  factory LocalNewsModelList.fromJson(Map<String, dynamic> json) => _$LocalNewsModelListFromJson(json);
  Map<String, dynamic> toJson() => _$LocalNewsModelListToJson(this);
}
