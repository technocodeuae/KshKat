import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AddressModel {
  List<Data>? data;
  int? status;
  String? msg;
  AddressModel({
    this.data,
    this.status,
    this.msg
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => _$AddressModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Data {
  int id;
  var kind;
  String? name;
  String? phone;
  String? latitude;
  String? longitude;
  String? country;
  String? city;
  String? street;
  var postal_code;
  String? note;
  var user_id;
  String? created_at;
  String? updated_at;
  String? floor;
  String? building;
  bool? isValidAddress;
  int? timestamp;
  int? timestamp_update;

  Data({
    required this.id,
    this.kind,
    this.name,
    this.phone,
    this.latitude,
    this.longitude,
    this.country,
    this.city,
    this.street,
    this.postal_code,
    this.note,
    this.user_id,
    this.created_at,
    this.updated_at,
    this.floor,
    this.building,
    this.isValidAddress,
    this.timestamp,
    this.timestamp_update,

  });


  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}