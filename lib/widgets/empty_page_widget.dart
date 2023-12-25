import 'package:erp/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: 375.w,height: 406.h,
        child: SvgPicture.asset(AppAssets.emptyPage),);
  }
  // or only text
//  return  Container(width: 375.w, height: 406.h,
//  child: Center(child: Text(
//  _selectedIndex==1?tr("no_orders"):tr("no_invoices"),style: titleHeaderStyle)));
}
