import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/vertical_padding.dart';
import '../../../../../constants/app_dimens.dart';
import '../../../../../constants/colors.dart';
import '../../../../../constants/text_style.dart';
import '../../../../../widgets/textfield/normal_form_field.dart';

class SmallFilterWidget extends StatefulWidget {
    final ValueChanged<String> onSearchSubmittedChange;
    final Duration? duration;
    final Duration? delay;
    final List<String>? initializeSelected;
    final bool isFocus;

    const SmallFilterWidget(
        {
            required this.isFocus,
            required this.onSearchSubmittedChange,
            this.initializeSelected,
            this.duration = const Duration(milliseconds: 2500),
            this.delay = const Duration(milliseconds: 1500)});

    @override
    _SmallFilterWidgetState createState() =>
        _SmallFilterWidgetState();
}

class _SmallFilterWidgetState extends State<SmallFilterWidget> {

    TextEditingController _searchController = TextEditingController();
    String _search = "";

    @override
    void initState() {
        // TODO: implement initState
        super.initState();

    }

    @override
    void didChangeDependencies() {
        // TODO: implement didChangeDependencies
        super.didChangeDependencies();
    }

    @override
    Widget build(BuildContext context) {
        return FadeInLeftBig(
            delay: widget.delay!,
            duration: widget.duration!,
            animate: true,
            child: Container(

                child: Column(
                    children: [
                        VerticalPadding(
                            percentage: 0.04,
                        ),
                        Container(
                            height: 45,
                            alignment: AlignmentDirectional.centerStart,
                            padding: const EdgeInsets.only(
                                left: AppDimens.space16,
                                right: AppDimens.space16,
                            ),
                            child: RoundedFormField(
                                hintText: "",
                                borderRadius: 10,
                                filled: true,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.search,
                                fillColor: AppColors.white,
                                borderColor: AppColors.black,
                                controller: _searchController,
                                isEnableFocusOnTextField: widget.isFocus,
                                onChanged: (value) async{
                                    setState(() {
                                        _search = value;
                                    });
                                    await Future.delayed(Duration(seconds: 1), () {});
                                    print("on Search Submitted Change $_search");
                                    widget.onSearchSubmittedChange(_search);
                                },
                                onFieldSubmitted: (value){
                                    print("on Search Submitted Change $_search");
                                    widget.onSearchSubmittedChange(_search);
                                },
                                style:
                                appTextStyle.smallTSBasic.copyWith(color: AppColors.black),
                                hintStyle: appTextStyle.smallTSBasic
                                    .copyWith(color: AppColors.chartGray),
                                contentPadding: EdgeInsetsDirectional.only(
                                    start: AppDimens.space8,
                                    end: AppDimens.space8,
                                ),
                            ),
                        ),
                        VerticalPadding(
                            percentage: 0.04,
                        ),

                    ],
                ),
            ),
        );
    }
}
