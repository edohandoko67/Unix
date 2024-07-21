import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallfram/home/home.controller.dart';

class ListYourCars extends StatefulWidget {
  ListYourCars({super.key});

  @override
  State<ListYourCars> createState() => _ListYourCarsState();
}

class _ListYourCarsState extends State<ListYourCars> {
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final itemHeight = screenHeight * 0.7;

    return Scaffold(
      body: Obx(() => SafeArea(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: homeController.listCars.length,
                  itemBuilder: (context, index) {
                    final item = homeController.listCars[index];
                    final imageWidth = screenWidth * 0.25;
                    return Card(
                        child: ListTile(
                          contentPadding: EdgeInsets.all(8.0),
                          title: Text(item.title, style: TextStyle(fontSize: mediaQuery.textScaleFactor * 16),),
                          subtitle: Text(item.production.toString(), style: TextStyle(fontSize: mediaQuery.textScaleFactor * 14),),
                          leading: SizedBox(
                              width: imageWidth,
                              child: Image.network(item.image, fit: BoxFit.cover,)),
                        )
                    );
                  }),
            ),
          ],
        ),),
      ),
    );
  }
}
