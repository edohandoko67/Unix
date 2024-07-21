import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wallfram/home/home.controller.dart';

import '../widget/text_field.dart';

class EditTabungan extends StatefulWidget {
  EditTabungan({super.key});

  @override
  State<EditTabungan> createState() => _EditTabunganState();
}

class _EditTabunganState extends State<EditTabungan> {
  HomeController homeController = Get.put(HomeController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: 
          FutureBuilder<DocumentSnapshot<Object?>>(
              future: homeController.getEditData(Get.arguments),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  print(snapshot.data!.data().toString());
                  var data = snapshot.data!.data() as Map<String, dynamic>;
                  homeController.addUser.text = data['name'];
                  homeController.addMoney.text = data['money'];
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
                            hintText: 'Edit yang menabung ?',
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          CustomTextField(
                            controller: homeController.addMoney,
                            keyboardType: TextInputType.number,
                            hintText: 'Edit Jumlah Uang',
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          // TextField(
                          //   controller: homeController.addDate,
                          //   decoration: const InputDecoration(
                          //       border: OutlineInputBorder(),
                          //       labelText: '',
                          //       suffixIcon: Icon(Icons.calendar_month)),
                          //   keyboardType: TextInputType.none,
                          //   readOnly: true,
                          //   onTap: () async {
                          //     DateTime currentDate = DateTime.now();
                          //
                          //     DateTime? pickedDate = await showDatePicker(
                          //       context: context,
                          //       initialDate: currentDate,
                          //       firstDate: DateTime(1900),
                          //       lastDate: DateTime(2100),
                          //       locale: const Locale("id"),
                          //     );
                          //     if (pickedDate != null) {
                          //       String formattedDate =
                          //       DateFormat('dd MMMM yyyy').format(pickedDate);
                          //       homeController.addDate.text = formattedDate;
                          //     }
                          //   },
                          // ),
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
                                  homeController.editDataUser(
                                      homeController.addUser.text,
                                      homeController.addMoney.text,
                                      homeController.addDate.text,
                                      Get.arguments
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
                }
                return Center(child: CircularProgressIndicator(),);
              })
      ),
    );
  }
}
