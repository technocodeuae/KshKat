import 'package:json_annotation/json_annotation.dart';

part 'sign_up_enter_email_response.g.dart';

@JsonSerializable()
class SignUpEnterEmailResponse {
  final UserEnterEmail? user;

  const SignUpEnterEmailResponse({this.user});

  factory SignUpEnterEmailResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpEnterEmailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpEnterEmailResponseToJson(this);
}
@JsonSerializable()
class UserEnterEmail {
  final String? userId;
  final String? userEmail;

  const  UserEnterEmail({this.userId, this.userEmail});
  factory UserEnterEmail.fromJson(Map<String, dynamic> json) =>
      _$UserEnterEmailFromJson(json);

  Map<String, dynamic> toJson() => _$UserEnterEmailToJson(this);

}
