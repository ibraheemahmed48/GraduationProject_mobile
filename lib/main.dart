import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:notificationsystem_mobile/test2.dart';

import 'View/home_page.dart';
import 'help/Colors.dart';
import 'test.dart';

main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colorsapp.mainColor, // navigation bar color
    statusBarColor: Colorsapp.mainColor, // status bar color
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

        debugShowCheckedModeBanner: false,

        home: HomePage()
    );
  }
}
