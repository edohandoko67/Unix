import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallfram/theme.dart';

import '../login/login.dart';
import '../routes/pages.dart';

class ThirdStarted extends StatefulWidget {
  const ThirdStarted({Key? key}) : super(key: key);

  @override
  State<ThirdStarted> createState() => _ThirdStartedState();
}

class _ThirdStartedState extends State<ThirdStarted> with SingleTickerProviderStateMixin{
  late AnimationController _animationControllers;
  late Animation<double> _fadeInAnimations;
  late Animation<Offset> _slideInAnimation;

  @override
  void initState(){
    super.initState();

    _animationControllers = AnimationController(
      duration: const Duration(milliseconds: 1000),
        vsync: this);

    _fadeInAnimations = Tween<double>(begin: 0, end: 1.2).animate(
      CurvedAnimation(
          parent: _animationControllers,
          curve: Curves.easeIn
      ),
    );

    _slideInAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _animationControllers, curve: Curves.easeOut)
    );

    _animationControllers.forward();
  }
  @override
  void dispose(){
    _animationControllers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: AnimatedBuilder(
          animation: _animationControllers,
          builder: (BuildContext context, Widget? child) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Center(
                    child: FadeTransition(
                      opacity: _fadeInAnimations,
                        child: Image.asset('images/logo.png')),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:52.0),
                  child: Center(
                    child: SlideTransition(
                        position: _slideInAnimation,
                        child: Image.asset('images/invest.png')),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 29.0),
                  child: Column(
                    children: [
                      Container(
                        width: 300,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('Jangan lewatkan satu hal pun', style: subTextStyle, textAlign: TextAlign.center,),
                        ),
                      ),
                      Container(
                        width: 300,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text('Wallfam mungkin memerlukan izin tambahan untuk memberi tahu Anda tentang pencatatan keuangan',
                            style: subMiniTextStyle,
                            textAlign: TextAlign.center,),
                          ),
                        )
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 31),
                          child: FadeTransition(
                            opacity: _fadeInAnimations,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Color(0xFF9770FA)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                  )
                                ),
                                minimumSize: MaterialStateProperty.all(Size(290, 51))
                              ), onPressed: () {
                                // Navigator.push(
                                //   context, MaterialPageRoute(builder: (context) => Login())
                              Get.toNamed(Routes.LOGIN);
                            },
                              child: Text('Lanjut'),
                            ),
                          ),)
                    ],
                  ),
                )
              ],
            ),
          );
          },
        ),
      ),
    );
  }
}
