// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInResultResponse _$SignInResultResponseFromJson(
        Map<String, dynamic> json) =>
    SignInResultResponse(
      success: json['success'] as bool?,
      token: json['token'] as String?,
      info: json['info'] == null
          ? null
          : InfoData.fromJson(json['info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignInResultResponseToJson(
        SignInResultResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'token': instance.token,
      'info': instance.info?.toJson(),
    };

InfoData _$InfoDataFromJson(Map<String, dynamic> json) => InfoData(
      id: json['id'] as int,
      name: json['name'] as String,
      photo: json['photo'] as String?,
      phone: json['phone'] as String,
      email: json['email'] as String,
      status: json['status'],
      verification_link: json['verification_link'] as String?,
      email_verified: json['email_verified'] as String?,
      currency_id: json['currency_id'],
    );

Map<String, dynamic> _$InfoDataToJson(InfoData instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'photo': instance.photo,
      'phone': instance.phone,
      'email': instance.email,
      'status': instance.status,
      'verification_link': instance.verification_link,
      'email_verified': instance.email_verified,
      'currency_id': instance.currency_id,
    };

MsgData _$MsgDataFromJson(Map<String, dynamic> json) => MsgData(
      email:
          (json['email'] as List<dynamic>?)?.map((e) => e as String).toList(),
      phone:
          (json['phone'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$MsgDataToJson(MsgData instance) => <String, dynamic>{
      'email': instance.email,
      'phone': instance.phone,
    };
