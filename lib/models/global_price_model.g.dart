// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_price_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GlobalPriceModel _$GlobalPriceModelFromJson(Map<String, dynamic> json) =>
    GlobalPriceModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GlobalPriceModelToJson(GlobalPriceModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      index: json['index'] as int,
      itemName: json['itemName'] as String,
      priceGlobal: json['priceGlobal'] as String,
      unit: json['unit'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'index': instance.index,
      'itemName': instance.itemName,
      'priceGlobal': instance.priceGlobal,
      'unit': instance.unit,
      'city': instance.city,
      'country': instance.country,
      'date': instance.date,
    };
