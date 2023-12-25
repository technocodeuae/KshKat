import 'package:json_annotation/json_annotation.dart';

part 'user_type_model.g.dart';

@JsonSerializable()
class UserTypeModel {
  final int? userTypeValue;
  final String? userTypeName;

  const UserTypeModel(
      {this.userTypeName, this.userTypeValue});


factory UserTypeModel.fromJson(Map<String, dynamic> json) =>
    _$UserTypeModelFromJson(json);

Map<String, dynamic> toJson() => _$UserTypeModelToJson(this);

}
