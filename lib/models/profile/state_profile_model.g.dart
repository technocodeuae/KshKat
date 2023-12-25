// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StateProfileModel _$StateProfileModelFromJson(Map<String, dynamic> json) =>
    StateProfileModel(
      data: json['data'] == null
          ? null
          : StateProfileData.fromJson(json['data'] as Map<String, dynamic>),
      code: json['code'] as int?,
      message: json['message'] as int?,
    );

Map<String, dynamic> _$StateProfileModelToJson(StateProfileModel instance) =>
    <String, dynamic>{
      'data': instance.data?.toJson(),
      'code': instance.code,
      'message': instance.message,
    };

StateProfileData _$StateProfileDataFromJson(Map<String, dynamic> json) =>
    StateProfileData(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => StateData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StateProfileDataToJson(StateProfileData instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };

StateData _$StateDataFromJson(Map<String, dynamic> json) => StateData(
      id: json['id'] as int?,
      state: json['state'] as String?,
      state_code: json['state_code'] as String?,
      state_order: json['state_order'] as int?,
      phone_prefix: json['phone_prefix'] as int?,
      country_id: json['country_id'] as int?,
      country: json['country'] as String?,
    );

Map<String, dynamic> _$StateDataToJson(StateData instance) => <String, dynamic>{
      'id': instance.id,
      'state': instance.state,
      'state_code': instance.state_code,
      'state_order': instance.state_order,
      'phone_prefix': instance.phone_prefix,
      'country_id': instance.country_id,
      'country': instance.country,
    };
