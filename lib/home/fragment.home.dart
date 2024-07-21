import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:wallfram/login/loginController.dart';

import '../routes/pages.dart';
import '../utils/storage.dart';
import '../widget/text_field.dart';
import 'home.controller.dart';

class FragmentHome extends StatefulWidget {
  FragmentHome({super.key});

  final Storage storage = Storage();

  @override
  State<FragmentHome> createState() => _FragmentHomeState();
}

class _FragmentHomeState extends State<FragmentHome> {
  LoginController loginController = Get.put(LoginController());
  HomeController homeController = Get.put(HomeController());
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  List<Map<String, dynamic>> cars = [
    {
      'merk': 'Toyota',
      'model': 'minibus',
      'name': 'Innova',
      'image': 'images/innova.png', },
    {
      'merk': 'Honda',
      'model': 'minibus',
      'name': 'Mobilio',
      'image': 'images/mobilio.jpg', },
    {
      'merk': 'Suzuki',
      'model': 'minibus',
      'name': 'Ertiga',
      'image': 'images/ertiga.png'
    }
  ];

  @override
  Widget build(BuildContext context) {
    String? userName = loginController.storage.getName();
    homeController.fetchMoney();
    homeController.streamData();
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final itemHeight = screenHeight * 0.7;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, top: 15.0, right: 15.0),
                  child: SizedBox(
                    height: 600,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          controller: homeController.addUser,
                          keyboardType: TextInputType.text,
                          hintText: 'Siapakah yang menabung ?',
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        CustomTextField(
                          controller: homeController.addMoney,
                          keyboardType: TextInputType.number,
                          hintText: 'Tambahkan Jumlah Uang',
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextField(
                          controller: homeController.addDate,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: '',
                              suffixIcon: Icon(Icons.calendar_month)),
                          keyboardType: TextInputType.none,
                          readOnly: true,
                          onTap: () async {
                            DateTime currentDate = DateTime.now();

                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: currentDate,
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                              locale: const Locale("id"),
                            );
                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('dd MMMM yyyy').format(pickedDate);
                              homeController.addDate.text = formattedDate;
                            }
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: const Color(0xFF145E35)),
                              onPressed: () {
                                homeController.addData(
                                    homeController.addUser.text,
                                    homeController.addMoney.text,
                                    homeController.addDate.text);
                              },
                              child: const Text(
                                'Simpan',
                                style: TextStyle(
                                    fontFamily: 'Poppins', color: Colors.white),
                              )),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
        child: const Text(
          '+',
          style: TextStyle(
              fontSize: 20,
              fontFamily: 'Poppins',
              color: Colors.green,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Obx(() {
        if (homeController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              color: Color(0xFFEDEDED),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('images/logo.png'),
                      // IconButton(
                      //   icon: Icon(Icons.notifications),
                      //   onPressed: () {
                      //
                      //   },
                      // ),
                      IconButton(
                          onPressed: () {
                            bottomSheetLogout(context);
                            //loginController.signOut();
                          },
                          icon: Icon(Icons.power_settings_new_rounded)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 17.0, right: 17.0),
                  child: SizedBox(
                    width: double.infinity,
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
                              margin: EdgeInsets.only(top: 30),
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
                              'Rp ${homeController.totalMoney}',
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
                                  'Rp ${homeController.totalMoney}/Rp 5.000.000',
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
                SizedBox(
                  width: double.infinity,
                  height: itemHeight,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Color(0xFFFFFFFF),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Grup Keluarga >',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                          // Expanded(
                          //   child: ListView(scrollDirection: Axis.horizontal, children: [
                          //     Row(
                          //       children: [
                          //         Padding(
                          //           padding: const EdgeInsets.only(
                          //               left: 10.0, right: 17.0, top: 20),
                          //           child: SizedBox(
                          //             width: 155,
                          //             height: 90,
                          //             child: Card(
                          //               elevation: 10,
                          //               shape: RoundedRectangleBorder(
                          //                 borderRadius: BorderRadius.circular(10),
                          //               ),
                          //               color: Color(0xFFFF5A97),
                          //               child: Column(
                          //                 crossAxisAlignment:
                          //                     CrossAxisAlignment.start,
                          //                 children: [
                          //                   Row(
                          //                     crossAxisAlignment:
                          //                         CrossAxisAlignment.start,
                          //                     children: [
                          //                       Container(
                          //                         margin: EdgeInsets.only(
                          //                             top: 10, left: 10, right: 5),
                          //                         child: CircleAvatar(
                          //                           radius: 15,
                          //                           child: IconButton(
                          //                             icon: Icon(Icons.person),
                          //                             onPressed: () {},
                          //                             iconSize: 15,
                          //                           ),
                          //                         ),
                          //                       ),
                          //                       Container(
                          //                         margin: EdgeInsets.only(
                          //                             top: 10, right: 5),
                          //                         child: Column(
                          //                           crossAxisAlignment:
                          //                               CrossAxisAlignment.start,
                          //                           children: [
                          //                             Text(
                          //                               "Patrick",
                          //                               style: TextStyle(
                          //                                 fontSize: 13,
                          //                                 color: Colors.white,
                          //                                 fontWeight:
                          //                                     FontWeight.w200,
                          //                                 fontFamily:
                          //                                     GoogleFonts.poppins()
                          //                                         .fontFamily,
                          //                               ),
                          //                             ),
                          //                             Text(
                          //                               "2 Januari 2023",
                          //                               style: TextStyle(
                          //                                 fontSize: 10,
                          //                                 color: Colors.white,
                          //                                 fontWeight:
                          //                                     FontWeight.w200,
                          //                                 fontFamily:
                          //                                     GoogleFonts.poppins()
                          //                                         .fontFamily,
                          //                               ),
                          //                             ),
                          //                           ],
                          //                         ),
                          //                       ),
                          //                     ],
                          //                   ),
                          //                   Container(
                          //                     margin:
                          //                         EdgeInsets.only(left: 10, top: 5),
                          //                     child: Text(
                          //                       "+ Rp 143.000",
                          //                       style: TextStyle(
                          //                         fontSize: 14,
                          //                         color: Colors.white,
                          //                         fontWeight: FontWeight.w400,
                          //                         fontFamily: GoogleFonts.inter()
                          //                             .fontFamily,
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 ],
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //         Padding(
                          //           padding: const EdgeInsets.only(
                          //               left: 10.0, right: 17.0, top: 20),
                          //           child: SizedBox(
                          //             width: 155,
                          //             height: 90,
                          //             child: Card(
                          //               elevation: 10,
                          //               shape: RoundedRectangleBorder(
                          //                 borderRadius: BorderRadius.circular(10),
                          //               ),
                          //               color: Color(0xFFFF5A97),
                          //               child: Column(
                          //                 crossAxisAlignment:
                          //                     CrossAxisAlignment.start,
                          //                 children: [
                          //                   Row(
                          //                     crossAxisAlignment:
                          //                         CrossAxisAlignment.start,
                          //                     children: [
                          //                       Container(
                          //                         margin: EdgeInsets.only(
                          //                             top: 10, left: 10, right: 5),
                          //                         child: CircleAvatar(
                          //                           radius: 15,
                          //                           child: IconButton(
                          //                             icon: Icon(Icons.person),
                          //                             onPressed: () {},
                          //                             iconSize: 15,
                          //                           ),
                          //                         ),
                          //                       ),
                          //                       Container(
                          //                         margin: EdgeInsets.only(
                          //                             top: 10, right: 5),
                          //                         child: Column(
                          //                           crossAxisAlignment:
                          //                               CrossAxisAlignment.start,
                          //                           children: [
                          //                             Text(
                          //                               "Patrick",
                          //                               style: TextStyle(
                          //                                 fontSize: 13,
                          //                                 color: Colors.white,
                          //                                 fontWeight:
                          //                                     FontWeight.w200,
                          //                                 fontFamily:
                          //                                     GoogleFonts.poppins()
                          //                                         .fontFamily,
                          //                               ),
                          //                             ),
                          //                             Text(
                          //                               "2 Januari 2023",
                          //                               style: TextStyle(
                          //                                 fontSize: 10,
                          //                                 color: Colors.white,
                          //                                 fontWeight:
                          //                                     FontWeight.w200,
                          //                                 fontFamily:
                          //                                     GoogleFonts.poppins()
                          //                                         .fontFamily,
                          //                               ),
                          //                             ),
                          //                           ],
                          //                         ),
                          //                       ),
                          //                     ],
                          //                   ),
                          //                   Container(
                          //                     margin:
                          //                         EdgeInsets.only(left: 10, top: 5),
                          //                     child: Text(
                          //                       "+ Rp 143.000",
                          //                       style: TextStyle(
                          //                         fontSize: 14,
                          //                         color: Colors.white,
                          //                         fontWeight: FontWeight.w400,
                          //                         fontFamily: GoogleFonts.inter()
                          //                             .fontFamily,
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 ],
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ]),
                          // ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: min(homeController.listCars.length ?? 0, 7),
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
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ),
        );
      })
    );}

  void bottomSheetLogout(BuildContext context) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
              width: 330,
              height: 545,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(3))),
                scrollable: true,
                title: Container(
                  width: double.infinity,
                  height: 50,
                  child: Center(
                    child: Text(
                      'Yakin, Ingin melanjutkan?',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(100, 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: Colors.blue),
                        onPressed: () {
                          loginController.signOut(loginController.email.text,
                              loginController.password.text);
                        },
                        child: Text(
                          'Ya',
                          style: TextStyle(color: Colors.white),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(100, 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: Colors.grey),
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          'Batal',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
