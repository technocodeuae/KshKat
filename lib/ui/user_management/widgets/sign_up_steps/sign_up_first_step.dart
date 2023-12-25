import 'package:dio/dio.dart';
import 'package:erp/di/components/service_locator.dart';
import 'package:erp/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:erp/common/animation/animation_column_widget.dart';
import 'package:erp/common/widgets/vertical_padding.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/getx/application/application_bloc.dart';
import 'package:erp/getx/application/application_events.dart';
import 'package:erp/ui/user_management/widgets/password_text_field_checker_widget.dart';
import 'package:erp/utils/device/app_uitls.dart';
import 'package:erp/utils/device/device_utils.dart';
import 'package:erp/utils/locale/app_localization.dart';
import 'package:erp/utils/validators/base_validator.dart';
import 'package:erp/utils/validators/email_validator.dart';
import 'package:erp/utils/validators/match_validator.dart';
import 'package:erp/utils/validators/required_validator.dart';
import 'package:erp/widgets/button/swip_button.dart';
import 'package:erp/widgets/textfield/normal_line_form_field.dart';

import '../../../../data/repo/user_management_repository.dart';
import '../../../../state/general_state.dart';
import '../../../splash/argument/GlobalArgument.dart';
import '../../controller/sign_up_controller.dart';
import '../sign_up_back_button.dart';
import '../top_user_managemetn_section_widget.dart';

class SignUpFirstStepWidget extends StatefulWidget {
  final double width;
  final Function(int, String, String, String, String) onSuccess;

  const SignUpFirstStepWidget({required this.width, required this.onSuccess});

  @override
  _SignUpFirstStepWidgetState createState() => _SignUpFirstStepWidgetState();
}

class _SignUpFirstStepWidgetState extends State<SignUpFirstStepWidget> {
  final formKey = GlobalKey<FormState>();

  SignUpController signUpController = Get.find();

  PasswordValidationModel? _passwordChecker;

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();

  String _userName = "";
  String _email = "";
  String _password = "";
  String _confirmPassword = "";
  String _mobile = "";
  bool _emailValidation = false;
  bool _userNameValidation = false;
  bool _passwordValidation = false;
  bool _confirmPasswordValidation = false;
  bool _mobileValidation = false;

  FocusNode _userNameNode = FocusNode();
  FocusNode _emailNode = FocusNode();
  FocusNode _passNode = FocusNode();
  FocusNode _confirmPassNode = FocusNode();
  FocusNode _mobileNode = FocusNode();

  var _cancelToken = CancelToken();

  @override
  void initState() {
    super.initState();
    GeneralState.reset();
    _passwordChecker = PasswordValidationModel(
        hasDigits: false,
        hasEight: false,
        hasSpecialCharacters: false,
        hasLowercaseAndUppercase: false);
    _passwordController.addListener(() {
      setState(() {
        if (_passwordChecker!.hasEight = _passwordController.text.length >= 8) {
          _passwordChecker!.hasEight = true;
        }
        if (_passwordChecker!.hasLowercaseAndUppercase =
            _passwordController.text.contains(RegExp(r'[A-Z]')) &&
                _passwordController.text.contains(RegExp(r'[a-z]'))) {
          _passwordChecker!.hasLowercaseAndUppercase = true;
        }
        if (_passwordChecker!.hasDigits =
            _passwordController.text.contains(RegExp(r'[0-9]'))) {
          _passwordChecker!.hasDigits = true;
        }
        if (_passwordChecker!.hasSpecialCharacters = _passwordController.text
            .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
          _passwordChecker!.hasSpecialCharacters = true;
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    GeneralState.reset();
  }

  var token;
  UserManagementRepository _repository = getIt<UserManagementRepository>();

  Future<void> getToken() async {
    token = await _repository.authToken;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(builder: (state) {
      if (GeneralState.iSuccess) {
        // AppUtils.showSuccessMessage(context: context,message: "success");
        if (state.signUpSuccess.result.token != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            BlocProvider.of<ApplicationBloc>(context)..add(SetUserInfoEvent());
            getToken().whenComplete(() {
              Navigator.pushReplacementNamed(context, Routes.mainRootPage,
                  arguments: GlobalArgument(token, null, null, null, null));
            });
            // Navigator.pushNamedAndRemoveUntil(context,'/',(_) => false);
          });
        } else
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AppUtils.snackBarMessage(
                context: context,
                message: AppLocalizations.of(context)
                    .translate('err_not_correct_info'));
          });
      }
      if (GeneralState.isFailure) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          AppUtils.showErrorMessage(
              error: state.signUpFailure.error, context: context);
        });
      }

      return ModalProgressHUD(
        inAsyncCall: GeneralState.isLoading,
        color: AppColors.mainColor,
        opacity: 0.2,
        progressIndicator: SpinKitRing(
          color: AppColors.mainColor,
        ),
        child: Container(
          padding: const EdgeInsets.only(
              left: AppDimens.space16, right: AppDimens.space16),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: AnimationColumnWidget(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                duration: Duration(milliseconds: 1000),
                verticalOffset: 50,
                children: [
                  SizedBox(
                    height: kToolbarHeight,
                  ),
                  VerticalPadding(
                    percentage: 0.15,
                  ),
                  TopUserManagementSectionWidget(),
                  VerticalPadding(
                    percentage: 0.02,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppDimens.space8),
                    child: SignUpBackButton(
                      onPressed: () => Navigator.of(context).pop(),
                      title: AppLocalizations.of(context)
                          .translate('login_btn_sign_in'),
                    ),
                  ),
                  /* VerticalPadding(
                          percentage: 0.02,
                        ),
                        SignUpIndicator(index: 1),*/
                  VerticalPadding(
                    percentage: 0.05,
                  ),
                  NormalLineFormField(
                    hintText: "",
                    labelText:
                        AppLocalizations.of(context).translate('username'),
                    style: appTextStyle.subMinTSBasic
                        .copyWith(color: AppColors.mainGray),
                    hintStyle: appTextStyle.subMinTSBasic
                        .copyWith(color: AppColors.gray),
                    textAlign: TextAlign.start,
                    controller: _userNameController,
                    onChanged: (value) {
                      setState(() {
                        _userNameValidation = true;
                        _userName = value;
                      });
                    },
                    validator: (value) {
                      return BaseValidator.validateValue(
                        context,
                        value!,
                        [RequiredValidator()],
                        _userNameValidation,
                      );
                    },
                    focusNode: _userNameNode,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_emailNode);
                    },
                  ),
                  VerticalPadding(
                    percentage: .01,
                  ),
                  NormalLineFormField(
                    hintText: "",
                    labelText: AppLocalizations.of(context).translate('email'),
                    style: appTextStyle.subMinTSBasic
                        .copyWith(color: AppColors.mainGray),
                    hintStyle: appTextStyle.subMinTSBasic
                        .copyWith(color: AppColors.gray),
                    textAlign: TextAlign.start,
                    controller: _emailController,
                    onChanged: (value) {
                      setState(() {
                        _emailValidation = true;
                        _email = value.trim();
                      });
                    },
                    validator: (value) {
                      return BaseValidator.validateValue(
                        context,
                        value!,
                        [RequiredValidator(), EmailValidator()],
                        _emailValidation,
                      );
                    },
                    focusNode: _emailNode,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_mobileNode);
                    },
                  ),
                  VerticalPadding(
                    percentage: .01,
                  ),
                  TextFormField(
                    textDirection: TextDirection.ltr,
                    onChanged: (value) {
                      setState(() {
                        _mobileValidation = true;
                        _mobile = value.trim();
                      });
                    },
                    validator: (value) {
                      return BaseValidator.validateValue(
                        context,
                        value!,
                        [RequiredValidator()],
                        _mobileValidation,
                      );
                    },
                    focusNode: _mobileNode,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelStyle: appTextStyle.subMinTSBasic
                          .copyWith(color: AppColors.mainColor),
                      errorStyle: appTextStyle.subMinTSBasic.copyWith(
                        color: Colors.red,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.mainGreen),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.darkGreen),
                      ),
                      border: UnderlineInputBorder(),
                      hintText:
                          AppLocalizations.of(context).translate("mobile_ex"),
                      labelText:
                          AppLocalizations.of(context).translate("mobile"),
                      hintStyle: new TextStyle(color: AppColors.chartGray),
                    ),
                    controller: _mobileController,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passNode);
                    },
                    style: appTextStyle.minTSBasic
                        .copyWith(color: AppColors.mainGray),
                    inputFormatters: [
                      PhoneInputFormatter(
                        //   onCountrySelected: _onCountrySelected,
                        allowEndlessPhone: false,
                      )
                    ],
                  ),
                  VerticalPadding(
                    percentage: .01,
                  ),
                  NormalFormPasswordField(
                    hintText: "",
                    controller: _passwordController,
                    labelText:
                        AppLocalizations.of(context).translate('password'),
                    style: appTextStyle.subMinTSBasic
                        .copyWith(color: AppColors.mainGray),
                    hintStyle: appTextStyle.subMinTSBasic
                        .copyWith(color: AppColors.gray),
                    textAlign: TextAlign.start,
                    onChanged: (value) {
                      setState(() {
                        _passwordValidation = true;
                        _password = value;
                      });
                    },
                    validator: (value) {
                      return BaseValidator.validateValue(
                        context,
                        value!,
                        [RequiredValidator()],
                        _passwordValidation,
                      );
                    },
                    focusNode: _passNode,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_confirmPassNode);
                    },
                  ),
                  VerticalPadding(
                    percentage: .01,
                  ),
                  NormalFormPasswordField(
                    hintText: "",
                    labelText: AppLocalizations.of(context)
                        .translate('confirm_password'),
                    style: appTextStyle.subMinTSBasic
                        .copyWith(color: AppColors.mainGray),
                    hintStyle: appTextStyle.subMinTSBasic
                        .copyWith(color: AppColors.gray),
                    controller: _confirmPasswordController,
                    textAlign: TextAlign.start,
                    suffixIcon: Icon(
                      _confirmPassword.isNotEmpty &&
                              _confirmPassword == _password
                          ? Icons.check_circle_outline_sharp
                          : Icons.check_circle_outline,
                      color: _confirmPassword.isNotEmpty &&
                              _confirmPassword == _password
                          ? AppColors.mainYellow
                          : AppColors.mainGray,
                      size: 20,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _confirmPasswordValidation = true;
                        _confirmPassword = value;
                      });
                    },
                    validator: (value) {
                      return BaseValidator.validateValue(
                        context,
                        value!,
                        [RequiredValidator(), MatchValidator(value: _password)],
                        _confirmPasswordValidation,
                      );
                    },
                    focusNode: _confirmPassNode,
                    textInputAction: TextInputAction.done,
                  ),
                  VerticalPadding(
                    percentage: .04,
                  ),
                  PasswordChecker(_passwordChecker!, widget.width),
                  VerticalPadding(
                    percentage: .03,
                  ),
                  Container(
                    width: widget.width,
                    child: RichText(
                      text: TextSpan(
                          style: appTextStyle.subMinTSBasic
                              .copyWith(color: AppColors.mainGray),
                          children: <TextSpan>[
                            TextSpan(
                                text: AppLocalizations.of(context)
                                    .translate('privacy_policy_text_1'),
                                style: appTextStyle.subMinTSBasic
                                    .copyWith(color: AppColors.mainGray)),
                            TextSpan(
                                text:
                                    " ${AppLocalizations.of(context).translate('privacy_policy_text_2')}",
                                style: appTextStyle.subMinTSBasic.copyWith(
                                  color: AppColors.mainColor,
                                  decoration: TextDecoration.underline,
                                )),
                            TextSpan(
                                text:
                                    " ${AppLocalizations.of(context).translate('and')} ",
                                style: appTextStyle.subMinTSBasic
                                    .copyWith(color: AppColors.mainGray)),
                            TextSpan(
                                text: AppLocalizations.of(context)
                                    .translate('privacy_policy_text_3'),
                                style: appTextStyle.subMinTSBasic.copyWith(
                                  color: AppColors.mainColor,
                                  decoration: TextDecoration.underline,
                                )),
                          ]),
                    ),
                  ),
                  VerticalPadding(
                    percentage: .04,
                  ),
                  SwipeButton(
                    height: 75,
                    width: widget.width,
                    title: AppLocalizations.of(context)
                        .translate('swipe_to_left_complete'),
                    onSwipe: _swipeToSendData,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  _swipeToSendData() {
    if (mounted) {
      DeviceUtils.hideKeyboard(context);
      setState(() {
        _emailValidation = true;
        _passwordValidation = true;
        _confirmPasswordValidation = true;
        _userNameValidation = true;
        _mobileValidation = true;
      });

      if (formKey.currentState!.validate() /*&&_getStatusCount(true)==4*/) {
        signUpController.signUp(
            _cancelToken,
            _userName.toString().replaceAll(" ", ""),
            _email.toString().replaceAll(" ", ""),
            _password.toString().replaceAll(" ", ""),
            _mobile.toString().replaceAll(" ", ""));
      }
    }
  }

  _getStatusCount(bool status) {
    int count = 0;
    if (_passwordChecker!.hasEight! == status) count += 1;
    if (_passwordChecker!.hasLowercaseAndUppercase! == status) count += 1;
    if (_passwordChecker!.hasDigits! == status) count += 1;
    if (_passwordChecker!.hasSpecialCharacters! == status) count += 1;

    return count;
  }

  @override
  void dispose() {
    _confirmPassNode.dispose();
    _passNode.dispose();
    _emailNode.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
    _cancelToken.cancel();

    super.dispose();
  }
}
