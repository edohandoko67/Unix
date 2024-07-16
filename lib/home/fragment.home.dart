import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:wallfram/login/loginController.dart';

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
                                homeController.addData(
                                    homeController.addUser.text,
                                    homeController.addMoney.text,
                                    homeController.addDate.text
                                );
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
      body: SafeArea(
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
                          FutureBuilder<QuerySnapshot<Object?>>(
                              future: homeController.getData(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.done) {
                                  print(snapshot.data!.docs);
                                  final item = snapshot.data!.docs;
                                  return ListView.builder(
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text('${(item[index].data() as Map<String, dynamic>)['name']}'),
                                          subtitle: Text('${item[index]['money']}'),
                                          trailing: Text('${item[index]['createdAt']}'),
                                        );
                                      });
                                }
                                return Center(child: CircularProgressIndicator(),);
                              })
                        ],
                      ),
                    ),
                  ),
                )
              ]),
        ),
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
