import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'FirebaseMessagingService/FirebaseMessagingService.dart';
import 'View/Splash.dart';
import 'controler/auth/Account.dart';
import 'controler/auth/auth.dart';
import 'controler/method.dart';
import 'help/Colors.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.instance.setDeliveryMetricsExportToBigQuery(true);
  await UserPreferences.getAccount1();

  await Methods.reversedtime(
      oldtime: message.data["time"],
      studentName: Account.name,
      stage: Account.stage,
      title: message.notification!.body!);

  print("Handling a background message: ${message.messageId}");
}
main() async {
  print("//////////////main//////////////////////");
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colorsapp.mainColor, // navigation bar color
    statusBarColor: Colorsapp.mainColor, // status bar color
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseFirestore.instance.settings.persistenceEnabled;

  FirebaseMessagingService.configureFirebaseMessaging();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override




  Widget build(BuildContext context) {
    return const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splash(),

    );
  }
}
