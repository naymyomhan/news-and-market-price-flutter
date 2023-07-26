import 'package:json_annotation/json_annotation.dart';

part 'articles_model.g.dart';

@JsonSerializable()
class ArticlesModel {
  final bool success;
  final String message;
  final List<ArticleModelList> data;

  ArticlesModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ArticlesModel.fromJson(Map<String, dynamic> json) => _$ArticlesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticlesModelToJson(this);
}

@JsonSerializable()
class ArticleModelList {
  final int id;
  final String title;
  final String description;
  final String newsDetails;
  final String imageUrl;
  final String newsType;
  final String createdAt;

  ArticleModelList({
    required this.id,
    required this.title,
    required this.description,
    required this.newsDetails,
    required this.imageUrl,
    required this.newsType,
    required this.createdAt,
  });

  factory ArticleModelList.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}
