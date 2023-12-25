import 'package:json_annotation/json_annotation.dart';

import 'sign_in_response.dart';

part 'external_sign_in_response.g.dart';

@JsonSerializable()
class ExternalSignInResultResponse {
  final String? userToken;

  ExternalSignInResultResponse({this.userToken});

  factory ExternalSignInResultResponse.fromJson(Map<String, dynamic> json) =>
      _$ExternalSignInResultResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ExternalSignInResultResponseToJson(this);
}


