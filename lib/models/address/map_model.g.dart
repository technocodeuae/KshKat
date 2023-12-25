// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapModel _$MapModelFromJson(Map<String, dynamic> json) => MapModel(
      data: json['data'] == null
          ? null
          : MapData.fromJson(json['data'] as Map<String, dynamic>),
      code: json['code'] as int?,
      message: json['message'] as int?,
    );

Map<String, dynamic> _$MapModelToJson(MapModel instance) => <String, dynamic>{
      'data': instance.data?.toJson(),
      'code': instance.code,
      'message': instance.message,
    };

MapData _$MapDataFromJson(Map<String, dynamic> json) => MapData(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MapDataToJson(MapData instance) => <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: json['id'] as int,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
    };
