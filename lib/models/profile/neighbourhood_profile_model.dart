import 'package:json_annotation/json_annotation.dart';

part 'neighbourhood_profile_model.g.dart';



@JsonSerializable(explicitToJson: true)
class NeighbourhoodProfileModel {
  NeighbourhoodProfileData? data;
  int? code;
  int? message;
  NeighbourhoodProfileModel({
    this.data,
    this.code,
    this.message
  });

  factory NeighbourhoodProfileModel.fromJson(Map<String, dynamic> json) => _$NeighbourhoodProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$NeighbourhoodProfileModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NeighbourhoodProfileData {
  List<NeighbourhoodData>? data;

  NeighbourhoodProfileData({
    this.data,
  });

  factory NeighbourhoodProfileData.fromJson(Map<String, dynamic> json) => _$NeighbourhoodProfileDataFromJson(json);
  Map<String, dynamic> toJson() => _$NeighbourhoodProfileDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NeighbourhoodData {
  int? id;
  String? neighborhood;
  String? code;
  int? city_id;
  String? city;

  NeighbourhoodData({
    this.id,
    this.neighborhood,
    this.code,
    this.city_id,
    this.city,

  });

  factory NeighbourhoodData.fromJson(Map<String, dynamic> json) => _$NeighbourhoodDataFromJson(json);
  Map<String, dynamic> toJson() => _$NeighbourhoodDataToJson(this);
}