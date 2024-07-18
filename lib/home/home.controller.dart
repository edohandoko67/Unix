import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallfram/utils/storage.dart';
import 'package:get/state_manager.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}

class HomeController extends GetxController {
  final Storage _storage = Storage();
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

// void addTransactionToFirebase() async {
//   String name = addUser.text.trim();
//   int uang = int.tryParse(addMoney.text.trim()) ?? 0;
//   String tanggal = addDate.text.trim();
//   if (name.isNotEmpty && uang != 0 && tanggal.isNotEmpty) {
//     //create a Transaction object
//     DataUser transaction = DataUser(name: name, money: uang, date: tanggal);
//
//     database.push().set(transaction.toMap()).then((value) {
//       addUser.clear();
//       addMoney.clear();
//       addDate.clear();
//       Get.snackbar(
//           'Berhasil Menambahkan data',
//           '${_storage.getName()}',
//           backgroundColor: Colors.green,
//           colorText: Colors.white,
//           duration: Duration(seconds: 2), // Durasi popup
//           animationDuration: Duration(milliseconds: 800));
//     }).catchError((error) {
//       // Handle error if data addition fails
//       Get.snackbar('Error', 'Failed to add data: $error');
//     });
//   } else {
//     // Show snackbar if any input fields are empty
//     Get.snackbar('Error', 'Please fill in all fields');
//   }
// }


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