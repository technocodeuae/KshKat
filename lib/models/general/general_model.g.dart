// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneralModel _$GeneralModelFromJson(Map<String, dynamic> json) => GeneralModel(
      success: json['success'] as bool?,
      code: json['code'] as int?,
      message: json['message'] as String?,
      errors: json['errors'] == null
          ? null
          : ErrorsData.fromJson(json['errors'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GeneralModelToJson(GeneralModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'code': instance.code,
      'message': instance.message,
      'errors': instance.errors?.toJson(),
    };

ErrorsData _$ErrorsDataFromJson(Map<String, dynamic> json) => ErrorsData(
      quantity: (json['quantity'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ErrorsDataToJson(ErrorsData instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
    };
