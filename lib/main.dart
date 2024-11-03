import 'package:flutter/material.dart';
import 'package:myforumapp/view/homePage.dart';
import 'package:myforumapp/view/loginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyForum App',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

