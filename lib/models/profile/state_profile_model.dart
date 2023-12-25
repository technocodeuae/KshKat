import 'package:json_annotation/json_annotation.dart';

part 'state_profile_model.g.dart';



@JsonSerializable(explicitToJson: true)
class StateProfileModel {
  StateProfileData? data;
  int? code;
  int? message;
  StateProfileModel({
    this.data,
    this.code,
    this.message
  });

  factory StateProfileModel.fromJson(Map<String, dynamic> json) => _$StateProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$StateProfileModelToJson(this);
}
@JsonSerializable(explicitToJson: true)
class StateProfileData {
  List<StateData>? data;

  StateProfileData({
    this.data,

  });

  factory StateProfileData.fromJson(Map<String, dynamic> json) => _$StateProfileDataFromJson(json);
  Map<String, dynamic> toJson() => _$StateProfileDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class StateData {
  int? id;
  String? state;
  String? state_code;
  int? state_order;
  int? phone_prefix;
  int? country_id;
  String? country;

  StateData({
    this.id,
    this.state,
    this.state_code,
    this.state_order,
    this.phone_prefix,
    this.country_id,
    this.country,

  });

  factory StateData.fromJson(Map<String, dynamic> json) => _$StateDataFromJson(json);
  Map<String, dynamic> toJson() => _$StateDataToJson(this);
}



