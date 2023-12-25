// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slider_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SliderListData _$SliderListDataFromJson(Map<String, dynamic> json) =>
    SliderListData(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SliderData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SliderListDataToJson(SliderListData instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };

SliderData _$SliderDataFromJson(Map<String, dynamic> json) => SliderData(
      id: json['id'] as int?,
      position: json['position'] as String?,
      link: json['link'] as String?,
      details_anime: json['details_anime'] as String?,
      details_color: json['details_color'] as String?,
      details_size: json['details_size'] as String?,
      details_text: json['details_text'] as String?,
      subtitle_anime: json['subtitle_anime'] as String?,
      subtitle_color: json['subtitle_color'] as String?,
      subtitle_size: json['subtitle_size'] as String?,
      subtitle_text: json['subtitle_text'] as String?,
      title_anime: json['title_anime'] as String?,
      title_color: json['title_color'] as String?,
      title_size: json['title_size'] as String?,
      title_text: json['title_text'] as String?,
      photo: json['photo'] as String?,
    );

Map<String, dynamic> _$SliderDataToJson(SliderData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subtitle_text': instance.subtitle_text,
      'subtitle_size': instance.subtitle_size,
      'subtitle_color': instance.subtitle_color,
      'subtitle_anime': instance.subtitle_anime,
      'title_text': instance.title_text,
      'title_size': instance.title_size,
      'title_color': instance.title_color,
      'title_anime': instance.title_anime,
      'details_text': instance.details_text,
      'details_size': instance.details_size,
      'details_color': instance.details_color,
      'details_anime': instance.details_anime,
      'photo': instance.photo,
      'position': instance.position,
      'link': instance.link,
    };
