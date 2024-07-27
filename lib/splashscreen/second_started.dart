import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallfram/theme.dart';
import 'package:wallfram/splashscreen/third_started.dart';

import '../routes/pages.dart';

class SecondStarted extends StatefulWidget {
  const SecondStarted({Key? key}) : super(key: key);

  @override
  State<SecondStarted> createState() => _SecondStartedState();
}

class _SecondStartedState extends State<SecondStarted>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideInAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeInAnimation = Tween<double>(begin: 0, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _slideInAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: const Offset(0, 0),
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 22.0),
                      child: Center(child: Image.asset('images/logo.png')),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 92.0),
                        child: Center(
                          child: SlideTransition(
                              position: _slideInAnimation,
                              child: Image.asset('images/wallet.png')),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 63.0),
                      child: Column(
                        children: [
                          Container(
                            width: 300,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Mencatat dengan tampilan menarik',
                                  style: subTextStyle,
                                  textAlign: TextAlign.center,
                                )),
                          ),
                          Container(
                            width: 300,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 24.0),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Maksimalkan pencatatan keuangan kamu setiap hari.',
                                    style: subMiniTextStyle,
                                    textAlign: TextAlign.center,
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 31.0),
                            child: FadeTransition(
                              opacity: _fadeInAnimation,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(Routes.THIRD);
                                  // Navigator.push(context, MaterialPageRoute(
                                  //     builder: (context) => ThirdStarted()));
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(0xFF9770FA)),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                    minimumSize: MaterialStateProperty.all(
                                        Size(290, 51))),
                                child: Text('Lanjut', style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}
