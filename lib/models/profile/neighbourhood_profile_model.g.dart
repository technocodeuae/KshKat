// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'neighbourhood_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NeighbourhoodProfileModel _$NeighbourhoodProfileModelFromJson(
        Map<String, dynamic> json) =>
    NeighbourhoodProfileModel(
      data: json['data'] == null
          ? null
          : NeighbourhoodProfileData.fromJson(
              json['data'] as Map<String, dynamic>),
      code: json['code'] as int?,
      message: json['message'] as int?,
    );

Map<String, dynamic> _$NeighbourhoodProfileModelToJson(
        NeighbourhoodProfileModel instance) =>
    <String, dynamic>{
      'data': instance.data?.toJson(),
      'code': instance.code,
      'message': instance.message,
    };

NeighbourhoodProfileData _$NeighbourhoodProfileDataFromJson(
        Map<String, dynamic> json) =>
    NeighbourhoodProfileData(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => NeighbourhoodData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NeighbourhoodProfileDataToJson(
        NeighbourhoodProfileData instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };

NeighbourhoodData _$NeighbourhoodDataFromJson(Map<String, dynamic> json) =>
    NeighbourhoodData(
      id: json['id'] as int?,
      neighborhood: json['neighborhood'] as String?,
      code: json['code'] as String?,
      city_id: json['city_id'] as int?,
      city: json['city'] as String?,
    );

Map<String, dynamic> _$NeighbourhoodDataToJson(NeighbourhoodData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'neighborhood': instance.neighborhood,
      'code': instance.code,
      'city_id': instance.city_id,
      'city': instance.city,
    };
