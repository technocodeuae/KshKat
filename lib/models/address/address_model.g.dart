// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as int?,
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'status': instance.status,
      'msg': instance.msg,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: json['id'] as int,
      kind: json['kind'],
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      street: json['street'] as String?,
      postal_code: json['postal_code'],
      note: json['note'] as String?,
      user_id: json['user_id'],
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
      floor: json['floor'] as String?,
      building: json['building'] as String?,
      isValidAddress: json['isValidAddress'] as bool?,
      timestamp: json['timestamp'] as int?,
      timestamp_update: json['timestamp_update'] as int?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'kind': instance.kind,
      'name': instance.name,
      'phone': instance.phone,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'country': instance.country,
      'city': instance.city,
      'street': instance.street,
      'postal_code': instance.postal_code,
      'note': instance.note,
      'user_id': instance.user_id,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'floor': instance.floor,
      'building': instance.building,
      'isValidAddress': instance.isValidAddress,
      'timestamp': instance.timestamp,
      'timestamp_update': instance.timestamp_update,
    };
