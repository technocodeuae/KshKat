import 'package:json_annotation/json_annotation.dart';

part 'sign_in_dashboard_response.g.dart';


@JsonSerializable()
class SignInDashboardResultResponse {
  final UserSignInDashboardResult? data;

  SignInDashboardResultResponse({this.data});

  factory SignInDashboardResultResponse.fromJson(Map<String, dynamic> json) =>
      _$SignInDashboardResultResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignInDashboardResultResponseToJson(this);
}
@JsonSerializable()
class UserSignInDashboardResult {
  final String? username;

  final String? email;
  final String? avatar_path;
  final bool? admin;
  final bool? has_pharmacy;
  final bool? has_permission_pharmacy;
  final int? id;

  UserSignInDashboardResult({this.admin,
    this.avatar_path,
    this.username,
    this.email,
    this.id,
    this.has_permission_pharmacy,
    this.has_pharmacy});

  factory UserSignInDashboardResult.fromJson(Map<String, dynamic> json) =>
      _$UserSignInDashboardResultFromJson(json);

  Map<String, dynamic> toJson() => _$UserSignInDashboardResultToJson(this);
}

