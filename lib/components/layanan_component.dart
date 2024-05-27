// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ServiceComponent extends StatelessWidget {
  final String title;
  final Function whenTap;
  final img_path;
  const ServiceComponent({super.key, required this.title, required this.whenTap, this.img_path});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => whenTap(),
        child: Container(
          height: 129,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color(0xff615EC7)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Color(0x17FFFFFF),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                  ),
                  Image.asset(
                    img_path,
                    width: 40,
                    height: 40,
                  )
                ],
              ),
              SizedBox(height: 9),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}

class LayananComponent extends StatelessWidget {
  const LayananComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Layanan',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Row(children: [
            ServiceComponent(title: "Bayar Kas", whenTap: () => Navigator.pushNamed(context, '/form_pemasukan'), img_path: 'assets/icons/bayar_kas.png'),
            SizedBox(width: 8),
            ServiceComponent(title: "Buat Pengeluaran", whenTap: () => Navigator.pushNamed(context, '/form_pengeluaran'), img_path: 'assets/icons/pengeluaran.png'),
          ])
        ],
      ),
    );
  }
}
