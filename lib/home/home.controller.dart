import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallfram/utils/storage.dart';

class HomeController extends GetxController {
  final Storage _storage = Storage();
  final database = FirebaseDatabase.instance.ref();
  var user = Rx<User?>(null);
  RxList<String> items = <String>[].obs;

  TextEditingController addUser = TextEditingController();
  TextEditingController addMoney = TextEditingController();
  TextEditingController addDate = TextEditingController();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }


  void writeToDatabase() async {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      print('Pengguna belum login atau tidak terautentikasi.');
      return;
    }
    try {
      final userRef = database.child('data').child(userId);
      // Menggunakan push() untuk mendapatkan ID unik dan menulis data
      final newEntryRef = userRef.push();
      await newEntryRef.set({
        'addUser': addUser.text,
        'moneyUser': double.tryParse(addMoney.text) ?? 0.0,
        'dateAdd': addDate.text
      });
      Get.snackbar(
          'Berhasil Menambahkan data',
          '${_storage.getName()}',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 2), // Durasi popup
          animationDuration: Duration(milliseconds: 800));
      addMoney.clear();
      addDate.clear();
    } catch (e, stackTrace) {
      print('Terjadi kesalahan saat menulis ke basis data: $e');
      print('stackTrace: $stackTrace');
    }

  }



}