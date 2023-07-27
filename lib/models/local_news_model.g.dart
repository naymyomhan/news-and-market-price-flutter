// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalNewsModel _$LocalNewsModelFromJson(Map<String, dynamic> json) =>
    LocalNewsModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => LocalNewsModelList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LocalNewsModelToJson(LocalNewsModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

LocalNewsModelList _$LocalNewsModelListFromJson(Map<String, dynamic> json) =>
    LocalNewsModelList(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      newsDetails: json['newsDetails'] as String,
      imageUrl: json['imageUrl'] as String,
      newsType: json['newsType'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$LocalNewsModelListToJson(LocalNewsModelList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'newsDetails': instance.newsDetails,
      'imageUrl': instance.imageUrl,
      'newsType': instance.newsType,
      'createdAt': instance.createdAt,
    };
