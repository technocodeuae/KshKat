import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:erp/common/widgets/base_body.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/stores/language/language_store.dart';
import 'package:erp/ui/user_management/widgets/sign_up_steps/sign_up_first_step.dart';
import 'package:erp/ui/user_management/widgets/user_management_background_widget.dart';
import 'package:erp/utils/args/external_info_args.dart';
import 'package:erp/utils/device/device_utils.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double widthC = DeviceUtils.getScaledWidth(context, 1);
    double heightC = DeviceUtils.getScaledHeight(context, 1);
    return UserManagementBackgroundWidget(
      height: heightC,
      width: widthC,
      lang: Provider.of<LanguageStore>(context).getLanguage()!,
      child: SignUpContentPage(
        width: widthC,
        height: heightC,
      ),
    );
  }
}

class SignUpContentPage extends StatefulWidget {
  final double width;
  final double height;

  const SignUpContentPage({required this.width, required this.height});

  @override
  _SignUpContentPageState createState() => _SignUpContentPageState();
}

class _SignUpContentPageState extends State<SignUpContentPage>
    with AutomaticKeepAliveClientMixin {
  //Current pages
  SignUpStepPageValue currentPageValue = SignUpStepPageValue.Enter_Email;
  int index = 0;
  String email="",userName="",password="";
  String _mobile = "";
  late ExternalInfoArgs info;

  var _cancelToken = CancelToken();

  bool _loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    AppBar appBar = AppBar(
      // title: TopLoginLogoWidget(),
      backgroundColor: AppColors.transparent,
      brightness: Brightness.light,
      toolbarHeight: 0,
      elevation: 0,
    );

    double widthC = widget.width;
    double heightC = widget.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top;

    return Scaffold(
        primary: true,
        backgroundColor: AppColors.transparent,
        appBar: appBar,
        body: _buildBody(height: heightC, width: widthC));
  }

  /// -------------------------------body methods-------------------------------
  Widget _buildBody({required double width, required double height}) {
    return BaseBody(
      portraitWidget: _portraitWidget(height: height, width: width),
      landscapeWidget: _portraitWidget(height: height, width: width),
      isSafeAreaTop: true,
    );
  }

  /// ------------------------------portrait view-------------------------------
  Widget _portraitWidget({required double width, required double height}) {
    return Container(
      height: height,
      width: width,
      // alignment: AlignmentDirectional.center,
      child: IndexedStack(
        index: index,
        children: [
          SignUpFirstStepWidget(
            width: width,
            onSuccess: _onSuccess,
          ),
        ],
      ),
    );
  }

  /// --------------------------------------------------------------------------
  /// ---------------------------Functions Section------------------------------
  /// --------------------------------------------------------------------------



  _onSuccess(int value,String email,String userName,String password,String mobile) {
    if (mounted) {
      setState(() {
        index = value;
        this.email=email;
        this.userName=userName;
        this.password=password;
        this._mobile=mobile;
      });
    }
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}

enum SignUpStepPageValue {
  Enter_Email,
}
