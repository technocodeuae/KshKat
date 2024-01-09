import 'package:dio/dio.dart';
import 'package:erp/di/components/service_locator.dart';
import 'package:erp/utils/validators/prefix_phone_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:erp/common/animation/animation_column_widget.dart';
import 'package:erp/common/widgets/base_body.dart';
import 'package:erp/common/widgets/vertical_padding.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/getx/application/application_bloc.dart';
import 'package:erp/getx/application/application_events.dart';
import 'package:erp/stores/language/language_store.dart';
import 'package:erp/ui/user_management/widgets/button_user_management_widget.dart';
import 'package:erp/ui/user_management/widgets/top_user_managemetn_section_widget.dart';
import 'package:erp/ui/user_management/widgets/user_management_background_widget.dart';
import 'package:erp/utils/device/app_uitls.dart';
import 'package:erp/utils/device/device_utils.dart';
import 'package:erp/utils/locale/app_localization.dart';
import 'package:erp/utils/routes/routes.dart';
import 'package:erp/utils/validators/base_validator.dart';
import 'package:erp/utils/validators/email_validator.dart';
import 'package:erp/utils/validators/required_validator.dart';
import 'package:erp/widgets/textfield/normal_line_form_field.dart';

import '../../../constants/app_constants.dart';
import '../../../data/repo/user_management_repository.dart';
import '../../../state/general_state.dart';
import '../../../utils/device/app_uitls.dart';
import '../../../utils/validators/min_length_validator.dart';
import '../../splash/argument/GlobalArgument.dart';
import '../controller/sign_in_controller.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double widthC = DeviceUtils.getScaledWidth(context, 1);
    double heightC = DeviceUtils.getScaledHeight(context, 1);
    return UserManagementBackgroundWidget(
      height: heightC,
      width: widthC,
      lang: Provider.of<LanguageStore>(context).getLanguage()!,
      child: LoginContentPage(
        width: widthC,
        height: heightC,
      ),
    );
  }
}

class LoginContentPage extends StatefulWidget {
  final double width;
  final double height;

  const LoginContentPage({required this.width, required this.height});

  @override
  _LoginContentPageState createState() => _LoginContentPageState();
}

class _LoginContentPageState extends State<LoginContentPage> {
  var _cancelToken = CancelToken();

  SignInController signInController = Get.find();

  final formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _textResetController = TextEditingController();
  bool cursorPositionSet = false;

  String _email = "";
  String _password = "";

  bool _emailValidation = false;
  bool _passwordValidation = false;

  FocusNode _emailNode = FocusNode();
  FocusNode _passNode = FocusNode();

  bool logoutUser = false;

  @override
  void initState() {
    super.initState();
    GeneralState.reset();
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
    // oauth.setWebViewScreenSizeFromMedia(MediaQuery.of(context));

    AppBar appBar = AppBar(
      // title: TopLoginLogoWidget(),
      backgroundColor: AppColors.transparent,
      // brightness: Brightness.light,
      toolbarHeight: 0,
      elevation: 0,
    );

    double widthC = widget.width;
    double heightC = widget.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top;

    return GetBuilder<SignInController>(builder: (state) {
      if (GeneralState.iSuccess) {
        if (state.signInSuccess.result.info != null &&
            state.signInSuccess.result.token != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            BlocProvider.of<ApplicationBloc>(context)..add(SetUserInfoEvent());
            // Navigator.pushNamedAndRemoveUntil(context,
            //  '/'
            // , (_) => false);
            getToken().whenComplete(() {
              Navigator.pushReplacementNamed(context, Routes.mainRootPage,
                  arguments: GlobalArgument(token, null, null, null, null));
            });
          });
        }
        // } else
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     AppUtils.snackBarMessage(
        //         context: context,
        //         message: AppLocalizations.of(context)
        //             .translate('reset_password_success'));
        //     GeneralState.reset();
        //   });
      }
      if (GeneralState.isFailure) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          AppUtils.showErrorMessage(
              error: state.signInFailure.error, context: context);
          GeneralState.reset();
        });
      }

      return ModalProgressHUD(
        inAsyncCall: GeneralState.isLoading,
        color: AppColors.mainColor,
        opacity: 0.2,
        progressIndicator: SpinKitRing(
          color: AppColors.mainColor,
        ),
        child: Scaffold(
          primary: true,
          backgroundColor: AppColors.transparent,
          appBar: appBar,
          body: _buildBody(height: heightC, width: widthC),
        ),
      );
    });
  }

  /// -------------------------------body methods-------------------------------
  Widget _buildBody({required double width, required double height}) {
    return BaseBody(
      portraitWidget: _portraitWidget(height: height, width: width),
      landscapeWidget: _landscapeWidget(height: height, width: width),
      isSafeAreaTop: true,
    );
  }

  /// ------------------------------portrait view-------------------------------
  Widget _portraitWidget({required double width, required double height}) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.only(
          left: AppDimens.space16, right: AppDimens.space16),
      alignment: AlignmentDirectional.center,
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
                percentage: 0.1,
              ),
              TopUserManagementSectionWidget(),
              VerticalPadding(
                percentage: 0.15,
              ),
              Row(
                textDirection: TextDirection.ltr,
                children: [
                  Container(
                    height: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.borderColor),
                        borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                    child: Text(
                      '+971',
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 45,
                      child: NormalLineFormField(
                        hintText: "",
                        labelText:
                            AppLocalizations.of(context).translate('phone'),
                        style: appTextStyle.subMinTSBasic
                            .copyWith(color: AppColors.mainGray),
                        hintStyle: appTextStyle.subMinTSBasic
                            .copyWith(color: AppColors.gray),
                        textAlign: TextAlign.start,
                        controller: _emailController,
                        onChanged: (value) {
                          cursorPositionSet = false;
                          setState(() {
                            _emailValidation = true;
                            _email = value.trim();
                          });
                        },
                        validator: (value) {
                          return BaseValidator.validateValue(
                            context,
                            value!,
                            [
                              RequiredValidator(),
                              MinLengthValidator(minLength: 9, isPhone: true),
                              PrefixPhoneValidator()
                            ],
                            _emailValidation,
                          );
                        },
                        prefixIcon: Container(
                          width: 25,
                          alignment: AlignmentDirectional.center,
                          child: Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  end: AppDimens.space8),
                              child: Icon(
                                Icons.email_outlined,
                                color: AppColors.mainColor,
                                size: 15,
                              )),
                        ),
                        onTap: () {
                          if (!cursorPositionSet) {
                            if (Localizations.localeOf(context).languageCode ==
                                'ar') {
                              _emailController.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset: _emailController.text.length));
                              cursorPositionSet = true;
                            }
                          }
                        },
                        focusNode: _emailNode,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_passNode);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              VerticalPadding(
                percentage: 0.02,
              ),
              NormalFormPasswordField(
                hintText: "",
                labelText: AppLocalizations.of(context).translate('password'),
                style: appTextStyle.subMinTSBasic
                    .copyWith(color: AppColors.mainGray),
                hintStyle:
                    appTextStyle.subMinTSBasic.copyWith(color: AppColors.gray),
                prefixIcon: Container(
                  width: 25,
                  alignment: AlignmentDirectional.center,
                  child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                          end: AppDimens.space8),
                      child: Icon(
                        Icons.lock_outline,
                        color: AppColors.mainColor,
                        size: 15,
                      )),
                ),
                onChanged: (value) {
                  setState(() {
                    _passwordValidation = true;
                    _password = value;
                  });
                },
                controller: _passwordController,
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
              ),
              VerticalPadding(
                percentage: 0.15,
              ),
              InkWell(
                onTap: () {
                  resetPassword(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(AppDimens.space8),
                  child: Text(
                    AppLocalizations.of(context).translate("reset_password"),
                    style: appTextStyle.subMinTSBasic.copyWith(
                        color: AppColors.mainColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ButtonUserManagementWidget(
                width: width,
                child: Text(
                  AppLocalizations.of(context).translate("login_btn_sign_in"),
                  style: appTextStyle.middleTSBasic
                      .copyWith(color: AppColors.white),
                ),
                backgroundColor: AppColors.mainColor,
                height: 55,
                borderRadius: 10.0,
                borderColor: AppColors.white,
                onPressed: () {
                  if (mounted) {
                    DeviceUtils.hideKeyboard(context);
                    setState(() {
                      _emailValidation = true;
                      _passwordValidation = true;
                    });
                    if (formKey.currentState!.validate()) {
                      signInController.signIn(
                          _cancelToken,
                          _emailController.text.toString().replaceAll(" ", ""),
                          _password.toString().replaceAll(" ", ""));
                    }
                  }
                },
              ),
              VerticalPadding(
                percentage: 0.02,
              ),
              Container(
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)
                          .translate("login_not_have_account_txt"),
                      style: appTextStyle.minTSBasic
                          .copyWith(color: AppColors.mainGray),
                    ),
                    // HorizontalPadding(percentage: .01,)
                    InkWell(
                      // splashColor: AppColors.mainColor,
                      onTap: () {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.of(context).pushNamed(Routes.signUpPage);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(AppDimens.space8),
                        child: Text(
                          AppLocalizations.of(context)
                              .translate("login_btn_sign_up"),
                          style: appTextStyle.subMinTSBasic.copyWith(
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ---------------------------landscape view---------------------------------
  Widget _landscapeWidget({required double width, required double height}) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.only(
          left: AppDimens.space16, right: AppDimens.space16),
      alignment: AlignmentDirectional.center,
      child: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }

  ///

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    _cancelToken.cancel();

    _passNode.dispose();
    _passwordController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  resetPassword(BuildContext context) async {
    _textResetController.text = "";
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: TextField(
              controller: _textResetController,
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: AppLocalizations.of(context).translate('email'),
                  labelText: AppLocalizations.of(context).translate('email')),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                      child: ButtonTheme(
                          height: 35,
                          minWidth: 110,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(AppRadius.radius6),
                                    ),
                                  )),
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('cancel'),
                                textAlign: TextAlign.center,
                                style: appTextStyle.minTSBasic
                                    .copyWith(color: AppColors.mainRed),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }))),
                  Container(
                    child: ButtonTheme(
                        height: 35,
                        minWidth: 110,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(AppRadius.radius6),
                                  ),
                                )),
                            child: Text(
                              AppLocalizations.of(context).translate('ok'),
                              textAlign: TextAlign.center,
                              style: appTextStyle.minTSBasic
                                  .copyWith(color: AppColors.white),
                            ),
                            onPressed: () async {
                              _textResetController.text.toString().isNotEmpty
                                  ? {
                                      signInController.forgetPassword(
                                          _cancelToken,
                                          _textResetController.text
                                              .toString()
                                              .replaceAll(" ", "")),
                                      Navigator.of(context).pop()
                                    }
                                  : AppUtils.showToast(
                                      msg: AppLocalizations.of(context)
                                          .translate('fill_data'),
                                      context: context);
                            })),
                  ),
                ],
              )
            ],
          );
        });
  }
}
