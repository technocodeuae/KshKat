import 'package:flutter/cupertino.dart';
import 'package:erp/constants/app_constants.dart';

class UserManagementTextTitleWidget extends StatelessWidget {
  final String title;
  final TextStyle? style;
  final AlignmentGeometry? alignment;

  const UserManagementTextTitleWidget({required this.title,this.style,this.alignment});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment ?? AlignmentDirectional.centerStart,
      child: Text(
        title,
        style: style ?? appTextStyle.normalTSBasic.copyWith(color: AppColors.mainGray,height: 1.4,fontWeight: FontWeight.w200),
      ),
    );
  }
}
