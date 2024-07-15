import 'package:flutter/material.dart';
import 'package:wallfram/splashscreen/second_started.dart';
import 'package:wallfram/theme.dart';

class Started extends StatefulWidget {
  const Started({Key? key}) : super(key: key);

  @override
  State<Started> createState() => _StartedState();
}

class _StartedState extends State<Started> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideInAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
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
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget? child) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 22.0),
                    child: Center(child: FadeTransition(
                      opacity: _fadeInAnimation,
                      child: Image.asset('images/logo.png'),
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 92.0),
                    child: Center(child: SlideTransition(
                      position: _slideInAnimation,
                      child: Image.asset('images/savings.png'),
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 63.0),
                    child: Column(
                      children: [
                        Text('Wallfram', style: subTextStyle,),
                        Container(
                          width: 300,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 24.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text('Maksimalkan pencatatan keuangan kamu setiap hari.',
                                style: subMiniTextStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 31.0),
                    child: FadeTransition(
                      opacity: _fadeInAnimation,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SecondStarted()));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0xFF9770FA)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all(Size(290, 51)),
                        ),
                        child: Text('Mulai'),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

