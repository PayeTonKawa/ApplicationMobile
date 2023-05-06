import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paye_ton_kawa/controllers/home_page.dart';
import 'package:paye_ton_kawa/styles/custom_colors.dart';
import 'package:paye_ton_kawa/styles/custom_theme.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: CustomColors.lightBrown,
      statusBarColor: CustomColors.brown,
    ));
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PayeTonKawa',
      theme: CustomTheme.lightTheme,
      home: const HomePage(),
    );
  }
}