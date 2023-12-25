// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_complete_account_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpCompleteAccountResponse _$SignUpCompleteAccountResponseFromJson(
        Map<String, dynamic> json) =>
    SignUpCompleteAccountResponse(
      user: json['user'] == null
          ? null
          : UserCompleteAccount.fromJson(json['user'] as Map<String, dynamic>),
      userToken: json['userToken'] as String?,
    );

Map<String, dynamic> _$SignUpCompleteAccountResponseToJson(
        SignUpCompleteAccountResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
      'userToken': instance.userToken,
    };

UserCompleteAccount _$UserCompleteAccountFromJson(Map<String, dynamic> json) =>
    UserCompleteAccount(
      userId: json['userId'] as String?,
      fullName: json['fullName'] as String?,
      title: json['title'] as String?,
      email: json['email'] as String?,
      company: json['company'] as String?,
    );

Map<String, dynamic> _$UserCompleteAccountToJson(
        UserCompleteAccount instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'fullName': instance.fullName,
      'title': instance.title,
      'email': instance.email,
      'company': instance.company,
    };
