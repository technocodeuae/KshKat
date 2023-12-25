import 'package:json_annotation/json_annotation.dart';

part 'signup_model.g.dart';



@JsonSerializable(explicitToJson: true)
class SignupModel {
  String? token_type;
  int? expires_in;
  String? access_token;
  String? refresh_token;
  int? code;
  String? message;
  ErrorsData? errors;
  SignupModel({
    this.token_type,
    this.expires_in,
    this.access_token,
    this.refresh_token,
    this.code,
    this.message,
    this.errors
  });

  factory SignupModel.fromJson(Map<String, dynamic> json) => _$SignupModelFromJson(json);
  Map<String, dynamic> toJson() => _$SignupModelToJson(this);
}
@JsonSerializable(explicitToJson: true)
class SignupData {
  String? token_type;
  int? expires_in;
  String? access_token;
  String? refresh_token;

  SignupData({
    this.token_type,
    this.expires_in,
    this.access_token,
    this.refresh_token,

  });
  factory SignupData.fromJson(Map<String, dynamic> json) => _$SignupDataFromJson(json);
  Map<String, dynamic> toJson() => _$SignupDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ErrorsData{
  List<String>? username;
  List<String>? email;

  ErrorsData({
    this.username,
    this.email,
  });

  factory ErrorsData.fromJson(Map<String, dynamic> json) => _$ErrorsDataFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorsDataToJson(this);

}