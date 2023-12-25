// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupModel _$SignupModelFromJson(Map<String, dynamic> json) => SignupModel(
      token_type: json['token_type'] as String?,
      expires_in: json['expires_in'] as int?,
      access_token: json['access_token'] as String?,
      refresh_token: json['refresh_token'] as String?,
      code: json['code'] as int?,
      message: json['message'] as String?,
      errors: json['errors'] == null
          ? null
          : ErrorsData.fromJson(json['errors'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignupModelToJson(SignupModel instance) =>
    <String, dynamic>{
      'token_type': instance.token_type,
      'expires_in': instance.expires_in,
      'access_token': instance.access_token,
      'refresh_token': instance.refresh_token,
      'code': instance.code,
      'message': instance.message,
      'errors': instance.errors?.toJson(),
    };

SignupData _$SignupDataFromJson(Map<String, dynamic> json) => SignupData(
      token_type: json['token_type'] as String?,
      expires_in: json['expires_in'] as int?,
      access_token: json['access_token'] as String?,
      refresh_token: json['refresh_token'] as String?,
    );

Map<String, dynamic> _$SignupDataToJson(SignupData instance) =>
    <String, dynamic>{
      'token_type': instance.token_type,
      'expires_in': instance.expires_in,
      'access_token': instance.access_token,
      'refresh_token': instance.refresh_token,
    };

ErrorsData _$ErrorsDataFromJson(Map<String, dynamic> json) => ErrorsData(
      username: (json['username'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      email:
          (json['email'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ErrorsDataToJson(ErrorsData instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
    };
