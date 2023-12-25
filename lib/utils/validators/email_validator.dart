import 'package:flutter/material.dart';
import 'package:erp/utils/locale/app_localization.dart';

import 'base_validator.dart';


class EmailValidator extends BaseValidator {
  @override
  String getMessage(BuildContext? context) {
    return AppLocalizations.of(context!).translate('v_invalid_email');
  }

  @override
  bool validate(String value) {
    final regex = RegExp(
        '^[a-zA-Z0-9.!#\$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\$');
    return regex.hasMatch(value.trim());
  }
}
