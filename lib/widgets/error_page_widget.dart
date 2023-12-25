import 'package:erp/constants/app_assets.dart';
import 'package:erp/data/app_server_constants.dart';
import 'package:erp/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
          child: Column(
            children: [
              _buildErrorPage(),
              Text(AppLocalizations.of(context).translate("english"),
                textAlign: TextAlign.center,),
            ],
          )
      ),
    );
  }
  _buildErrorPage(){
    return Container(width: 375.w,height: 406.h,
        child: SvgPicture.asset(AppAssets.emptyPage));
  }
}
