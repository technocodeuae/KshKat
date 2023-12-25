import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:erp/common/widgets/vertical_padding.dart';
import 'package:erp/constants/colors.dart';
import 'package:erp/constants/text_style.dart';
import 'package:erp/state/general_state.dart';
import 'package:erp/ui/user_management/widgets/button_user_management_widget.dart';
import 'package:erp/utils/locale/app_localization.dart';
import 'package:erp/utils/locale/getLocation.dart';

import '../../../../../data/repo/user_management_repository.dart';
import '../../../../../di/components/service_locator.dart';
import '../../../../../utils/device/device_utils.dart';
import '../../../../../utils/routes/routes.dart';
import '../../../../utils/device/app_uitls.dart';
import '../argument/MapArgument.dart';
import '../controller/map_controller.dart';

class MapPage extends StatefulWidget {
  const MapPage();

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  static CameraPosition? startCameraPosition;
  GoogleMapController? controller;
  Set<Marker> markers = {};
  List<double> lanList = [20.5937, 78.9629];

  late LatLng _initialcameraposition;
  Location _location = Location();
  var _cancelToken = CancelToken();
  MapController mapController = Get.find();

  late String userInfo;
  var arg, numCart, token;
  TextEditingController _streetController = TextEditingController();
  TextEditingController _commentController = TextEditingController();
  TextEditingController _postalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: AppColors.scaffoldBGColor,
      body: Column(
        children: [
          VerticalPadding(
            percentage: 0.02,
          ),
          Expanded(
            child: _buildBody(),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    GeneralState.reset();
    arg = ModalRoute.of(context)!.settings.arguments as MapArgument;
    numCart = arg.numCart != null ? 0 : arg.numCart;
    token = arg.token!;
    userInfo = arg.userInfo!;
    _initialcameraposition = Platform.isIOS
        ? LatLng(arg.myLocationIos.latitude!, arg.myLocationIos.longitude!)
        : LatLng(arg.myLocation.latitude!, arg.myLocation.longitude!);
  }

  Future<void> _onMapCreated(GoogleMapController? controller) async {
    this.controller = controller;
    this.controller!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(_initialcameraposition.latitude,
                    _initialcameraposition.longitude),
                zoom: 15),
          ),
        );
  }

  Future<void> getLocation() async {
    _location.onLocationChanged.listen((l) {
      this.controller!.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(l.latitude!, l.longitude!), zoom: 15),
            ),
          );

      _initialcameraposition = LatLng(l.latitude!, l.longitude!);
      setState(() {
        markers.add(Marker(
            markerId: MarkerId('Home'),
            position: LatLng(l.latitude!, l.longitude!)));
      });
    });
  }

  Widget _buildBody() {
    return GetBuilder<MapController>(builder: (state) {
      if (GeneralState.isFailure) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          AppUtils.showErrorMessage(
              error: state.mapFailure.error, context: context);
        });
      }

      if (GeneralState.iSuccess) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Navigator.of(context).pushReplacementNamed(Routes.addressPage);
          Navigator.pop(context);
        });
      }

      return WillPopScope(
        onWillPop: () async {
          // Navigator.of(context).pushReplacementNamed(Routes.addressPage);
          Navigator.pop(context);
          return false;
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              GoogleMap(
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                mapType: MapType.normal,
                markers: markers,
                initialCameraPosition:
                    CameraPosition(target: _initialcameraposition),
                //TODO chech this attribute not work after update need to change for this => zoomGesturesEnabled
                //zoomControlsEnabled: true,
                onMapCreated: _onMapCreated,
                onCameraMove: (CameraPosition position) {
                  print(
                      "Latitude: ${position.target.latitude}; Longitude: ${position.target.longitude}");
                  _initialcameraposition = LatLng(
                      position.target.latitude, position.target.longitude);
                  setState(() {
                    markers.add(Marker(
                        markerId: MarkerId('Home'),
                        position: LatLng(position.target.latitude,
                            position.target.longitude)));
                  });
                },

                onCameraIdle: () async {},
              ),
              Padding(
                padding: EdgeInsets.all(60.0),
                child: ButtonUserManagementWidget(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    AppLocalizations.of(context).translate("confirm_address"),
                    style: appTextStyle.middleTSBasic
                        .copyWith(color: AppColors.white),
                  ),
                  backgroundColor: AppColors.mainColor,
                  height: 55,
                  borderRadius: 10.0,
                  borderColor: AppColors.white,
                  onPressed: () async {
                    String loc = await getLoc(_initialcameraposition.latitude,
                        _initialcameraposition.longitude);
                    var address = loc.split("-");
                    confirmAddress(
                        context,
                        DeviceUtils.getScaledWidth(context, 1),
                        address,
                        userInfo,
                        _initialcameraposition);
                  },
                ),
              ),
              VerticalPadding(
                percentage: 0.02,
              ),
            ],
          ),
        ),
      );
    });
  }

  confirmAddress(BuildContext context, var widthC, var address, var userInfo,
      var loc) async {
    _streetController.text = address[2];
    _postalController.text = '0000'; // address[4];
    // print("addddddddddresssssssssss $address");
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _streetController,
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).translate('street')),
                ),
                VerticalPadding(
                  percentage: 0.05,
                ),
                TextField(
                  controller: _commentController,
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)
                          .translate('additional_info')),
                ),
                VerticalPadding(
                  percentage: 0.05,
                ),
                TextField(
                  controller: _postalController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)
                          .translate('postal_code')),
                ),
              ],
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ButtonUserManagementWidget(
                    width: widthC / 3.15,
                    child: Text(
                      AppLocalizations.of(context).translate("cancel"),
                      style: appTextStyle.middleTSBasic
                          .copyWith(color: AppColors.black),
                    ),
                    backgroundColor: AppColors.white,
                    height: 55,
                    borderRadius: 10.0,
                    borderColor: AppColors.white,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ButtonUserManagementWidget(
                    width: widthC / 3.15,
                    child: Text(
                      AppLocalizations.of(context).translate("submit"),
                      style: appTextStyle.middleTSBasic
                          .copyWith(color: AppColors.white),
                    ),
                    backgroundColor: AppColors.mainColor,
                    height: 55,
                    borderRadius: 10.0,
                    borderColor: AppColors.mainColor,
                    onPressed: () {
                      if (_streetController.text.isNotEmpty) {
                        Navigator.of(context).pop();
                        mapController.saveAddress(_cancelToken, {
                          'country': 1,
                          'floor': "1",
                          'building': "",
                          'city': address[0] + "," + address[3],
                          'phone': userInfo.split(",")[1],
                          'name': address[1],
                          'postal_code': _postalController.text.toString(),
                          'note': _commentController.text.toString(),
                          'street': _streetController.text.toString(),
                          'latitude': _initialcameraposition.latitude,
                          'longitude': _initialcameraposition.longitude
                        });
                      }
                    },
                  ),
                ],
              )
            ],
          );
        });
  }
}
