import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallfram/model/data.dart';
import 'package:wallfram/utils/storage.dart';

class HomeController extends GetxController {
  final Storage _storage = Storage();
  final DatabaseReference database = FirebaseDatabase.instance.reference().child('data');
  var user = Rx<User?>(null);
  RxList<String> items = <String>[].obs;
  RxList<DataUser> transactionsList = RxList<DataUser>();

  TextEditingController addUser = TextEditingController();
  TextEditingController addMoney = TextEditingController();
  TextEditingController addDate = TextEditingController();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }

  // void fetchTransactions() {
  //   database.onValue.listen((event) {
  //     if (event.snapshot.value != null) {
  //       // Clear the existing list before adding new data
  //       transactionsList.clear();
  //
  //       // Check if snapshot value is of type Map<dynamic, dynamic>
  //       if (event.snapshot.value is Map<dynamic, dynamic>) {
  //         Map<dynamic, dynamic> values = event.snapshot.value;
  //         // Iterate through the map and create DataUser objects
  //         values.forEach((key, value) {
  //           DataUser transaction = DataUser(
  //             name: value['nama'],
  //             money: value['uang'],
  //             date: value['tanggal'],
  //           );
  //           transactionsList.add(transaction);
  //         });
  //       } else {
  //         // Handle unexpected data structure or null case
  //         print('Unexpected data structure from Firebase: ${event.snapshot.value}');
  //       }
  //
  //       // Update state to notify the UI of changes
  //       update();
  //     }
  //   });
  // }

  void addTransactionToFirebase() async {
    String name = addUser.text.trim();
    int uang = int.tryParse(addMoney.text.trim()) ?? 0;
    String tanggal = addDate.text.trim();
    if (name.isNotEmpty && uang != 0 && tanggal.isNotEmpty) {
      //create a Transaction object
      DataUser transaction = DataUser(name: name, money: uang, date: tanggal);

      database.push().set(transaction.toMap()).then((value) {
        addUser.clear();
        addMoney.clear();
        addDate.clear();
        Get.snackbar(
            'Berhasil Menambahkan data',
            '${_storage.getName()}',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: Duration(seconds: 2), // Durasi popup
            animationDuration: Duration(milliseconds: 800));
      }).catchError((error) {
        // Handle error if data addition fails
        Get.snackbar('Error', 'Failed to add data: $error');
      });
    } else {
      // Show snackbar if any input fields are empty
      Get.snackbar('Error', 'Please fill in all fields');
    }
  }


  // void writeToDatabase() async {
  //   final String? userId = FirebaseAuth.instance.currentUser?.uid;
  //   if (userId == null) {
  //     print('Pengguna belum login atau tidak terautentikasi.');
  //     return;
  //   }
  //   try {
  //     final userRef = database.child('data').child(userId);
  //     // Menggunakan push() untuk mendapatkan ID unik dan menulis data
  //     final newEntryRef = userRef.push();
  //     await newEntryRef.set({
  //       'addUser': addUser.text,
  //       'moneyUser': double.tryParse(addMoney.text) ?? 0.0,
  //       'dateAdd': addDate.text
  //     });
  //     Get.snackbar(
  //         'Berhasil Menambahkan data',
  //         '${_storage.getName()}',
  //         backgroundColor: Colors.green,
  //         colorText: Colors.white,
  //         duration: Duration(seconds: 2), // Durasi popup
  //         animationDuration: Duration(milliseconds: 800));
  //     addMoney.clear();
  //     addDate.clear();
  //   } catch (e, stackTrace) {
  //     print('Terjadi kesalahan saat menulis ke basis data: $e');
  //     print('stackTrace: $stackTrace');
  //   }
  //
  // }



}