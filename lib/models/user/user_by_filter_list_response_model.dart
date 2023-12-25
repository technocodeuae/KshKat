import 'package:json_annotation/json_annotation.dart';
import 'package:erp/models/user/user_type_model.dart';

part 'user_by_filter_list_response_model.g.dart';

@JsonSerializable()
class UserByFilterListResponseModel {
  final List<UsersByFilterModel>? users;
  final int? pageCount;
  final int? totalUsers;

  const UserByFilterListResponseModel(
      {this.users, this.pageCount, this.totalUsers});


factory UserByFilterListResponseModel.fromJson(Map<String, dynamic> json) =>
    _$UserByFilterListResponseModelFromJson(json);

Map<String, dynamic> toJson() => _$UserByFilterListResponseModelToJson(this);

}

@JsonSerializable()
class UsersByFilterModel {
  final String? userId;
  final String? userName;
  final String? fullName;
  final String? firstName;
  final String? lastName;
  final UserTypeModel? userType;
  final String? position;
  final List<String>? roles;
  final String? department;
  final String? imageUrl;

  const UsersByFilterModel(
      {this.userId,
      this.roles,
      this.userName,
      this.position,
      this.department,
      this.lastName,
      this.firstName,
      this.fullName,
      this.userType,
      this.imageUrl});

factory UsersByFilterModel.fromJson(Map<String, dynamic> json) =>
    _$UsersByFilterModelFromJson(json);

Map<String, dynamic> toJson() => _$UsersByFilterModelToJson(this);
}
