import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wallfram/utils/storage.dart';

class HomeController extends GetxController {
  final Storage _storage = Storage();
  final _database = FirebaseDatabase.instance;

  TextEditingController addMoney = TextEditingController();
  TextEditingController addDate = TextEditingController();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void writeToDatabase(String userId) {
    _database.reference().child('data').child(userId).set({
      'moneyUser': addMoney.text,
      'dateAdd': addDate.text
    });
    addMoney.clear();
    addDate.clear();
  }



}