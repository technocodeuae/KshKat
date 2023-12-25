// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_by_name_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserByNameListResponseModel _$UserByNameListResponseModelFromJson(
        Map<String, dynamic> json) =>
    UserByNameListResponseModel(
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => UsersByNameModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserByNameListResponseModelToJson(
        UserByNameListResponseModel instance) =>
    <String, dynamic>{
      'users': instance.users,
    };

UsersByNameModel _$UsersByNameModelFromJson(Map<String, dynamic> json) =>
    UsersByNameModel(
      userId: json['userId'] as String?,
      fullName: json['fullName'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      position: json['position'] as String?,
      organization: json['organization'] as String?,
      delegatedReporter: json['delegatedReporter'] as String?,
      userRoles: (json['userRoles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      department: json['department'] as String?,
      imageUrl: json['imageUrl'] as String?,
      active: json['active'] as bool?,
    );

Map<String, dynamic> _$UsersByNameModelToJson(UsersByNameModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'fullName': instance.fullName,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'userName': instance.userName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'position': instance.position,
      'organization': instance.organization,
      'delegatedReporter': instance.delegatedReporter,
      'userRoles': instance.userRoles,
      'department': instance.department,
      'imageUrl': instance.imageUrl,
      'active': instance.active,
    };
