// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTypeModel _$UserTypeModelFromJson(Map<String, dynamic> json) =>
    UserTypeModel(
      userTypeName: json['userTypeName'] as String?,
      userTypeValue: json['userTypeValue'] as int?,
    );

Map<String, dynamic> _$UserTypeModelToJson(UserTypeModel instance) =>
    <String, dynamic>{
      'userTypeValue': instance.userTypeValue,
      'userTypeName': instance.userTypeName,
    };
