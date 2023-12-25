import 'package:flutter/material.dart';
import 'package:erp/common/widgets/horizontal_padding.dart';
import 'package:erp/common/widgets/vertical_padding.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/utils/locale/app_localization.dart';

class SignUpIndicator extends StatelessWidget {
  final int index;
  const SignUpIndicator({required this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HorizontalPadding(
                percentage: .15,
              ),
              _buildCircleWidget(
                isActive: index >= 1,
                index: "1",
                // label: AppLocalizations.of(context).translate('enter_email'),
              ),
              Expanded(child: _buildLine()),
              _buildCircleWidget(
                isActive: index >= 2,
                index: "2",
                // label: AppLocalizations.of(context).translate('account_confirmation'),
              ),
              /*Expanded(child: _buildLine()),
              _buildCircleWidget(
                isActive: index >= 3,
                index: "3",
                // label: AppLocalizations.of(context).translate('account_setup'),
              ),*/
             /* Expanded(child: _buildLine()),
              _buildCircleWidget(
                isActive: index >= 3,
                index: "3",
                // label: AppLocalizations.of(context).translate('account_setup'),
              ),
              Expanded(child: _buildLine()),
              _buildCircleWidget(
                isActive: index >= 4,
                index: "4",
                //label: AppLocalizations.of(context).translate('done'),
              ),*/
              HorizontalPadding(
                percentage: .15,
              ),
            ],
          ),
          VerticalPadding(percentage: 0.01,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HorizontalPadding(
                percentage: .1,
              ),
              _buildLabelWidget(
                isActive: index == 1,
                //index: "1",
                label: AppLocalizations.of(context).translate('account_confirmation'),
              ),
              Expanded(child: _buildLine(color: AppColors.transparent)),
              _buildLabelWidget(
                isActive: index == 2,
                // index: "2",
                label: AppLocalizations.of(context)
                    .translate('verify'),
              ),
              /*Expanded(child: _buildLine(color: AppColors.transparent)),
              _buildLabelWidget(
                isActive: index == 3,
                // index: "3",
                label: AppLocalizations.of(context).translate('account_setup'),
              ),*/
              /*Expanded(child: _buildLine(color: AppColors.transparent)),
              _buildLabelWidget(
                isActive: index == 3,
                // index: "3",
                label: AppLocalizations.of(context).translate('account_setup'),
              ),
              Expanded(child: _buildLine(color: AppColors.transparent)),
              _buildLabelWidget(
                isActive: index == 4,
                // index: "4",
                label: "${AppLocalizations.of(context).translate('done')}!",
              ),*/
              HorizontalPadding(
                percentage: .1,
              ),
            ],
          ),
        ],
      ),
    );
  }



  Widget _buildLine({Color color = AppColors.mainColor}) {
    return Container(
      height: 1.0,
      color: color,
    );
  }

  Widget _buildCircleWidget({required String index, required bool isActive}) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
          color: isActive ? AppColors.mainColor : AppColors.white,
          shape: BoxShape.circle,
          border: Border.all(width: 1.0, color: AppColors.mainColor)),
      child: Center(
        child: Text(
          index,
          style: appTextStyle.minTSBasic.copyWith(
            color: isActive ? AppColors.white : AppColors.mainColor,
          ),
        ),
      ),
    );
  }

  Widget _buildLabelWidget({required String label, required bool isActive}) {
    return isActive
        ? Container(
        width: 65,
        child: Container(
          child: Text(
            label,
            style: appTextStyle.subMinTSBasic
                .copyWith(color: AppColors.mainColor),
            textAlign: TextAlign.center,
          ),
        ))
        : Container();
  }
}
