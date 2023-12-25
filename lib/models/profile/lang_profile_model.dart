import 'package:json_annotation/json_annotation.dart';

part 'lang_profile_model.g.dart';



@JsonSerializable(explicitToJson: true)
class PharmacyProfileModel {
  PharmacyProfileData? data;
  int? code;
  int? message;
  PharmacyProfileModel({
    this.data,
    this.code,
    this.message
  });

  factory PharmacyProfileModel.fromJson(Map<String, dynamic> json) => _$PharmacyProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$PharmacyProfileModelToJson(this);
}
@JsonSerializable(explicitToJson: true)
class PharmacyProfileData {
  InfoData? info;
  List<CountriesData>? countries;
  List<StatesData>? states;
  List<CitiesData>? cities;
  List<NeighborhoodsData>? neighborhoods;
  List<SocialnetworksData>? socialNetworks;

  PharmacyProfileData({
    this.info,
    this.countries,
    this.states,
    this.cities,
    this.neighborhoods,
    this.socialNetworks,

  });

  factory PharmacyProfileData.fromJson(Map<String, dynamic> json) => _$PharmacyProfileDataFromJson(json);
  Map<String, dynamic> toJson() => _$PharmacyProfileDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SocialnetworksData{
  int? id;
  String? social_network;
  String? icon;
  String? account;
  var image;

  SocialnetworksData({
    this.id,
    this.social_network,
    this.icon,
    this.image,
    this.account,
  });

  factory SocialnetworksData.fromJson(Map<String, dynamic> json) => _$SocialnetworksDataFromJson(json);
  Map<String, dynamic> toJson() => _$SocialnetworksDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class NeighborhoodsData{
  int? id;
  String? neighborhood;
  String? code;
  int? city_id;
  String? city;

  NeighborhoodsData({
    this.id,
    this.neighborhood,
    this.code,
    this.city_id,
    this.city,
  });

  factory NeighborhoodsData.fromJson(Map<String, dynamic> json) => _$NeighborhoodsDataFromJson(json);
  Map<String, dynamic> toJson() => _$NeighborhoodsDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class CitiesData{
  int? id;
  String? city;
  int? state_id;

  CitiesData({
    this.id,
    this.city,
    this.state_id,
  });

  factory CitiesData.fromJson(Map<String, dynamic> json) => _$CitiesDataFromJson(json);
  Map<String, dynamic> toJson() => _$CitiesDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class StatesData{
  int? id;
  String? state;
  String? state_code;
  int? state_order;
  int? phone_prefix;
  int? country_id;
  String? country;

  StatesData({
    this.id,
    this.state,
    this.state_code,
    this.state_order,
    this.phone_prefix,
    this.country_id,
    this.country,
  });

  factory StatesData.fromJson(Map<String, dynamic> json) => _$StatesDataFromJson(json);
  Map<String, dynamic> toJson() => _$StatesDataToJson(this);

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
class InfoData{
  int? id;
  String? name;
  int? has_night_shifts;
  String? logo_path;
  String? geolocation;
  ArData? ar;
  EnData? en;
  DeData? de;
  int? country_id;
  String? country;
  int? state_id;
  String? state;
  int? city_id;
  String? city;
  var neighborhood_id;
  String? neighborhood;
  String? building_num;
  String? street;
  String? address_1;
  String? address_2;
  String? phone;
  String? fax;
  var website;
  String? mobile;
  String? email;
  List<SocialnetworksData>? socialNetworks;

  InfoData({
    this.id,
    this.name,
    this.has_night_shifts,
    this.logo_path,
    this.geolocation,
    this.ar,
    this.en,
    this.country_id,
    this.country,
    this.state_id,
    this.state,
    this.city_id,
    this.city,
    this.neighborhood_id,
    this.neighborhood,
    this.building_num,
    this.street,
    this.address_1,
    this.address_2,
    this.phone,
    this.fax,
    this.website,
    this.mobile,
    this.email,
    this.socialNetworks,
  });

  factory InfoData.fromJson(Map<String, dynamic> json) => _$InfoDataFromJson(json);
  Map<String, dynamic> toJson() => _$InfoDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class EnData{
  String? name;

  EnData({
    this.name,
  });

  factory EnData.fromJson(Map<String, dynamic> json) => _$EnDataFromJson(json);
  Map<String, dynamic> toJson() => _$EnDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class DeData{
  String? name;

  DeData({
    this.name,
  });

  factory DeData.fromJson(Map<String, dynamic> json) => _$DeDataFromJson(json);
  Map<String, dynamic> toJson() => _$DeDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class ArData{
  String? name;

  ArData({
    this.name,
  });

  factory ArData.fromJson(Map<String, dynamic> json) => _$ArDataFromJson(json);
  Map<String, dynamic> toJson() => _$ArDataToJson(this);

}

