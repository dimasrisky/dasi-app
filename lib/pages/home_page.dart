// ignore_for_file: prefer_const_constructors, use_full_hex_values_for_flutter_colors, prefer_const_literals_to_create_immutables
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/profile_kelas_component.dart';
import '../components/total_pemasukan_component.dart';
import '../components/layanan_component.dart';
import '../components/pembayaran_terkini_component.dart';

class HomePage extends StatelessWidget{
  HomePage({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
        ),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            size: 30,
            color: Colors.white,
          ),
          onPressed: () => scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      body: ListView(
        children: [
         ProfileKelasComponent(),
         TotalPemasukanComponent(),
         LayananComponent(),
         PembayaranTerkiniComponent()
        ],
      ),
      // Drawer
      drawer: Drawer (
        backgroundColor: Color(0xff070560),
        child: Column(
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Menu',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontFamily: 'Inter'
                    ),
                  ),
                ]
              )
            ),
            // Tile Home
            ListTile(
              leading: Icon(
                Icons.home_filled,
                size: 25,
                color: Colors.white,
              ),
              title: Text(
                'H O M E',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/home');
              }
            ),

            ListTile(
              leading: Icon(
                Icons.payment,
                size: 25,
                color: Colors.white,
              ),
              title: Text(
                'B A Y A R  K A S',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/form_pemasukan');
              }
            ),

            // Tile Pengeluaran
            ListTile(
              leading: Icon(
                Icons.attach_money_rounded,
                size: 25,
                color: Colors.white,
              ),
              title: Text(
                'P E N G E L U A R A N',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/pengeluaran');
              }
            ),

            ListTile(
              leading: Icon(
                Icons.money,
                size: 25,
                color: Colors.white,
              ),
              title: Text(
                'B U A T  P E N G E L U A R A N',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/form_pengeluaran');
              }
            ),

            // Tile Manajemen Siswa
            ListTile(
              leading: Icon(
                Icons.person,
                size: 25,
                color: Colors.white,
              ),
              title: Text(
                'S I S W A',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/manajemen_siswa');
              }
            ),
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.white
                  ),
                  width: double.maxFinite,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.logout,
                          color: Color(0xff070560),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'K E L U A R',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xff070560),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600
                          ),
                        )
                      ],
                    )
                  )
                ),
                onTap: () async { 
                  try{
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushNamed(context, '/login');
                  }catch(e){
                    print(e);
                  }
                },
              )
            ),
          ]
        ),
      ),
    );
  }
}   