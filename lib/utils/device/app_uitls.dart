import 'package:another_flushbar/flushbar_helper.dart';
import 'package:erp/utils/dio/errors/custom_error.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/constants/strings.dart';
import 'package:erp/data/app_server_constants.dart';
import 'package:erp/utils/dio/errors/bad_request_error.dart';
import 'package:erp/utils/dio/errors/base_error.dart';
import 'package:erp/utils/dio/errors/cancel_error.dart';
import 'package:erp/utils/dio/errors/connection_error.dart';
import 'package:erp/utils/dio/errors/forbidden_error.dart';
import 'package:erp/utils/dio/errors/http_error.dart';
import 'package:erp/utils/dio/errors/internal_server_error.dart';
import 'package:erp/utils/dio/errors/not_found_error.dart';
import 'package:erp/utils/dio/errors/unknown_error.dart';
import 'package:erp/utils/locale/app_localization.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUtils {
  AppUtils._();

  String _lang = Strings.LANG_EN;

  static bool notNullOrEmpty(String? value) {
    return value != null && value.isNotEmpty;
  }

  Future<bool> canLaunchLink(String linkToOpen, BuildContext context) async =>
      await canLaunch(linkToOpen);

  static launchURL(String urlPath) async {
    var url = urlPath;
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  static String getShortName({String? name}){

    String short = "";
    if(notNullOrEmpty(name?.trim())){
      print("Name is ${name!.trim()}");
      List<String> list = name.trim().split(" ");
      String firstName = list.first;
      print("First Name $firstName");
      String lastName = list.last;
      print("Last Name $lastName");
      short = firstName[0] + lastName[0];
    }
    return short;
  }
  static String getMOMStatusName(BuildContext context,int status) {
    if (status == AppServerConstants.MS_Draft) {
      return AppLocalizations.of(context).translate("draft");
    } else if (status == AppServerConstants.MS_Reviewing) {
      return AppLocalizations.of(context).translate('pending_review');
    } else if (status == AppServerConstants.MS_ToApprove) {
      return AppLocalizations.of(context).translate('pending_approve');
    } else if (status == AppServerConstants.MS_Approved) {
      return AppLocalizations.of(context).translate('approved');
    } else if (status == AppServerConstants.MS_Completed) {
      return AppLocalizations.of(context).translate('completed');
    } else if (status == AppServerConstants.MS_Return) {
      return AppLocalizations.of(context).translate('return');
    } else {
      return AppLocalizations.of(context).translate("draft");
    }
  }

/*  static showToast({required String msg,
  Toast? toastLength,required BuildContext context}) {
    FToast fToast=FToast();
    fToast.init(context);
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.radiusDefault),
        color: AppColors.mainColor,
      ),
      child: Text(msg, style: appTextStyle.minTSBasic.copyWith(
        color: AppColors.white,
      ),),
    );

    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 2),
    );
  }*/

  static showToast(
      {required String msg,
  required BuildContext context,
        Toast? toastLength,
        Color? backgroundColor,
        Color? textColor}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: toastLength,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: AppTextSize.small,);
  }

  static showMessage(
      {String? message, String? title, required BuildContext context}) {
    if (notNullOrEmpty(message)) {
      Future.delayed(Duration(milliseconds: 0), () {
        if (message!.isNotEmpty) {
          FlushbarHelper.createInformation(
            message: message,
            title: title ?? '',
            duration: Duration(seconds: 3),
          )..show(context);
        }
      });
    }

    return SizedBox.shrink();
  }

  static showErrorMessage(
      {required BaseError error, required BuildContext context}) {
    String _message = "";

    if (error is ForbiddenError) {
      _message = error.message!;
    } else if (error is NotFoundError) {
      _message = AppLocalizations.of(context).translate("err_not_found");
    } else if (error is InternalServerError) {
      _message = AppLocalizations.of(context).translate("err_internal_server");
    } else if (error is HttpError) {
      if (error is BadRequestError) {
        _message = notNullOrEmpty(error.message)
            ? error.message!
            : AppLocalizations.of(context).translate("err_unexpected");
      } else {
        _message = AppLocalizations.of(context).translate("err_http_error");
      }
    } else if (error is ConnectionError) {
      if (error is UnknownError) {
        _message = notNullOrEmpty(error.message)
            ? error.message!
            : AppLocalizations.of(context).translate("err_unexpected");
      } else
        _message = AppLocalizations.of(context).translate("err_connection");
    }else if (error is CustomError) {
      _message=error.message!;
    } else if (error is CancelError) {
      _message = AppLocalizations.of(context).translate("err_cancel_server");
    }
    //UnknownError()
    else {
      _message = AppLocalizations.of(context).translate("err_unexpected");
    }

    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _message,
          style: appTextStyle.smallTSBasic.copyWith(color: AppColors.white),
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }

  static snackBarMessage({required BuildContext context, String? message}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message!,
          style: appTextStyle.smallTSBasic.copyWith(color: AppColors.white),
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }

  static showSuccessMessages(
      {String? message, String? title, required BuildContext context}) {
    if (message!.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 0), () {
        if (message.isNotEmpty) {
          FlushbarHelper.createSuccess(
            message: message,
            title: title ?? '',
            duration: Duration(seconds: 3),
          )..show(context);
        }
      });
    }

    return SizedBox.shrink();
  }

  static showDialog<T>({required BuildContext context, required Widget child}) {
    showDialog<T>(
      context: context,
      child: child,
    ).then<void>((T? value) {
      // The value passed to Navigator.pop() or null.
    });
  }

  static double getPresentAsDouble({String? rate}) {
    if (AppUtils.notNullOrEmpty(rate)) {
      String withoutPresent = rate!.replaceAll("%", "");
      // print("real string rate $withoutPresent");
      if (AppUtils.notNullOrEmpty(withoutPresent.trim()))
        return double.parse(withoutPresent.trim()) > 0
            ? double.parse(withoutPresent.trim()) / 100
            : 0.0;
    }

    return 0.0;
  }
  static double getPresentAsDoubleFixedOne({String? rate}) {
    if (AppUtils.notNullOrEmpty(rate)) {
      String withoutPresent = rate!.replaceAll("%", "");
      // print("real string rate $withoutPresent");
      if (AppUtils.notNullOrEmpty(withoutPresent.trim()))
        return double.parse(withoutPresent.trim()) > 0
            ? double.parse(withoutPresent.trim())
            : 1.0;
    }

    return 0.0;
  }

  static showSnackBar(
      {required BuildContext context,
        required String message,
        TextStyle? style,
        Color? backgroundColor,
      }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: style ?? appTextStyle.smallTSBasic.copyWith(
            color: AppColors.white
          ),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: backgroundColor?? AppColors.mainColor,
      ),
    );
  }
}
