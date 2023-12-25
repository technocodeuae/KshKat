// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPasswordResponse _$ResetPasswordResponseFromJson(
        Map<String, dynamic> json) =>
    ResetPasswordResponse(
      success: json['success'] as bool?,
      userId: json['userId'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$ResetPasswordResponseToJson(
        ResetPasswordResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'userId': instance.userId,
      'token': instance.token,
    };
