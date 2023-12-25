import 'package:json_annotation/json_annotation.dart';

part 'user_by_name_list_response_model.g.dart';

@JsonSerializable()
class UserByNameListResponseModel {
  final List<UsersByNameModel>? users;

  const UserByNameListResponseModel({this.users});


  factory UserByNameListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserByNameListResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserByNameListResponseModelToJson(this);

}
@JsonSerializable()
class UsersByNameModel {
  final String? userId;
  final String? fullName;
  final String? firstName;
  final String? lastName;
  final String? userName;
  final String? email;
  final String? phoneNumber;
  final String? position;
  final String? organization;
  final String? delegatedReporter;
  final List<String>? userRoles;
  final String? department;
  final String? imageUrl;
  final bool? active;

  const UsersByNameModel({this.userId,
    this.fullName,
    this.firstName,
    this.lastName,
    this.userName,
    this.email,
    this.phoneNumber,
    this.position,
    this.organization,
    this.delegatedReporter,
    this.userRoles,
    this.department,
    this.imageUrl,
    this.active});

  factory UsersByNameModel.fromJson(Map<String, dynamic> json) =>
      _$UsersByNameModelFromJson(json);

  Map<String, dynamic> toJson() => _$UsersByNameModelToJson(this);
}
