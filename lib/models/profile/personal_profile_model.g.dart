// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalProfileModel _$PersonalProfileModelFromJson(
        Map<String, dynamic> json) =>
    PersonalProfileModel(
      data: json['data'] == null
          ? null
          : PersonalProfileData.fromJson(json['data'] as Map<String, dynamic>),
      code: json['code'] as int?,
      message: json['message'] as int?,
    );

Map<String, dynamic> _$PersonalProfileModelToJson(
        PersonalProfileModel instance) =>
    <String, dynamic>{
      'data': instance.data?.toJson(),
      'code': instance.code,
      'message': instance.message,
    };

PersonalProfileData _$PersonalProfileDataFromJson(Map<String, dynamic> json) =>
    PersonalProfileData(
      info: json['info'] == null
          ? null
          : InfoData.fromJson(json['info'] as Map<String, dynamic>),
      titles: (json['titles'] as List<dynamic>?)
          ?.map((e) => TitlesData.fromJson(e as Map<String, dynamic>))
          .toList(),
      genders: (json['genders'] as List<dynamic>?)
          ?.map((e) => GendersData.fromJson(e as Map<String, dynamic>))
          .toList(),
      countries: (json['countries'] as List<dynamic>?)
          ?.map((e) => CountriesData.fromJson(e as Map<String, dynamic>))
          .toList(),
      states: json['states'] as List<dynamic>?,
      cities: json['cities'] as List<dynamic>?,
      religions: json['religions'] as List<dynamic>?,
      ideologies: json['ideologies'] as List<dynamic>?,
      bloodTypes: json['bloodTypes'] as List<dynamic>?,
      maritalStatuses: (json['maritalStatuses'] as List<dynamic>?)
          ?.map((e) => MaritalstatusesData.fromJson(e as Map<String, dynamic>))
          .toList(),
      educationLevels: json['educationLevels'] as List<dynamic>?,
    );

Map<String, dynamic> _$PersonalProfileDataToJson(
        PersonalProfileData instance) =>
    <String, dynamic>{
      'info': instance.info?.toJson(),
      'titles': instance.titles?.map((e) => e.toJson()).toList(),
      'genders': instance.genders?.map((e) => e.toJson()).toList(),
      'countries': instance.countries?.map((e) => e.toJson()).toList(),
      'states': instance.states,
      'cities': instance.cities,
      'religions': instance.religions,
      'ideologies': instance.ideologies,
      'bloodTypes': instance.bloodTypes,
      'maritalStatuses':
          instance.maritalStatuses?.map((e) => e.toJson()).toList(),
      'educationLevels': instance.educationLevels,
    };

MaritalstatusesData _$MaritalstatusesDataFromJson(Map<String, dynamic> json) =>
    MaritalstatusesData(
      id: json['id'] as int?,
      marital_status: json['marital_status'] as String?,
      show_child_num: json['show_child_num'] as bool?,
      code: json['code'],
    );

Map<String, dynamic> _$MaritalstatusesDataToJson(
        MaritalstatusesData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'marital_status': instance.marital_status,
      'show_child_num': instance.show_child_num,
      'code': instance.code,
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

GendersData _$GendersDataFromJson(Map<String, dynamic> json) => GendersData(
      id: json['id'] as int?,
      gender: json['gender'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$GendersDataToJson(GendersData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gender': instance.gender,
      'code': instance.code,
    };

TitlesData _$TitlesDataFromJson(Map<String, dynamic> json) => TitlesData(
      id: json['id'] as int?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$TitlesDataToJson(TitlesData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };

InfoData _$InfoDataFromJson(Map<String, dynamic> json) => InfoData(
      first_name: json['first_name'] as String?,
      last_name: json['last_name'],
      national_id: json['national_id'],
      middle_name: json['middle_name'],
      father_name: json['father_name'],
      mother_name: json['mother_name'],
      birth_date: json['birth_date'],
      birth_date_timestamp: json['birth_date_timestamp'] as int?,
      id_card_num: json['id_card_num'],
      civic_record_area: json['civic_record_area'],
      civic_record_location: json['civic_record_location'],
      civic_record_number: json['civic_record_number'],
      num_of_children: json['num_of_children'],
      avatar_id: json['avatar_id'],
      avatar_path: json['avatar_path'] as String?,
      title_id: json['title_id'],
      title: json['title'],
      city_id: json['city_id'],
      city: json['city'],
      state_id: json['state_id'],
      state: json['state'],
      country_id: json['country_id'],
      country: json['country'],
      gender_id: json['gender_id'],
      gender: json['gender'],
      ideology_id: json['ideology_id'],
      ideology: json['ideology'],
      religion_id: json['religion_id'],
      religion: json['religion'],
      blood_type_id: json['blood_type_id'],
      blood_type: json['blood_type'],
      marital_status_id: json['marital_status_id'],
      marital_status: json['marital_status'],
      education_level_id: json['education_level_id'],
      education_level: json['education_level'],
    );

Map<String, dynamic> _$InfoDataToJson(InfoData instance) => <String, dynamic>{
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'national_id': instance.national_id,
      'middle_name': instance.middle_name,
      'father_name': instance.father_name,
      'mother_name': instance.mother_name,
      'birth_date': instance.birth_date,
      'birth_date_timestamp': instance.birth_date_timestamp,
      'id_card_num': instance.id_card_num,
      'civic_record_area': instance.civic_record_area,
      'civic_record_location': instance.civic_record_location,
      'civic_record_number': instance.civic_record_number,
      'num_of_children': instance.num_of_children,
      'avatar_id': instance.avatar_id,
      'avatar_path': instance.avatar_path,
      'title_id': instance.title_id,
      'title': instance.title,
      'city_id': instance.city_id,
      'city': instance.city,
      'state_id': instance.state_id,
      'state': instance.state,
      'country_id': instance.country_id,
      'country': instance.country,
      'gender_id': instance.gender_id,
      'gender': instance.gender,
      'ideology_id': instance.ideology_id,
      'ideology': instance.ideology,
      'religion_id': instance.religion_id,
      'religion': instance.religion,
      'blood_type_id': instance.blood_type_id,
      'blood_type': instance.blood_type,
      'marital_status_id': instance.marital_status_id,
      'marital_status': instance.marital_status,
      'education_level_id': instance.education_level_id,
      'education_level': instance.education_level,
    };
