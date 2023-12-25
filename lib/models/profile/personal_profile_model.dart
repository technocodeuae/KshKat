import 'package:json_annotation/json_annotation.dart';

part 'personal_profile_model.g.dart';



@JsonSerializable(explicitToJson: true)
class PersonalProfileModel {
  PersonalProfileData? data;
  int? code;
  int? message;
  PersonalProfileModel({
    this.data,
    this.code,
    this.message
  });

  factory PersonalProfileModel.fromJson(Map<String, dynamic> json) => _$PersonalProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$PersonalProfileModelToJson(this);
}
@JsonSerializable(explicitToJson: true)
class PersonalProfileData {
  InfoData? info;
  List<TitlesData>? titles;
  List<GendersData>? genders;
  List<CountriesData>? countries;
  List<dynamic>? states;
  List<dynamic>? cities;
  List<dynamic>? religions;
  List<dynamic>? ideologies;
  List<dynamic>? bloodTypes;
  List<MaritalstatusesData>? maritalStatuses;
  List<dynamic>? educationLevels;

  PersonalProfileData({
    this.info,
    this.titles,
    this.genders,
    this.countries,
    this.states,
    this.cities,
    this.religions,
    this.ideologies,
    this.bloodTypes,
    this.maritalStatuses,
    this.educationLevels,

  });

  factory PersonalProfileData.fromJson(Map<String, dynamic> json) => _$PersonalProfileDataFromJson(json);
  Map<String, dynamic> toJson() => _$PersonalProfileDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MaritalstatusesData{
  int? id;
  String? marital_status;
  bool? show_child_num;
  var code;

  MaritalstatusesData({
    this.id,
    this.marital_status,
    this.show_child_num,
    this.code,
  });

  factory MaritalstatusesData.fromJson(Map<String, dynamic> json) => _$MaritalstatusesDataFromJson(json);
  Map<String, dynamic> toJson() => _$MaritalstatusesDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class CountriesData{
  int? id;
  String? country;
  String? country_code_2;
  String? country_code_3;
  int? numeric_code;
  var continent;
  var currency;
  int? country_order;
  var capital;
  int? area;
  int? population;
  int? pop_sqm;
  int? phone_code;
  int? mobile_length;

  CountriesData({
    this.id,
    this.country,
    this.country_code_2,
    this.country_code_3,
    this.numeric_code,
    this.continent,
    this.currency,
    this.country_order,
    this.capital,
    this.area,
    this.population,
    this.pop_sqm,
    this.phone_code,
    this.mobile_length,
  });

  factory CountriesData.fromJson(Map<String, dynamic> json) => _$CountriesDataFromJson(json);
  Map<String, dynamic> toJson() => _$CountriesDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class GendersData{
  int? id;
  String? gender;
  String? code;

  GendersData({
    this.id,
    this.gender,
    this.code,
  });

  factory GendersData.fromJson(Map<String, dynamic> json) => _$GendersDataFromJson(json);
  Map<String, dynamic> toJson() => _$GendersDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class TitlesData{
  int? id;
  String? title;

  TitlesData({
    this.id,
    this.title,
  });

  factory TitlesData.fromJson(Map<String, dynamic> json) => _$TitlesDataFromJson(json);
   Map<String, dynamic> toJson() => _$TitlesDataToJson(this);


}

@JsonSerializable(explicitToJson: true)
class InfoData{
  String? first_name;
  var last_name;
  var national_id;
  var middle_name;
  var father_name;
  var mother_name;
  var birth_date;
  int? birth_date_timestamp;
  var id_card_num;
  var civic_record_area;
  var civic_record_location;
  var civic_record_number;
  var num_of_children;
  var avatar_id;
  String? avatar_path;
  var title_id;
  var title;
  var city_id;
  var city;
  var state_id;
  var state;
  var country_id;
  var country;
  var gender_id;
  var gender;
  var ideology_id;
  var ideology;
  var religion_id;
  var religion;
  var blood_type_id;
  var blood_type;
  var marital_status_id;
  var marital_status;
  var education_level_id;
  var education_level;

  InfoData({
    this.first_name,
    this.last_name,
    this.national_id,
    this.middle_name,
    this.father_name,
    this.mother_name,
    this.birth_date,
    this.birth_date_timestamp,
    this.id_card_num,
    this.civic_record_area,
    this.civic_record_location,
    this.civic_record_number,
    this.num_of_children,
    this.avatar_id,
    this.avatar_path,
    this.title_id,
    this.title,
    this.city_id,
    this.city,
    this.state_id,
    this.state,
    this.country_id,
    this.country,
    this.gender_id,
    this.gender,
    this.ideology_id,
    this.ideology,
    this.religion_id,
    this.religion,
    this.blood_type_id,
    this.blood_type,
    this.marital_status_id,
    this.marital_status,
    this.education_level_id,
    this.education_level,
  });

  factory InfoData.fromJson(Map<String, dynamic> json) => _$InfoDataFromJson(json);
  Map<String, dynamic> toJson() => _$InfoDataToJson(this);

}




