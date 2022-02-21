import 'package:certinomial/interfces/biometriclogin.dart';
import 'package:certinomial/interfces/home.dart';
import 'package:certinomial/interfces/loginpage.dart';
import 'package:certinomial/interfces/pdfCoverter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/Login',
      routes: {
        '/': (context) => home(),
        '/Login': (context) => LoginPage(),
        '/Bio': (context) => FirstPage(),
        '/pdf': (context) => pdfConverter()
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
