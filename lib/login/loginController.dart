import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wallfram/routes/pages.dart';
import 'package:wallfram/utils/storage.dart';

class LoginController extends GetxController {
  final Storage storage = Storage();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  var user = Rx<User?>(null);

  @override
  void onInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    super.onInit();
    storage.getName();
    _auth.authStateChanges().listen((User? firebaseUser) {
      user.value = firebaseUser;
    });
    user.bindStream(_auth.authStateChanges());
  }

  String? username = 'user';
  String pass = 'password';

  Future<void> loginSistem() async {
    if (username == 'user' && pass == 'password') Get.toNamed(Routes.HOME);
  }

  Future<void> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user.value = userCredential.user;
      if (user.value != null) {
        print('Signed in as ${user.value!.email}');
        storage.saveName(user.value!.email!);
        storage.login();
        Get.snackbar(
          'Success',
          'Selamat Datang, ${user.value!.email!}',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 2), // Durasi popup
          animationDuration: Duration(milliseconds: 800), // Durasi animasi
        );
        Get.offAllNamed(Routes.HOME);
      }
    } catch (e, stackTrace) {
      print('Error: $e');
      print('stackTrace: $stackTrace');
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.TOP);
    }
  }

  Future<void> signOut(String email, String password) async {
    try {
      await _auth.signOut();
      Get.snackbar(
        'Success',
        'Sampai jumpa kembali, ${user.value!.email!}',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 2), // Durasi popup
        animationDuration: Duration(milliseconds: 800), // Durasi animasi
      );
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  void validate() async {
    if (email.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'email harus diisi!',
        toastLength: Toast.LENGTH_SHORT, // Durasi toast
        gravity: ToastGravity.BOTTOM, // Letak toast (TOP, BOTTOM, CENTER)
        backgroundColor: Colors.red[800], // Warna background toast
        textColor: Colors.white, // Warna teks toast
        fontSize: 16.0,);
    } else if (password.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'password harus diisi!',
        toastLength: Toast.LENGTH_SHORT, // Durasi toast
        gravity: ToastGravity.BOTTOM, // Letak toast (TOP, BOTTOM, CENTER)
        backgroundColor: Colors.red[800], // Warna background toast
        textColor: Colors.white, // Warna teks toast
        fontSize: 16.0,);
    }
     else {
      signIn(email.text, password.text);
    }
  }

}