import 'package:flutter/material.dart';
import 'package:erp/common/widgets/horizontal_padding.dart';
import 'package:erp/common/widgets/vertical_padding.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/utils/locale/app_localization.dart';

// class PasswordTextFieldCheckerWidget extends StatefulWidget {
//   final double width;
//
//   const PasswordTextFieldCheckerWidget({required this.width});
//
//   @override
//   _PasswordTextFieldCheckerWidgetState createState() => _PasswordTextFieldCheckerWidgetState();
// }
//
// class _PasswordTextFieldCheckerWidgetState extends State<PasswordTextFieldCheckerWidget> {
//   PasswordValidationModel? _passwordChecker;
//
//   TextEditingController _passwordController = TextEditingController();
//   TextEditingController _confirmPasswordController = TextEditingController();
//
//   String _password = "";
//   String _confirmPassword = "";
//   bool _passwordValidation = false;
//   bool _confirmPasswordValidation = false;
//
//   FocusNode _passNode = FocusNode();
//   FocusNode _confirmPassNode = FocusNode();
//
//   @override
//   void initState() {
//     super.initState();
//     _passwordChecker = PasswordValidationModel(
//         hasDigits: false,
//         hasEight: false,
//         hasSpecialCharacters: false,
//         hasLowercaseAndUppercase: false);
//     _passwordController.addListener(() {
//       setState(() {
//         if (_passwordChecker!.hasEight = _passwordController.text.length >= 8) {
//           _passwordChecker!.hasEight = true;
//         }
//         if (_passwordChecker!.hasLowercaseAndUppercase =
//             _passwordController.text.contains(RegExp(r'[A-Z]')) &&
//                 _passwordController.text.contains(RegExp(r'[a-z]'))) {
//           _passwordChecker!.hasLowercaseAndUppercase = true;
//         }
//         if (_passwordChecker!.hasDigits =
//             _passwordController.text.contains(RegExp(r'[0-9]'))) {
//           _passwordChecker!.hasDigits = true;
//         }
//         if (_passwordChecker!.hasSpecialCharacters = _passwordController.text
//             .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
//           _passwordChecker!.hasSpecialCharacters = true;
//         }
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           Container(
//             height: 45,
//             child: NormalFormPasswordField(
//               hintText: "*****************",
//               controller: _passwordController,
//               style: appTextStyle.sub3MinTSBasic.copyWith(color: AppColors.black),
//               textAlign: TextAlign.start,
//               onChanged: (value) {
//                 setState(() {
//                   _passwordValidation = true;
//                   _password = value;
//                 });
//               },
//               validator: (value) {
//                 return BaseValidator.validateValue(
//                   context,
//                   value!,
//                   [RequiredValidator()],
//                   _passwordValidation,
//                 );
//               },
//               focusNode: _passNode,
//               textInputAction: TextInputAction.next,
//               onFieldSubmitted: (_) {
//                 FocusScope.of(context).requestFocus(_confirmPassNode);
//               },
//             ),
//           ),
//           Container(
//             height: 45,
//             child: NormalFormPasswordField(
//               hintText: "*****************",
//               controller: _confirmPasswordController,
//               style: appTextStyle.sub3MinTSBasic.copyWith(color: AppColors.black),
//               textAlign: TextAlign.start,
//               suffixIcon:  Icon(
//                 _confirmPassword.isNotEmpty && _confirmPassword == _password  ? Icons.check_circle_outline_sharp : Feather.circle,
//                 color:  _confirmPassword.isNotEmpty && _confirmPassword == _password   ? AppColors.mainYellow : AppColors.mainGray,
//                 size: 20,
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   _confirmPasswordValidation = true;
//                   _confirmPassword = value;
//                 });
//               },
//               validator: (value) {
//                 return BaseValidator.validateValue(
//                   context,
//                   value!,
//                   [RequiredValidator(),MatchValidator(value: _password)],
//                   _confirmPasswordValidation,
//                 );
//               },
//               focusNode: _confirmPassNode,
//               textInputAction: TextInputAction.done,
//
//             ),
//           ),
//           VerticalPadding(
//             percentage: .04,
//           ),
//           PasswordChecker(_passwordChecker!, widget.width)
//         ],
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _confirmPassNode.dispose();
//     _passNode.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
// super.dispose();
//   }
// }

class PasswordChecker extends StatelessWidget {
  PasswordChecker(this._passwordChecker, this.width);

  final PasswordValidationModel _passwordChecker;
  final double width;

  // final _passwordChecker = PasswordValidationModel();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /* Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      AppLocalizations.of(context)
                          .translate('your_password_must_have'),
                      style: appTextStyle.sub3MinTSBasic
                          .copyWith(color: AppColors.mainColor),
                    ),
                  ),
                  VerticalPadding(
                    percentage: .02,
                  ),
                  _buildIconWithTitleWidget(
                      title: AppLocalizations.of(context)
                          .translate('eight_required_pass'),
                      isActive: _passwordChecker.hasEight!),
                  VerticalPadding(
                    percentage: .01,
                  ),
                  _buildIconWithTitleWidget(
                      title: AppLocalizations.of(context)
                          .translate('upper_and_lower_case_letters'),
                      isActive: _passwordChecker.hasLowercaseAndUppercase!),
                  VerticalPadding(
                    percentage: .01,
                  ),
                  _buildIconWithTitleWidget(
                      title: AppLocalizations.of(context)
                          .translate('at_least_one_number'),
                      isActive: _passwordChecker.hasDigits!),
                  VerticalPadding(
                    percentage: .01,
                  ),
                  _buildIconWithTitleWidget(
                      title: AppLocalizations.of(context)
                          .translate('include_sample'),
                      isActive: _passwordChecker.hasSpecialCharacters!),
                ],
              ),
            ),
          ),*/
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    AppLocalizations.of(context).translate('password_strength'),
                    style: appTextStyle.sub3MinTSBasic
                        .copyWith(color: AppColors.mainColor),
                  ),
                ),
                VerticalPadding(
                  percentage: .02,
                ),
                Container(
                  height: 5,
                  child: Row(
                    children: [
                      _getListProgressDependOnStatus(true),
                      _getListProgressDependOnStatus(false),
                    ],
                  ),
                ),
                VerticalPadding(
                  percentage: .02,
                ),
                Container(
                  child: Text(
                    _getPasswordStatusLabel(context,_getStatusCount(true)),
                    style: appTextStyle.sub3MinTSBasic
                        .copyWith(color: _getPasswordStatusLabelColor(_getStatusCount(true))),
                  ),
                ),
                VerticalPadding(
                  percentage: .02,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _getListProgressDependOnStatus(bool status) {
    return _getStatusCount(status) != null && _getStatusCount(status) != 0
        ? Container(
      height: 5,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            width: 22,
            height: 5,
            margin:
            const EdgeInsets.symmetric(horizontal: AppDimens.space2),
            decoration: BoxDecoration(
                color: status ?  _getPasswordStatusLabelColor(_getStatusCount(status)): AppColors.lightGrey,
                borderRadius: BorderRadius.all(Radius.circular(AppRadius.radius6))),
          );
        },
        itemCount: _getStatusCount(status),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
      ),
    )
        : Container();
  }

  _getStatusCount(bool status) {
    int count = 0;
    if (_passwordChecker.hasEight! == status) count += 1;
    if (_passwordChecker.hasLowercaseAndUppercase! == status) count += 1;
    if (_passwordChecker.hasDigits! == status) count += 1;
    if (_passwordChecker.hasSpecialCharacters! == status) count += 1;

    return count;
  }

  String _getPasswordStatusLabel(BuildContext context,int count){
    switch(count){
      case 1:
        return AppLocalizations.of(context).translate('weak');
      case 2:
        return AppLocalizations.of(context).translate('medium');
      case 3:
        return AppLocalizations.of(context).translate('good');
      case 4:
        return AppLocalizations.of(context).translate('strong');
      default :
        return AppLocalizations.of(context).translate('weak');
    }
  }
  Color _getPasswordStatusLabelColor(int count){
    switch(count){
      case 1:
        return AppColors.mainGray;
      case 2:
        return AppColors.mainYellow;
      case 3:
        return AppColors.mainColor;
      case 4:
        return AppColors.mainGreen;
      default :
        return AppColors.mainGray;
    }
  }

  Widget _buildIconWithTitleWidget(
      {required String title, bool isActive = false}) {
    return Container(
      child: Row(
        children: [
          Icon(
            isActive ? Icons.check_circle_outline_sharp : Icons.check_circle_outline,
            color: isActive ? AppColors.mainGreen : AppColors.mainGray,
            size: 10,
          ),
          HorizontalPadding(
            percentage: .015,
          ),
          Text(
            title,
            style: appTextStyle.sub3MinTSBasic.copyWith(
                color: isActive ? AppColors.mainGreen : AppColors.mainGray),
          )
        ],
      ),
    );
  }
}

class PasswordValidationModel {
  bool? hasEight;
  bool? hasLowercaseAndUppercase;
  bool? hasDigits;
  bool? hasSpecialCharacters;
  int? length;

  PasswordValidationModel(
      {this.length,
        this.hasDigits,
        this.hasLowercaseAndUppercase,
        this.hasSpecialCharacters,
        this.hasEight});
}
