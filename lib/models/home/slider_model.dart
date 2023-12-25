import 'package:json_annotation/json_annotation.dart';
part 'slider_model.g.dart';


@JsonSerializable(explicitToJson: true)
class SliderListData{
  List<SliderData>? data;

  SliderListData({
    this.data,


  });

  factory SliderListData.fromJson(Map<String, dynamic> json) => _$SliderListDataFromJson(json);
  Map<String, dynamic> toJson() => _$SliderListDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class SliderData{
  int? id;
  String? subtitle_text;
  String? subtitle_size;
  String? subtitle_color;
  String? subtitle_anime;
  String? title_text;
  String? title_size;
  String? title_color;
  String? title_anime;
  String? details_text;
  String? details_size;
  String? details_color;
  String? details_anime;
  String? photo;
  String? position;
  String? link;

  SliderData({
    this.id,
    this.position,
    this.link,
    this.details_anime,
    this.details_color,
    this.details_size,
    this.details_text,
    this.subtitle_anime,
    this.subtitle_color,
    this.subtitle_size,
    this.subtitle_text,
    this.title_anime,
    this.title_color,
    this.title_size,
    this.title_text,
    this.photo,

  });

  factory SliderData.fromJson(Map<String, dynamic> json) => _$SliderDataFromJson(json);
  Map<String, dynamic> toJson() => _$SliderDataToJson(this);

}