import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallfram/login/login.dart';
import 'package:wallfram/responsive/mobile_body.dart';
import 'package:wallfram/routes/pages.dart';
import 'package:wallfram/splashscreen/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splashScreen',
      getPages: pages
      //home: SplashScreen(),
    );
  }
}

