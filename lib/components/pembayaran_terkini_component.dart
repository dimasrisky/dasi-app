// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class CardPembayaran extends StatelessWidget {
  final String nama, noAbsen;
  final tanggalBayar;
  final nominal;

  const CardPembayaran({
    super.key,
    required this.nama,
    required this.noAbsen,
    required this.tanggalBayar,
    required this.nominal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 9),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
        boxShadow: [
          BoxShadow( blurRadius: 10, spreadRadius: 1, color: Color(0x25000000)
          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xff4B6EEC),
                      borderRadius: BorderRadius.all(Radius.circular(50))
                    ),
                  ),
                  Text(
                    "$noAbsen",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                    ),
                  )
                ],
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${tanggalBayar.toDate().toString().split(' ')[0]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff2499CB),
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  Text(
                    nama,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  )
                ],
              )
            ],
          ),
          Text(
            " Rp ${nominal.toString()}",
            style: TextStyle(
              color: Color(0xff34DD28),
              fontWeight: FontWeight.w500,
              fontSize: 15
            ),
          )
        ],
      )
    );
  }
}

class PembayaranTerkiniComponent extends StatelessWidget {
  const PembayaranTerkiniComponent({super.key});

  Future<void> semuaPembayaranTerkini() async {
    CollectionReference pemasukan = await FirebaseFirestore.instance.collection('/pemasukan');
    return pemasukan.limit(5).orderBy('tanggal_bayar', descending: true).get().then((QuerySnapshot snapshot) => snapshot.docs);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pembayaran Terkini",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          FutureBuilder(
            future: semuaPembayaranTerkini(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var listDocs = snapshot.data as List<DocumentSnapshot>;
                return Container(
                  height: 500,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: listDocs.length,
                    itemBuilder: (context, index) {
                      return CardPembayaran(
                        nama: listDocs[index]["nama"],
                        noAbsen: listDocs[index]["no_absen"],
                        nominal: listDocs[index]["nominal"],
                        tanggalBayar: listDocs[index]["tanggal_bayar"],
                      );
                    },
                  ),
                );
              }
              if (snapshot.hasError) {
                print(snapshot.error);
                return Center(child: Text('Data Error...'));
              }
              return Text("Data Loading...");
            },
          )
        ],
      ),
    );
  }
}
