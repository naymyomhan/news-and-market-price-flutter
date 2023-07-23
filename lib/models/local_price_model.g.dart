// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_price_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalPriceModel _$LocalPriceModelFromJson(Map<String, dynamic> json) =>
    LocalPriceModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LocalPriceModelToJson(LocalPriceModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      index: json['index'] as int,
      itemName: json['itemName'] as String,
      priceLocal: json['priceLocal'] as String,
      unit: json['unit'] as String,
      city: json['city'] as String,
      stateDivision: json['stateDivision'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'index': instance.index,
      'itemName': instance.itemName,
      'priceLocal': instance.priceLocal,
      'unit': instance.unit,
      'city': instance.city,
      'stateDivision': instance.stateDivision,
      'date': instance.date,
    };
