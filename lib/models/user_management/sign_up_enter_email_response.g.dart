// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_enter_email_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpEnterEmailResponse _$SignUpEnterEmailResponseFromJson(
        Map<String, dynamic> json) =>
    SignUpEnterEmailResponse(
      user: json['user'] == null
          ? null
          : UserEnterEmail.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignUpEnterEmailResponseToJson(
        SignUpEnterEmailResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
    };

UserEnterEmail _$UserEnterEmailFromJson(Map<String, dynamic> json) =>
    UserEnterEmail(
      userId: json['userId'] as String?,
      userEmail: json['userEmail'] as String?,
    );

Map<String, dynamic> _$UserEnterEmailToJson(UserEnterEmail instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userEmail': instance.userEmail,
    };
