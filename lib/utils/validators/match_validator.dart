import 'package:flutter/material.dart';
import 'package:erp/utils/locale/app_localization.dart';

import 'base_validator.dart';

class MatchValidator extends BaseValidator {
  String value;

  MatchValidator({required this.value}) : assert(value != null);

  @override
  String getMessage(BuildContext? context) {
    return AppLocalizations.of(context!).translate('v_not_match');
  }

  @override
  bool validate(String value) {
    print('const value: ${this.value}');
    print('var value: $value');
    return value == this.value;
  }
}
