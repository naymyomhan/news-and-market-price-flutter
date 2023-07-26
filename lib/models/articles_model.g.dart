// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articles_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticlesModel _$ArticlesModelFromJson(Map<String, dynamic> json) => ArticlesModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>).map((e) => ArticleModelList.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$ArticlesModelToJson(ArticlesModel instance) => <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

ArticleModelList _$DataFromJson(Map<String, dynamic> json) => ArticleModelList(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      newsDetails: json['newsDetails'] as String,
      imageUrl: json['imageUrl'] as String,
      newsType: json['newsType'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$DataToJson(ArticleModelList instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'newsDetails': instance.newsDetails,
      'imageUrl': instance.imageUrl,
      'newsType': instance.newsType,
      'createdAt': instance.createdAt,
    };
