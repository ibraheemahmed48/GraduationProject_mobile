import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:notificationsystem_mobile/View/home_page.dart';

import 'FirebaseMessagingService/FirebaseMessagingService.dart';
import 'View/Splash.dart';
import 'controler/method.dart';
import 'help/Colors.dart';
import 'test.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('//////////////////////background////////////////////////////////');


}
main() async {
  print("//////////////main//////////////////////");

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colorsapp.mainColor, // navigation bar color
    statusBarColor: Colorsapp.mainColor, // status bar color
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await Methods.requestPermission();
  FirebaseMessagingService.configureFirebaseMessaging();


  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  // messaging.getToken().then((token) => print("Firebase Token: $token"));


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

        debugShowCheckedModeBanner: false,

        home: Splash()
    );
  }
}
