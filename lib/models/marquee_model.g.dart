// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marquee_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarqueeModel _$MarqueeModelFromJson(Map<String, dynamic> json) => MarqueeModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] as String,
    );

Map<String, dynamic> _$MarqueeModelToJson(MarqueeModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
