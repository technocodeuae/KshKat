import 'package:json_annotation/json_annotation.dart';

part 'map_model.g.dart';



@JsonSerializable(explicitToJson: true)
class MapModel {
  MapData? data;
  int? code;
  int? message;
  MapModel({
    this.data,
    this.code,
    this.message
  });

  factory MapModel.fromJson(Map<String, dynamic> json) => _$MapModelFromJson(json);
  Map<String, dynamic> toJson() => _$MapModelToJson(this);
}
@JsonSerializable(explicitToJson: true)
class MapData {
  List<Data>? data;

  MapData({
    this.data,
  });

  factory MapData.fromJson(Map<String, dynamic> json) => _$MapDataFromJson(json);
  Map<String, dynamic> toJson() => _$MapDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Data {
  int id;

  Data({
    required this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}
