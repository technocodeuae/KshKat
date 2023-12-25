// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_dashboard_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInDashboardResultResponse _$SignInDashboardResultResponseFromJson(
        Map<String, dynamic> json) =>
    SignInDashboardResultResponse(
      data: json['data'] == null
          ? null
          : UserSignInDashboardResult.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignInDashboardResultResponseToJson(
        SignInDashboardResultResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

UserSignInDashboardResult _$UserSignInDashboardResultFromJson(
        Map<String, dynamic> json) =>
    UserSignInDashboardResult(
      admin: json['admin'] as bool?,
      avatar_path: json['avatar_path'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      id: json['id'] as int?,
      has_permission_pharmacy: json['has_permission_pharmacy'] as bool?,
      has_pharmacy: json['has_pharmacy'] as bool?,
    );

Map<String, dynamic> _$UserSignInDashboardResultToJson(
        UserSignInDashboardResult instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'avatar_path': instance.avatar_path,
      'admin': instance.admin,
      'has_pharmacy': instance.has_pharmacy,
      'has_permission_pharmacy': instance.has_permission_pharmacy,
      'id': instance.id,
    };
