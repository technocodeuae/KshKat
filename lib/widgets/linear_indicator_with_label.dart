import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/stores/language/language_store.dart';

class LinearIndicatorWithLabel extends StatefulWidget {
  final double value;
  final Color color;
  final double value2;
  final Color color2;
  final double value3;
  final Color color3;

  const LinearIndicatorWithLabel(
      {required this.value, required this.color, required this.value3, required this.color3, required this.value2, required this.color2,});

  @override
  _LinearIndicatorWithLabelState createState() =>
      _LinearIndicatorWithLabelState();
}

class _LinearIndicatorWithLabelState extends State<LinearIndicatorWithLabel> {
  late LanguageStore _languageStore;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //
    // initializing stores
    _languageStore = Provider.of<LanguageStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   color: AppColors.white,
      //   borderRadius: BorderRadius.only(
      //     bottomRight: Radius.circular(AppRadius.radius20),
      //     topRight: Radius.circular(AppRadius.radius20),
      //   ),
      //   //
      // ),
    );
  }
}
