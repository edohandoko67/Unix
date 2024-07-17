import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:wallfram/home/fragment.home.dart';
import 'package:wallfram/home/tabungan.dart';
import 'package:wallfram/splashscreen/second_started.dart';
import 'package:wallfram/splashscreen/third_started.dart';
import 'package:wallfram/started.dart';
import '../home/home.dart';
import '../login/login.dart';
import '../splashscreen/splash.dart';

part 'routes.dart';

List<GetPage> pages = [
  GetPage(name: Routes.INITIAL, page: () => const SplashScreen()),
  GetPage(name: Routes.LOGIN, page: () => Login()),
  GetPage(name: Routes.HOME, page: () => HomePage()),
  GetPage(name: Routes.FRAGMENTHOME, page: () => FragmentHome()),
  GetPage(name: Routes.TABUNGAN, page: () => Tabungan()),
  GetPage(name: Routes.STARTED, page: () => Started()),
  GetPage(name: Routes.SECOND, page: () => SecondStarted()),
  GetPage(name: Routes.THIRD, page: () => ThirdStarted()),
];