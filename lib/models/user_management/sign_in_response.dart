import 'package:json_annotation/json_annotation.dart';

part 'sign_in_response.g.dart';


@JsonSerializable(explicitToJson: true)
class SignInResultResponse {

  bool? success;
  String? token;
  //MsgData? msg;
  InfoData? info;

  SignInResultResponse({
    this.success,
    this.token,
    this.info,
//    this.msg,
  });

  factory SignInResultResponse.fromJson(Map<String, dynamic> json) => _$SignInResultResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SignInResultResponseToJson(this);
}


@JsonSerializable(explicitToJson: true)
class InfoData{
  int id;
  String name;
  String? photo;
  String phone;
  String email;
  var status;
  String? verification_link;
  String? email_verified;
  var currency_id;

  InfoData({
    required this.id,
    required this.name,
    this.photo,
    required this.phone,
    required this.email,
    this.status,
    this.verification_link,
    this.email_verified,
    this.currency_id,
  });

  factory InfoData.fromJson(Map<String, dynamic> json) => _$InfoDataFromJson(json);
  Map<String, dynamic> toJson() => _$InfoDataToJson(this);

}


@JsonSerializable(explicitToJson: true)
class MsgData{
  List<String>? email;
  List<String>? phone;

  MsgData({
    this.email,
    this.phone,
  });

  factory MsgData.fromJson(Map<String, dynamic> json) => _$MsgDataFromJson(json);
  Map<String, dynamic> toJson() => _$MsgDataToJson(this);

}