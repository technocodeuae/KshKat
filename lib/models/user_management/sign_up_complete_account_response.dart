import 'package:json_annotation/json_annotation.dart';

part 'sign_up_complete_account_response.g.dart';

@JsonSerializable()
class SignUpCompleteAccountResponse {
  final UserCompleteAccount? user;
  final String? userToken;

  const SignUpCompleteAccountResponse({this.user, this.userToken});

  factory SignUpCompleteAccountResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpCompleteAccountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpCompleteAccountResponseToJson(this);
}

@JsonSerializable()
class UserCompleteAccount {
  final String? userId;
  final String? fullName;
  final String? title;
  final String? email;
  final String? company;

  const UserCompleteAccount(
      {this.userId, this.fullName, this.title, this.email, this.company});

  factory UserCompleteAccount.fromJson(Map<String, dynamic> json) =>
      _$UserCompleteAccountFromJson(json);

  Map<String, dynamic> toJson() => _$UserCompleteAccountToJson(this);
}
