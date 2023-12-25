// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityProfileModel _$CityProfileModelFromJson(Map<String, dynamic> json) =>
    CityProfileModel(
      data: json['data'] == null
          ? null
          : CityProfileData.fromJson(json['data'] as Map<String, dynamic>),
      code: json['code'] as int?,
      message: json['message'] as int?,
    );

Map<String, dynamic> _$CityProfileModelToJson(CityProfileModel instance) =>
    <String, dynamic>{
      'data': instance.data?.toJson(),
      'code': instance.code,
      'message': instance.message,
    };

CityProfileData _$CityProfileDataFromJson(Map<String, dynamic> json) =>
    CityProfileData(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CityData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CityProfileDataToJson(CityProfileData instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };

CityData _$CityDataFromJson(Map<String, dynamic> json) => CityData(
      id: json['id'] as int?,
      city: json['city'] as String?,
      state_id: json['state_id'] as int?,
    );

Map<String, dynamic> _$CityDataToJson(CityData instance) => <String, dynamic>{
      'id': instance.id,
      'city': instance.city,
      'state_id': instance.state_id,
    };
