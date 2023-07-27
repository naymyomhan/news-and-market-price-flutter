// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GlobalNewsModel _$GlobalNewsModelFromJson(Map<String, dynamic> json) =>
    GlobalNewsModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => GlobalNewsModelList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GlobalNewsModelToJson(GlobalNewsModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

GlobalNewsModelList _$GlobalNewsModelListFromJson(Map<String, dynamic> json) =>
    GlobalNewsModelList(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      newsDetails: json['newsDetails'] as String,
      imageUrl: json['imageUrl'] as String,
      newsType: json['newsType'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$GlobalNewsModelListToJson(
        GlobalNewsModelList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'newsDetails': instance.newsDetails,
      'imageUrl': instance.imageUrl,
      'newsType': instance.newsType,
      'createdAt': instance.createdAt,
    };
