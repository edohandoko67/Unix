import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallfram/home/fragment.home.dart';
import 'package:wallfram/home/home.controller.dart';
import 'package:wallfram/home/tabungan.dart';
import 'package:wallfram/login/loginController.dart';
import 'package:wallfram/utils/storage.dart';


class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  final Storage storage = Storage();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LoginController loginController = Get.put(LoginController());
  HomeController homeController = Get.put(HomeController());

  int _currentIndex = 0;

  final List<Widget> pages = [
    FragmentHome(),
    Tabungan()
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedFontSize: 14.0,
        // Adjust the selected label font size
        unselectedFontSize: 12.0,
        // Adjust the unselected label font size
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "beranda"),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Transaksi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistik',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.account_circle),
          //   label: 'Akun',
          // ),
        ],
      ),
    );
  }


}

