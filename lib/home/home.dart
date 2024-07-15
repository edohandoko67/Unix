import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallfram/home/home.controller.dart';
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
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? userName = loginController.storage.getName();
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xFFEDEDED),
          child: Expanded(
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 30.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Image.asset('images/logo.png'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 230.0, top: 3),
                        child: Icon(Icons.notifications),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 17.0, right: 17.0, top: 20),
                  child: Container(
                    width: 326,
                    height: 173,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Color(0xFF956EF7),
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  userName ?? 'Guest',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: GoogleFonts.poppins().fontFamily,
                                  ),
                                ),
                                Spacer(flex: 1),
                                Image.asset("images/Vector.png"),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 35),
                              child: Text(
                                'Saldo',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                ),
                              ),
                            ),
                            Text(
                              'Rp 45.240.056',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Bulan ini ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200,
                                    fontFamily: GoogleFonts.poppins().fontFamily,
                                  ),
                                ),
                                Text(
                                  'Rp 2.130.000/Rp 5.000.000',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: GoogleFonts.poppins().fontFamily,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 330,
                  height: 703,
                  margin: EdgeInsets.only(top: 20),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Color(0xFFFFFFFF),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 40, left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  'Grup Keluarga >',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    fontFamily: GoogleFonts.poppins().fontFamily,
                                  ),
                                ),
                              ),

                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 17.0, top: 20),
                                    child: SizedBox(
                                      width: 155,
                                      height: 90,
                                      child: Card(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        color: Color(0xFFFF5A97),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(top: 10, left: 10, right: 5),
                                                  child: CircleAvatar(
                                                    radius: 15,
                                                    child: IconButton(
                                                      icon: Icon(Icons.person),
                                                      onPressed: () {},
                                                      iconSize: 15,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(top: 10, right: 5),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Patrick",
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w200,
                                                          fontFamily: GoogleFonts.poppins().fontFamily,
                                                        ),
                                                      ),
                                                      Text(
                                                        "2 Januari 2023",
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w200,
                                                          fontFamily: GoogleFonts.poppins().fontFamily,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 10, top: 5),
                                              child: Text(
                                                "+ Rp 143.000",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: GoogleFonts.inter().fontFamily,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 17.0, top: 20),
                                    child: SizedBox(
                                      width: 155,
                                      height: 90,
                                      child: Card(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        color: Color(0xFFFF5A97),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(top: 10, left: 10, right: 5),
                                                  child: CircleAvatar(
                                                    radius: 15,
                                                    child: IconButton(
                                                      icon: Icon(Icons.person),
                                                      onPressed: () {},
                                                      iconSize: 15,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(top: 10, right: 5),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Patrick",
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w200,
                                                          fontFamily: GoogleFonts.poppins().fontFamily,
                                                        ),
                                                      ),
                                                      Text(
                                                        "2 Januari 2023",
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w200,
                                                          fontFamily: GoogleFonts.poppins().fontFamily,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 10, top: 5),
                                              child: Text(
                                                "+ Rp 143.000",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: GoogleFonts.inter().fontFamily,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(left: 10.0, right: 17.0, top: 20),
                                  //   child: SizedBox(
                                  //     width: 155,
                                  //     height: 90,
                                  //     child: Card(
                                  //       elevation: 10,
                                  //       shape: RoundedRectangleBorder(
                                  //         borderRadius: BorderRadius.circular(10),
                                  //       ),
                                  //       color: Color(0xFFFF5A97),
                                  //       child: Column(
                                  //         crossAxisAlignment: CrossAxisAlignment.start,
                                  //         children: [
                                  //           Row(
                                  //             crossAxisAlignment: CrossAxisAlignment.start,
                                  //             children: [
                                  //               Container(
                                  //                 margin: EdgeInsets.only(top: 10, left: 10, right: 5),
                                  //                 child: CircleAvatar(
                                  //                   radius: 15,
                                  //                   child: IconButton(
                                  //                     icon: Icon(Icons.person),
                                  //                     onPressed: () {},
                                  //                     iconSize: 15,
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //               Container(
                                  //                 margin: EdgeInsets.only(top: 10, right: 5),
                                  //                 child: Column(
                                  //                   crossAxisAlignment: CrossAxisAlignment.start,
                                  //                   children: [
                                  //                     Text(
                                  //                       "Patrick",
                                  //                       style: TextStyle(
                                  //                         fontSize: 13,
                                  //                         color: Colors.white,
                                  //                         fontWeight: FontWeight.w200,
                                  //                         fontFamily: GoogleFonts.poppins().fontFamily,
                                  //                       ),
                                  //                     ),
                                  //                     Text(
                                  //                       "2 Januari 2023",
                                  //                       style: TextStyle(
                                  //                         fontSize: 10,
                                  //                         color: Colors.white,
                                  //                         fontWeight: FontWeight.w200,
                                  //                         fontFamily: GoogleFonts.poppins().fontFamily,
                                  //                       ),
                                  //                     ),
                                  //                   ],
                                  //                 ),
                                  //               ),
                                  //             ],
                                  //           ),
                                  //           Container(
                                  //             margin: EdgeInsets.only(left: 10, top: 5),
                                  //             child: Text(
                                  //               "+ Rp 143.000",
                                  //               style: TextStyle(
                                  //                 fontSize: 14,
                                  //                 color: Colors.white,
                                  //                 fontWeight: FontWeight.w400,
                                  //                 fontFamily: GoogleFonts.inter().fontFamily,
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          selectedFontSize: 14.0, // Adjust the selected label font size
          unselectedFontSize: 12.0, // Adjust the unselected label font size
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "beranda"),
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
