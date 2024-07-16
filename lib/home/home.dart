import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallfram/home/home.controller.dart';
import 'package:wallfram/login/loginController.dart';
import 'package:wallfram/utils/storage.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';

import '../widgets/text_field.dart';

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

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? userName = loginController.storage.getName();
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
                                homeController.writeToDatabase();
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
      //color: Color(0xFFEDEDED),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            color: Color(0xFFEDEDED),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('images/logo.png'),
                      IconButton(
                        icon: Icon(Icons.notifications),
                        onPressed: () {},
                      ),
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
                              'Rp 0.00',
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
                SizedBox(
                  width: double.infinity,
                  height: 500,
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
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0, right: 17.0, top: 20),
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
                                padding: const EdgeInsets.only(left: 10.0, right: 17.0, top: 20),
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
                            ],
                          ),
                          Text(
                            'Tabungan',
                            textAlign: TextAlign.start,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: homeController.items.length,
                              itemBuilder: (BuildContext context, int index) {
                                print('isi list : ${homeController.items}');
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10.0, right: 10.0),
                                  child: Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    color: Color(0xFF75A9B8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 10, left: 10, right: 5),
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
                                              margin:
                                                  EdgeInsets.only(top: 10, right: 5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    homeController.items[index]['dateAdd'],
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w200,
                                                      fontFamily:
                                                          GoogleFonts.poppins()
                                                              .fontFamily,
                                                    ),
                                                  ),
                                                  Text(
                                                    homeController.items[index].toString(),
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w200,
                                                      fontFamily:
                                                          GoogleFonts.poppins()
                                                              .fontFamily,
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
                                            homeController.items[index].toString(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontFamily:
                                                  GoogleFonts.inter().fontFamily,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                      // ListView.builder(
                      //   itemCount: homeController.items.length,
                      //   itemBuilder: (BuildContext context, int index) {
                      //     return Padding(
                      //       padding:
                      //           const EdgeInsets.only(left: 10.0, right: 10.0),
                      //       child: Card(
                      //         elevation: 10,
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(10),
                      //         ),
                      //         color: Color(0xFF75A9B8),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Row(
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               children: [
                      //                 Container(
                      //                   margin: EdgeInsets.only(
                      //                       top: 10, left: 10, right: 5),
                      //                   child: CircleAvatar(
                      //                     radius: 15,
                      //                     child: IconButton(
                      //                       icon: Icon(Icons.person),
                      //                       onPressed: () {},
                      //                       iconSize: 15,
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 Container(
                      //                   margin:
                      //                       EdgeInsets.only(top: 10, right: 5),
                      //                   child: Column(
                      //                     crossAxisAlignment:
                      //                         CrossAxisAlignment.start,
                      //                     children: [
                      //                       Text(
                      //                         homeController.items[index]['userAdd'],
                      //                         style: TextStyle(
                      //                           fontSize: 13,
                      //                           color: Colors.white,
                      //                           fontWeight: FontWeight.w200,
                      //                           fontFamily:
                      //                               GoogleFonts.poppins()
                      //                                   .fontFamily,
                      //                         ),
                      //                       ),
                      //                       Text(
                      //                         homeController.items[index]['dateAdd'],
                      //                         style: TextStyle(
                      //                           fontSize: 10,
                      //                           color: Colors.white,
                      //                           fontWeight: FontWeight.w200,
                      //                           fontFamily:
                      //                               GoogleFonts.poppins()
                      //                                   .fontFamily,
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //             Container(
                      //               margin: EdgeInsets.only(left: 10, top: 5),
                      //               child: Text(
                      //                 homeController.items[index]['moneyUser'],
                      //                 style: TextStyle(
                      //                   fontSize: 14,
                      //                   color: Colors.white,
                      //                   fontWeight: FontWeight.w400,
                      //                   fontFamily:
                      //                       GoogleFonts.inter().fontFamily,
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // )
                    ),
                  ),
                )
            ]),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedFontSize: 14.0,
        // Adjust the selected label font size
        unselectedFontSize: 12.0,
        // Adjust the unselected label font size
        items: [
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
                          loginController.signOut();
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
