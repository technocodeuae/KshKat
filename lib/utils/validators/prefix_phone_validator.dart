import 'package:flutter/material.dart';
import 'package:erp/utils/locale/app_localization.dart';
import 'base_validator.dart';

class PrefixPhoneValidator extends BaseValidator {
  PrefixPhoneValidator();

  @override
  String getMessage(BuildContext? context) {
    return AppLocalizations.of(context!).translate('should_phone_start');
  }

  @override
  bool validate(String value) {
    String prefix = '';
    if (value.length == 9) {
      prefix = value[0] + value[1];
    } else if (value.length == 10) {
      prefix = value[1] + value[2];
    }
    return prefix == '50' ||
        prefix == '52' ||
        prefix == '54' ||
        prefix == '55' ||
        prefix == '58';
  }
}
