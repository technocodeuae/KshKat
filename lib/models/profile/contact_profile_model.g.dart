// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactProfileModel _$ContactProfileModelFromJson(Map<String, dynamic> json) =>
    ContactProfileModel(
      data: json['data'] == null
          ? null
          : ContactProfileData.fromJson(json['data'] as Map<String, dynamic>),
      code: json['code'] as int?,
      message: json['message'] as int?,
    );

Map<String, dynamic> _$ContactProfileModelToJson(
        ContactProfileModel instance) =>
    <String, dynamic>{
      'data': instance.data?.toJson(),
      'code': instance.code,
      'message': instance.message,
    };

ContactProfileData _$ContactProfileDataFromJson(Map<String, dynamic> json) =>
    ContactProfileData(
      info: json['info'] == null
          ? null
          : InfoData.fromJson(json['info'] as Map<String, dynamic>),
      countries: (json['countries'] as List<dynamic>?)
          ?.map((e) => CountriesData.fromJson(e as Map<String, dynamic>))
          .toList(),
      states: (json['states'] as List<dynamic>?)
          ?.map((e) => StatesData.fromJson(e as Map<String, dynamic>))
          .toList(),
      cities: (json['cities'] as List<dynamic>?)
          ?.map((e) => CitiesData.fromJson(e as Map<String, dynamic>))
          .toList(),
      neighborhoods: (json['neighborhoods'] as List<dynamic>?)
          ?.map((e) => NeighborhoodsData.fromJson(e as Map<String, dynamic>))
          .toList(),
      socialNetworks: (json['socialNetworks'] as List<dynamic>?)
          ?.map((e) => SocialnetworksData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContactProfileDataToJson(ContactProfileData instance) =>
    <String, dynamic>{
      'info': instance.info?.toJson(),
      'countries': instance.countries?.map((e) => e.toJson()).toList(),
      'states': instance.states?.map((e) => e.toJson()).toList(),
      'cities': instance.cities?.map((e) => e.toJson()).toList(),
      'neighborhoods': instance.neighborhoods?.map((e) => e.toJson()).toList(),
      'socialNetworks':
          instance.socialNetworks?.map((e) => e.toJson()).toList(),
    };

SocialnetworksData _$SocialnetworksDataFromJson(Map<String, dynamic> json) =>
    SocialnetworksData(
      id: json['id'] as int?,
      social_network: json['social_network'] as String?,
      icon: json['icon'] as String?,
      image: json['image'],
      account: json['account'] as String?,
    );

Map<String, dynamic> _$SocialnetworksDataToJson(SocialnetworksData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'social_network': instance.social_network,
      'icon': instance.icon,
      'image': instance.image,
      'account': instance.account,
    };

NeighborhoodsData _$NeighborhoodsDataFromJson(Map<String, dynamic> json) =>
    NeighborhoodsData(
      id: json['id'] as int?,
      neighborhood: json['neighborhood'] as String?,
      code: json['code'] as String?,
      city_id: json['city_id'] as int?,
      city: json['city'] as String?,
    );

Map<String, dynamic> _$NeighborhoodsDataToJson(NeighborhoodsData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'neighborhood': instance.neighborhood,
      'code': instance.code,
      'city_id': instance.city_id,
      'city': instance.city,
    };

CitiesData _$CitiesDataFromJson(Map<String, dynamic> json) => CitiesData(
      id: json['id'] as int?,
      city: json['city'] as String?,
      state_id: json['state_id'] as int?,
    );

Map<String, dynamic> _$CitiesDataToJson(CitiesData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'city': instance.city,
      'state_id': instance.state_id,
    };

StatesData _$StatesDataFromJson(Map<String, dynamic> json) => StatesData(
      id: json['id'] as int?,
      state: json['state'] as String?,
      state_code: json['state_code'] as String?,
      state_order: json['state_order'] as int?,
      phone_prefix: json['phone_prefix'] as int?,
      country_id: json['country_id'] as int?,
      country: json['country'] as String?,
    );

Map<String, dynamic> _$StatesDataToJson(StatesData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'state': instance.state,
      'state_code': instance.state_code,
      'state_order': instance.state_order,
      'phone_prefix': instance.phone_prefix,
      'country_id': instance.country_id,
      'country': instance.country,
    };

CountriesData _$CountriesDataFromJson(Map<String, dynamic> json) =>
    CountriesData(
      id: json['id'] as int?,
      country: json['country'] as String?,
      country_code_2: json['country_code_2'] as String?,
      country_code_3: json['country_code_3'] as String?,
      numeric_code: json['numeric_code'] as int?,
      continent: json['continent'],
      currency: json['currency'],
      country_order: json['country_order'] as int?,
      capital: json['capital'],
      area: json['area'] as int?,
      population: json['population'] as int?,
      pop_sqm: json['pop_sqm'] as int?,
      phone_code: json['phone_code'] as int?,
      mobile_length: json['mobile_length'] as int?,
    );

Map<String, dynamic> _$CountriesDataToJson(CountriesData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'country': instance.country,
      'country_code_2': instance.country_code_2,
      'country_code_3': instance.country_code_3,
      'numeric_code': instance.numeric_code,
      'continent': instance.continent,
      'currency': instance.currency,
      'country_order': instance.country_order,
      'capital': instance.capital,
      'area': instance.area,
      'population': instance.population,
      'pop_sqm': instance.pop_sqm,
      'phone_code': instance.phone_code,
      'mobile_length': instance.mobile_length,
    };

InfoData _$InfoDataFromJson(Map<String, dynamic> json) => InfoData(
      id: json['id'] as int?,
      geolocation: json['geolocation'] as String?,
      country_id: json['country_id'] as int?,
      country: json['country'] as String?,
      state_id: json['state_id'] as int?,
      state: json['state'] as String?,
      city_id: json['city_id'] as int?,
      city: json['city'] as String?,
      neighborhood_id: json['neighborhood_id'],
      neighborhood: json['neighborhood'] as String?,
      building_num: json['building_num'] as String?,
      street: json['street'] as String?,
      address_1: json['address_1'] as String?,
      address_2: json['address_2'] as String?,
      phone: json['phone'] as String?,
      fax: json['fax'] as String?,
      website: json['website'],
      mobile: json['mobile'] as String?,
      email: json['email'] as String?,
      socialNetworks: (json['socialNetworks'] as List<dynamic>?)
          ?.map((e) => SocialnetworksData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InfoDataToJson(InfoData instance) => <String, dynamic>{
      'id': instance.id,
      'geolocation': instance.geolocation,
      'country_id': instance.country_id,
      'country': instance.country,
      'state_id': instance.state_id,
      'state': instance.state,
      'city_id': instance.city_id,
      'city': instance.city,
      'neighborhood_id': instance.neighborhood_id,
      'neighborhood': instance.neighborhood,
      'building_num': instance.building_num,
      'street': instance.street,
      'address_1': instance.address_1,
      'address_2': instance.address_2,
      'phone': instance.phone,
      'fax': instance.fax,
      'website': instance.website,
      'mobile': instance.mobile,
      'email': instance.email,
      'socialNetworks':
          instance.socialNetworks?.map((e) => e.toJson()).toList(),
    };
