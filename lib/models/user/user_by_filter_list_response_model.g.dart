// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_by_filter_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserByFilterListResponseModel _$UserByFilterListResponseModelFromJson(
        Map<String, dynamic> json) =>
    UserByFilterListResponseModel(
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => UsersByFilterModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageCount: json['pageCount'] as int?,
      totalUsers: json['totalUsers'] as int?,
    );

Map<String, dynamic> _$UserByFilterListResponseModelToJson(
        UserByFilterListResponseModel instance) =>
    <String, dynamic>{
      'users': instance.users,
      'pageCount': instance.pageCount,
      'totalUsers': instance.totalUsers,
    };

UsersByFilterModel _$UsersByFilterModelFromJson(Map<String, dynamic> json) =>
    UsersByFilterModel(
      userId: json['userId'] as String?,
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
      userName: json['userName'] as String?,
      position: json['position'] as String?,
      department: json['department'] as String?,
      lastName: json['lastName'] as String?,
      firstName: json['firstName'] as String?,
      fullName: json['fullName'] as String?,
      userType: json['userType'] == null
          ? null
          : UserTypeModel.fromJson(json['userType'] as Map<String, dynamic>),
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$UsersByFilterModelToJson(UsersByFilterModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'fullName': instance.fullName,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'userType': instance.userType,
      'position': instance.position,
      'roles': instance.roles,
      'department': instance.department,
      'imageUrl': instance.imageUrl,
    };
