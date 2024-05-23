// ignore_for_file: prefer_const_constructors, use_full_hex_values_for_flutter_colors, prefer_const_literals_to_create_immutables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'form_edit_pengeluaran.dart';

class CardTotalPengeluaran extends StatefulWidget {
  const CardTotalPengeluaran({super.key});

  @override
  State<CardTotalPengeluaran> createState() => _CardTotalPengeluaranState();
}

class _CardTotalPengeluaranState extends State<CardTotalPengeluaran> {

  Future<void> ambilSemuaDocumentPengeluaran() async {
    CollectionReference pengeluaran = await FirebaseFirestore.instance.collection('pengeluaran');
    return pengeluaran
      .get()
      .then((QuerySnapshot snapshot) {
        double total_pengeluaran = 0;
        snapshot.docs.forEach((doc) {
          total_pengeluaran += doc["total"];
        });
        return total_pengeluaran;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 30),
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 45),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xff011E6C), Color(0xff033BD2)]),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total Pengeluaran',
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 7),
            FutureBuilder(
              future: ambilSemuaDocumentPengeluaran(), 
              builder: (context, snapshot) {
                if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
                  double total = snapshot.data as double;
                  return Text(
                    'Rp ${total.toString()}',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 33,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  );
                }
                if(snapshot.hasError){
                  return Text(
                    'Rp ${snapshot.error}',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 33,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  );
                }

                return CircularProgressIndicator();
              },
            ),
            
          ],
        ),
      ),
    );
  }
}

class CardRincianPengeluaran extends StatelessWidget {
  final docID;
  final int noUrut, jumlah;
  final double total, harga_satuan;
  final String kebutuhan;
  final Timestamp tanggal;

  const CardRincianPengeluaran({
    super.key,
    this.docID,
    required this.noUrut,
    required this.kebutuhan,
    required this.harga_satuan,
    required this.jumlah,
    required this.total,
    required this.tanggal,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          margin: EdgeInsets.only(bottom: 25),
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    blurRadius: 10, spreadRadius: 1, color: Color(0x25000000))
              ]),
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color(0xff4B6EEC),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                    Text(
                      noUrut.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 21),
                    )
                  ],
                ),
                SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tanggal.toDate().toString().split(' ')[0],
                      style: TextStyle(
                          color: Color.fromARGB(255, 91, 124, 243),
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "$kebutuhan",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 13),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "$jumlah Pcs",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          "/Pcs: Rp $harga_satuan",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                            fontWeight: FontWeight.w600
                          ),
                        )
                      ]
                    )
                  ],
                ),
              ]),
              Row(children: [
                Text(
                  "Rp $total",
                  style: TextStyle(
                      color: Color(0xff23FD00),
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
                SizedBox(width: 20),
                Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          FirebaseFirestore.instance.collection('pengeluaran')
                                .doc(docID)
                                .delete().then((value) => print("berhasil dihapus"));
                          Navigator.pushNamed(context, '/pengeluaran');
                        },
                        icon: Icon(
                          Icons.delete,
                          size: 25,
                          color: Color(0xff1F1F1F),
                        )),
                    IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FormEditPengeluaran(id: docID)));
                        },
                        icon: Icon(
                          Icons.edit,
                          size: 25,
                          color: Color(0xff1F1F1F),
                        )),
                  ],
                )
              ])
            ],
          ),
        ));
  }
}

class PengeluaranPage extends StatelessWidget {
  const PengeluaranPage({super.key});

  Future<void> rincianPengeluaran() async {
    CollectionReference pengeluaran =
        await FirebaseFirestore.instance.collection('pengeluaran');
    return pengeluaran.get().then((QuerySnapshot snapshot) => snapshot.docs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.arrow_back,
                  size: 20,
                  color: Colors.white,
                )),
            backgroundColor: Color(0xff070560),
            title: Text(
              "Pengeluaran",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardTotalPengeluaran(),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  margin: EdgeInsets.only(top: 30, bottom: 10),
                  child: Text("Rincian Pengeluaran",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                )),
            Expanded(
              child: FutureBuilder(
                future: rincianPengeluaran(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var listDocs = snapshot.data as List<DocumentSnapshot>;
                    return ListView.builder(
                      itemCount: listDocs.length,
                      itemBuilder: (context, index) {
                        return CardRincianPengeluaran(
                            docID: listDocs[index].id,
                            noUrut: index + 1,
                            kebutuhan: listDocs[index]["kebutuhan"],
                            harga_satuan: listDocs[index]["harga_satuan"],
                            jumlah: listDocs[index]["jumlah"],
                            total: listDocs[index]["total"],
                            tanggal: listDocs[index]["tanggal"]);
                      },
                    );
                  }
                  return Center(
                    child: Column(children: [
                      Text("Data Masih Loading"),
                      CircularProgressIndicator()
                    ]),
                  );
                },
              ),
            )
          ],
        ));
  }
}
