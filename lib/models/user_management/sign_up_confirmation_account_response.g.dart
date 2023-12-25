// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_confirmation_account_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpConfirmationAccountResponse _$SignUpConfirmationAccountResponseFromJson(
        Map<String, dynamic> json) =>
    SignUpConfirmationAccountResponse(
      status: json['status'] as String?,
      isApproved: json['isApproved'] as bool,
    );

Map<String, dynamic> _$SignUpConfirmationAccountResponseToJson(
        SignUpConfirmationAccountResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'isApproved': instance.isApproved,
    };
