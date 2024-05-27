import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:refresh_materi/functions/total_saldo.dart';

class CustomFormField extends StatelessWidget {
  final String title, hintText, uid;
  final Function whenSave;
  const CustomFormField(
    {super.key,
    required this.uid,
    required this.title,
    required this.hintText,
    required this.whenSave}
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$title",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextFormField(
              keyboardType: uid == 'hrgst' || uid == 'jmlh' ? TextInputType.number : TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    width: 2, 
                    color: Color(0xff1f1f1f)
                  )
                ),
                hintText: "$hintText"
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "$title Wajib Diisi";
                }
                return null;
              },
              onSaved: (newValue) {
                whenSave(newValue);
              },
            )
          ],
        ));
  }
}

class FormPengeluaran extends StatefulWidget {
  const FormPengeluaran({super.key});

  @override
  State<FormPengeluaran> createState() => _FormPengeluaranState();
}

class _FormPengeluaranState extends State<FormPengeluaran> {
  final _formKey = GlobalKey<FormState>();

  late String kebutuhan;
  late int jumlah, harga_satuan = 0;

  Future<void> submitPengeluaran(String kebutuhan, int harga_satuan, int jumlah) async {
    try{
      int total = harga_satuan * jumlah;
      var total_saldo = await totalSaldo();
      if(total_saldo - total <= 0){
        final snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Text('Saldo tidak cukup'),
          action: SnackBarAction(
            label: 'Close', 
            onPressed: (){
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            }
          )
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }else{
        await FirebaseFirestore.instance
          .collection("pengeluaran")
          .add({
            "harga_satuan": harga_satuan,
            "jumlah": jumlah,
            "kebutuhan": kebutuhan,
            "tanggal": DateTime.now(),
            "total": harga_satuan * jumlah
          })
        .then((value) => Navigator.pushReplacementNamed(context, '/pengeluaran'));
      }
    }catch(error){
      final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('Data gagal dimasukkan'),
        action: SnackBarAction(
          label: 'Close', 
          onPressed: (){
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          }),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
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
            )
          ),
          backgroundColor: Color(0xff070560),
          title: Text(
            "Form Pengeluaran",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 30),
                width: 400,
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xff011E6C), Color(0xff033BD2)]),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Center(
                  child: Text(
                    "Pengeluaran",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: Column(
                    children: [
                      CustomFormField(
                        uid: 'kbthn',
                        title: "Kebutuhan",
                        hintText: "Masukkan Input Kebutuhan...",
                        whenSave: (newValue) {
                          setState(() {
                            kebutuhan = newValue;
                          });
                        },
                      ),
                      SizedBox(height: 15),
                      CustomFormField(
                        uid: 'hrgst',
                        title: "Harga Satuan",
                        hintText: "Masukkan harga...",
                        whenSave: (newValue) {
                          setState(() {
                            harga_satuan = int.tryParse(newValue) ?? 0;
                          });
                        },
                      ),
                      SizedBox(height: 15),
                      CustomFormField(
                        uid: 'jmlh',
                        title: "Jumlah",
                        hintText: "Masukkan Jumlah...",
                        whenSave: (newValue) {
                          setState(() {
                            jumlah = int.tryParse(newValue) ?? 0;
                          });
                        },
                      ),
                      SizedBox(height: 30),
                      GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              submitPengeluaran(kebutuhan, harga_satuan, jumlah);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 10, 103, 180),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Center(
                              child: Text(
                                "Buat Pengeluaran",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
