// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/home_page.dart';
import 'pages/pengeluaran_page.dart';
import 'pages/manajemen_siswa_page.dart';
import 'pages/form_pengeluaran.dart';
import 'pages/form_pemasukan.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        '/home': (context) => HomePage(),
        '/pengeluaran': (context) => PengeluaranPage(),
        '/form_pengeluaran': (context) => FormPengeluaran(),
        '/form_pemasukan': (context) => FormPemasukan(),
        '/manajemen_siswa': (context) => ManajemenSiswaPage()
      }
    );
  }
}