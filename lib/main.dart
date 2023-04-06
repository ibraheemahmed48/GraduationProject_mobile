import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'FirebaseMessagingService/FirebaseMessagingService.dart';
import 'View/Login_page/login_main_page.dart';
import 'View/Splash.dart';
import 'View/home_page.dart';
import 'controler/auth/auth.dart';
import 'controler/method.dart';
import 'help/Colors.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('//////////////////////background////////////////////////////////');
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification !=null) {
      print('Received news message inqaaaabackground: ${message.notification?.title}');
    }
  });


  print('Message title: ${message.notification?.title}');
  print('Message body: ${message.notification?.body}');
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


  await FirebaseMessaging.instance.setAutoInitEnabled(true);
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
