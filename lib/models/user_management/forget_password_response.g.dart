// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forget_password_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgetPasswordResponse _$ForgetPasswordResponseFromJson(
        Map<String, dynamic> json) =>
    ForgetPasswordResponse(
      status: json['status'] as String?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$ForgetPasswordResponseToJson(
        ForgetPasswordResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'userId': instance.userId,
    };
