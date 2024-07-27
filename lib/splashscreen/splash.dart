import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallfram/login/login.dart';
import 'package:wallfram/splashscreen/controller.dart';
import 'package:wallfram/started.dart';
import 'package:wallfram/started.dart';
import 'package:wallfram/theme.dart';

import '../routes/pages.dart';
import '../utils/storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;
  late Animation<double> _animation;

  final Storage _storage = Storage();
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    isLogin = _storage.isLogin();
    print(isLogin);

    _animationController = AnimationController(
        duration: const Duration(seconds: 5),
        vsync: this
    );

    _animation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut);

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut)
    );

    _animation.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        if (isLogin) {
          Get.toNamed(Routes.HOME);
        } else {
          Get.toNamed(Routes.SECOND);
        }
        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
      }
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          return Container(
            width: 500,
            height: 900,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/splash.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Opacity(
                  opacity: _animation.value,
                  child: Container(
                    width: 137,
                    height: 55,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/wallfam.png'),
                        fit: BoxFit.fill,
                      ),
                  ),
                ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

