import 'package:json_annotation/json_annotation.dart';

part 'sign_up_confirmation_account_response.g.dart';

@JsonSerializable()
class SignUpConfirmationAccountResponse {
  final String? status;
  final bool isApproved;


  const SignUpConfirmationAccountResponse({ this.status,required this.isApproved});

  factory SignUpConfirmationAccountResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpConfirmationAccountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpConfirmationAccountResponseToJson(this);
}

