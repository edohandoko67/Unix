import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallfram/home.dart';
import 'package:wallfram/login/loginController.dart';
import 'package:wallfram/responsive/dekstop_body.dart';
import 'package:wallfram/responsive/mobile_body.dart';
import 'package:wallfram/responsive/responsive_layout.dart';
import 'package:wallfram/theme.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  LoginController controller = Get.put(LoginController());
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
      Scaffold(
          body: MyMobileBody()
          // ResponsiveLayout(
          //   mobileBody: MyMobileBody(),
          //   dekstopBody: MyDesktopBody(),)
            // child: Container(
            //   width: 360,
            //   height: 800,
            //   margin: EdgeInsets.only(left: 30.0, right: 30.0),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.only(top: 51.0),
            //         child: Text('Selamat Datang', style: subTextStyle, ),
            //       ),
            //       Padding(padding: EdgeInsets.only(top: 37),
            //           child: Text('Silakan mengisi username dan password untuk dapat login', style: subMiniTextStyle,)
            //       ),
            //       Padding(padding: EdgeInsets.only(top: 37, left: 16),
            //           child: Text('Username', style: subMiniTextStyle,)
            //       ),
            //       TextField(
            //         decoration: InputDecoration(
            //           prefixIcon: Icon(Icons.person),
            //           //labelText: 'Username'
            //         ),
            //       ),
            //       Padding(padding: EdgeInsets.only(top: 37, left: 16),
            //           child: Text('Password', style: subMiniTextStyle,)
            //       ),
            //       TextField(
            //         obscureText: true,
            //         decoration: InputDecoration(
            //           prefixIcon: Icon(Icons.security),
            //         ),
            //       ),
            //       Padding(
            //         padding: EdgeInsets.only(top: 37),
            //         child: Center(child: Text('Lupa Password?', style: subMiniTextStyle)),
            //       ),
            //       Center(
            //         child: Padding(
            //           padding: const EdgeInsets.only(top: 30.0),
            //           child: ElevatedButton(onPressed: () {
            //             Navigator.push(context, MaterialPageRoute(
            //                 builder: (context) => HomePage()));
            //           },
            //               style: ButtonStyle(
            //                   backgroundColor: MaterialStateProperty.all(Color(0xFF9770FA)),
            //                 shape: MaterialStateProperty.all(
            //                   RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            //                 ),
            //                 minimumSize: MaterialStateProperty.all(Size(360, 51))
            //               ),
            //               child: Text('Login', style: subTextBtnStyle,)),
            //         ),
            //       ),
            //       Center(
            //         child: Padding(
            //           padding: const EdgeInsets.only(top: 30.0),
            //           child: Text('Dengan login, anda setuju dengan', style: subMiniTextStyle,),
            //         ),
            //       ),
            //       Center(
            //         child: TextButton(
            //           onPressed: () {
            //             showDialog(context: context, builder: (BuildContext context) {
            //               return AlertDialog(
            //                 title: Text('Terms & Condition'),
            //                 content: SingleChildScrollView(
            //                   child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt'),
            //                 ),
            //                 actions: [
            //                   TextButton(onPressed: () {
            //                     Navigator.of(context).pop();
            //                   }, child: Text('Tutup'))
            //                 ],
            //               );
            //             }
            //             );
            //           }, child: Text('Terms & Condition', style: subMiniTextPinkStyle),
            //         ),
            //       ),
            //       Center(
            //         child: Padding(
            //           padding: const EdgeInsets.only(top: 30.0),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             children: [
            //               Text('Belum punya akun ?', style: subMiniTextStyle,),
            //               Text(' Registrasi', style: subMiniTextPinkStyle,)
            //             ],
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ),
        );
  }
}
