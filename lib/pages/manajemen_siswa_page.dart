// ignore_for_file: prefer_const_constructors, use_full_hex_values_for_flutter_colors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class ManajemenSiswaPage extends StatelessWidget {
  const ManajemenSiswaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff070560),
        title: Text(
          "DASI APP",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        )
      ),
      body: Text('Halaman Manajemen Siswa'));
  }
}
