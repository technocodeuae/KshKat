import 'package:json_annotation/json_annotation.dart';

part 'forget_password_response.g.dart';

@JsonSerializable()
class ForgetPasswordResponse {
  final String? status;
  final String? userId;

  const ForgetPasswordResponse({this.status,this.userId});

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetPasswordResponseToJson(this);
}

