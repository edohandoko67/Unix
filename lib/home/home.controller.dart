import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallfram/utils/services.dart';
import 'package:wallfram/utils/storage.dart';
import 'package:get/state_manager.dart';

import '../model/cars.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}

class HomeController extends GetxController {
  final Storage _storage = Storage();
  ApiService service = ApiService();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController addUser = TextEditingController();
  TextEditingController addMoney = TextEditingController();
  TextEditingController addDate = TextEditingController();

  var totalMoney = 0.0.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchMoney();
    listDataCars();
  }

  void addData(String name, String money, String date) async {
    CollectionReference savedMoney = firestore.collection('dataMoney');
    isLoading.value = true;
    try {
      await savedMoney.add({
        'name': name,
        'money': money,
        'createAt': Timestamp.now()
      });
      Get.snackbar(
          'Berhasil Menambahkan data',
          '${_storage.getName()}',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 2), // Durasi popup
          animationDuration: Duration(milliseconds: 800));
      addUser.clear();
      addMoney.clear();
      addDate.clear();
    } catch (e) {
      print(e);
      Get.snackbar(
          'Gagal Menambahkan data',
          '${_storage.getName()}',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 2), // Durasi popup
          animationDuration: Duration(milliseconds: 800));
    } finally {
      isLoading.value = false;
    }
  }

  Future<QuerySnapshot<Object?>> getData() async {
    isLoading.value = true;
    try {
      CollectionReference data = firestore.collection('dataMoney');

      return data.get();
    } finally {
      isLoading.value = false;
    }
  }

  Stream<QuerySnapshot<Object?>> streamData() {
    isLoading.value = true;
    try {
      CollectionReference stream = firestore.collection('dataMoney');
      return stream.snapshots();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchMoney() async {
    isLoading.value = true;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    //Onetime
    //final QuerySnapshot querySnapshot = await firestore.collection('dataMoney').get();

    //Realtime
    firestore.collection('dataMoney').snapshots().listen((querySnapshot) {
      double sum = 0.0;
      for (var doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final moneyString = data['money']?.toString() ?? '0.0';
        final money = double.tryParse(moneyString) ?? 0.0;
        sum += money;
      }
      totalMoney.value = sum;
    }).onError((error) {
      isLoading.value = false;
    });

    isLoading.value = false; // This line will execute before .listen() completes
  }

  var currentIndex = 0.obs;

  void updateIndex(int index) {
    currentIndex.value = index;
    simulateLoading();
  }

  void simulateLoading() {
    isLoading.value = false;
    Future.delayed(Duration(milliseconds: 2000), (){
      isLoading.value = false;
    });
  }

  //get data berdasarkan document id
  Future<DocumentSnapshot<Object?>> getEditData(String id) async {
    //ambil document berdasarkan id document
    DocumentReference docRef = firestore.collection('dataMoney').doc(id);
    return docRef.get();
  }

  void editDataUser(String name, String money, String date, String id) async {
    DocumentReference editDoc = firestore.collection('dataMoney').doc(id);
    isLoading.value = true;

    try {
      await editDoc.update({
        'name': addUser.text,
        'money': addMoney.text,
        'createAt': Timestamp.now()
      });
      Get.snackbar(
          'Berhasil merubah data',
          '${_storage.getName()}',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 2), // Durasi popup
          animationDuration: Duration(milliseconds: 800));
      addUser.clear();
      addMoney.clear();
      addDate.clear();
    } catch (e) {
      print(e);
      Get.snackbar(
          'Gagal menambahkan data',
          '${_storage.getName()}',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 2), // Durasi popup
          animationDuration: Duration(milliseconds: 800));
    } finally {
      isLoading.value = false;
    }
  }

  RxList<Cars> listCars = <Cars>[].obs;
  Future<void> listDataCars() async {
    try {
      isLoading.value = true;
      listCars.value = await service.fetchCars();
    } catch (e) {
      print('error : $e');
    } finally {
      isLoading.value = false;
    }
  }


}