import 'package:flutter/material.dart';
import 'package:erp/utils/locale/app_localization.dart';

import 'base_validator.dart';

class YearValidator extends BaseValidator {
  @override
  String getMessage(BuildContext? context) {
    return AppLocalizations.of(context!).translate('v_invalid_year');
  }

  @override
  bool validate(String value) {
    return value != null && value.isNotEmpty && value.length == 4;
  }
}
