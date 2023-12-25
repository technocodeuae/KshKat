import 'dart:async';

import 'package:erp/getx/simple_bloc_delegate.dart';
import 'package:erp/ui/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Injection.dart';
import 'data/repo/user_management_repository.dart';
import 'di/components/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void setupBloc() {
  Bloc.observer = SimpleBlocObserver();
}
/*
final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

// Initialize the Firebase SDK
Future<void> _initFirebaseMessaging() async {

  firebaseMessaging.getToken().then((token){

    print("token is $token");
  });
  // Request permission to receive notifications
  NotificationSettings settings = await firebaseMessaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
}

// Handle the received notification when the app is in the background
Future<void> _handleBackgroundMessage(RemoteMessage message) async {
  // ...

}
// Set up a notification listener
void _configureFirebaseMessaging() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // // Handle the received notification when the app is in the foreground


  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // Handle the received notification when the app is in the background


    // ...
  });

  FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
}*/


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  /*await Firebase.initializeApp(

  );
  await _initFirebaseMessaging();
  _configureFirebaseMessaging();*/

  await setPreferredOrientations();
  await singleRegister();
  await setupLocator();
  await getToken();
  await initGetX();
  setupBloc();

  return runZonedGuarded(() async {
    runApp(MyApp());
  }, (error, stack) {
    print(stack);
    print(error);
  });
}

Future<void> getToken() async {
  UserManagementRepository _repository = getIt<UserManagementRepository>();
  var token;
  token = await _repository.authToken;
}

Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitDown,
    // DeviceOrientation.landscapeRight,
    // DeviceOrientation.landscapeLeft,
  ]);
}
