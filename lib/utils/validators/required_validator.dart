import 'package:flutter/material.dart';
import 'package:erp/utils/locale/app_localization.dart';

import 'base_validator.dart';

class RequiredValidator extends BaseValidator {
  bool? isFromVerificationPage;

  RequiredValidator({this.isFromVerificationPage});

  @override
  String getMessage(BuildContext? context) {
    if (isFromVerificationPage != null && isFromVerificationPage!) return '*';
    return AppLocalizations.of(context!).translate('v_required');
  }

  @override
  bool validate(String value) {
    return value != null && value.isNotEmpty;
  }
}
class RequiredSmallMessageValidator extends BaseValidator {
  bool? isFromVerificationPage;

  RequiredSmallMessageValidator({this.isFromVerificationPage});

  @override
  String getMessage(BuildContext? context) {
    if (isFromVerificationPage != null && isFromVerificationPage!) return '*';
    return AppLocalizations.of(context!).translate('vs_required');
  }

  @override
  bool validate(String value) {
    return value != null && value.isNotEmpty;
  }
}
