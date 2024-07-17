import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:wallfram/home/tabungan.dart';
import 'package:wallfram/login/loginController.dart';

import '../utils/storage.dart';
import '../widget/text_field.dart';
import 'fragment.home.dart';
import 'home.controller.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final List<Widget> _pages = [
  FragmentHome(),
  Tabungan(),
  FragmentHome(),
];

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: _currentIndex,
        destinations: const <Widget>[
          NavigationDestination(
              selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home'),
          NavigationDestination(
              selectedIcon: Icon(Icons.payment),
              icon: Icon(Icons.payment_outlined),
              label: 'Transaksi'),
          NavigationDestination(
              selectedIcon: Icon(Icons.bar_chart),
              icon: Icon(Icons.bar_chart_outlined),
              label: 'Transaksi'),
        ],
      ),
    );
  }
}
