import 'package:json_annotation/json_annotation.dart';

part 'city_profile_model.g.dart';



@JsonSerializable(explicitToJson: true)
class CityProfileModel {
  CityProfileData? data;
  int? code;
  int? message;
  CityProfileModel({
    this.data,
    this.code,
    this.message
  });

  factory CityProfileModel.fromJson(Map<String, dynamic> json) => _$CityProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$CityProfileModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CityProfileData {
  List<CityData>? data;

  CityProfileData({
    this.data,
  });

  factory CityProfileData.fromJson(Map<String, dynamic> json) => _$CityProfileDataFromJson(json);
  Map<String, dynamic> toJson() => _$CityProfileDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CityData {
  int? id;
  String? city;
  int? state_id;

  CityData({
    this.id,
    this.city,
    this.state_id,

  });

  factory CityData.fromJson(Map<String, dynamic> json) => _$CityDataFromJson(json);
  Map<String, dynamic> toJson() => _$CityDataToJson(this);
}