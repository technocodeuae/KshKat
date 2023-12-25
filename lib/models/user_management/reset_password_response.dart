import 'package:json_annotation/json_annotation.dart';

part 'reset_password_response.g.dart';

@JsonSerializable()
class ResetPasswordResponse {
  final bool? success;
  final String? userId;
  final String? token;


  const ResetPasswordResponse({this.success,this.userId,this.token});

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordResponseToJson(this);
}

