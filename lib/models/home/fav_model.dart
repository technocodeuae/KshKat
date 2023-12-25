import 'package:json_annotation/json_annotation.dart';

part 'fav_model.g.dart';



@JsonSerializable(explicitToJson: true)
class FavModel {
  String? success;
  FavModel({
    this.success
  });

  factory FavModel.fromJson(Map<String, dynamic> json) => _$FavModelFromJson(json);
  Map<String, dynamic> toJson() => _$FavModelToJson(this);
}


