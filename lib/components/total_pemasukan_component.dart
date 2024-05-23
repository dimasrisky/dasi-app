// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class TotalPemasukanComponent extends StatefulWidget {
  const TotalPemasukanComponent({super.key});

  @override
  State<TotalPemasukanComponent> createState() => _TotalPemasukanComponentState();
}

class _TotalPemasukanComponentState extends State<TotalPemasukanComponent> {

  Future<void> ambilSemuaDokumenPemasukan() async {
    CollectionReference pengeluaran = FirebaseFirestore.instance.collection('pemasukan');
    return pengeluaran
      .get()
      .then((QuerySnapshot snapshot) {
        double total_pemasukan = 0;
        snapshot.docs.forEach((doc) {
          total_pemasukan += doc["nominal"];
        });
        return total_pemasukan;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xff011E6C), Color(0xff033BD2)]),
            borderRadius: BorderRadius.all(Radius.circular(15))
          ),
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Pendapatan',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  FutureBuilder(
                    future: ambilSemuaDokumenPemasukan(), 
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        double total = snapshot.data as double;
                        return Text(
                          "Rp  ${total.toString()}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                          ),
                        );
                      }
                      if(snapshot.hasError){
                        return Text(
                          'Error : ${snapshot.error}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        );
                      }
                      return CircularProgressIndicator(color: Colors.white);
                    },
                  )
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(50))
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/form_pemasukan');
                    },
                    icon: Icon(
                      Icons.add,
                      size: 30,
                      color: Color(0xff1CB711),
                    )
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
