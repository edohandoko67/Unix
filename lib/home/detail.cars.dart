import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/cars.dart';

class DetailCars extends StatelessWidget {
  DetailCars({super.key});

  Cars cars = Get.arguments;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final itemHeight = screenHeight * 0.7;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 7,),
            Center(
              child: SizedBox(
                width: screenWidth * 0.9,
                  child: Image.network(cars.image, fit: BoxFit.cover,)),
            ),
            SizedBox(height: 7,),
            Text(cars.title, style: TextStyle(fontSize: mediaQuery.textScaleFactor * 16),),
            SizedBox(height: 7,),
            Text(cars.production.toString(), style: TextStyle(fontSize: mediaQuery.textScaleFactor * 14),),
          ],
        ),
      ),
    );
  }
}
