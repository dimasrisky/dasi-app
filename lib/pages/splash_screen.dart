import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset('assets/img/splash_image.png'),
                Text(
                  'Kelola Kas dengan Mudah, Aman & Terpercaya',
                  style: TextStyle(
                    color: Color(0xff315EFF),
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15),
                Text(
                  'Kelola kas kelas Anda dengan mudah dan transparan. Catat setiap transaksi, akses laporan keuangan, dan pastikan semua anggota kelas mengetahui kondisi keuangan dengan DASI.',
                  style: TextStyle(
                    color: Color(0xff9A9A9A),
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/login'),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Color(0xff064AB7),
                          borderRadius: BorderRadius.circular(3)
                        ),
                        child: Text(
                          'Masuk Kelas',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12
                          ),
                          textAlign: TextAlign.center
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/register'),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3)
                        ),
                        child: Text(
                          'Daftar Kelas',
                          style: TextStyle(
                            color: Color(0xff064AB7),
                            fontWeight: FontWeight.w600,
                            fontSize: 12
                          ),
                          textAlign: TextAlign.center
                        ),
                      ),
                    ),
                    SizedBox(height: 10)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}