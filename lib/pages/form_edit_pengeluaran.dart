import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String? title, hintText;
  final Function whenSave;
  final initialValue;
  const CustomFormField(
      {super.key,
      required this.title,
      required this.hintText,
      required this.whenSave,
      required this.initialValue
    });

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
              initialValue: initialValue.toString(),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Color(0xff1f1f1f))),
                  hintText: "$hintText"),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Kebutuhan Wajib Diisi";
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

class FormEditPengeluaran extends StatefulWidget {
  final String? id;
  const FormEditPengeluaran({super.key, this.id});

  @override
  State<FormEditPengeluaran> createState() => _FormEditPengeluaranState();
}

class _FormEditPengeluaranState extends State<FormEditPengeluaran> {
  final _formKey = GlobalKey<FormState>();

  String? kebutuhan;
  int jumlah = 0;
  double harga_satuan = 0;

  Future<DocumentSnapshot> ambilDocumentPengeluaran() async {
    CollectionReference pengeluaran =
        await FirebaseFirestore.instance.collection('pengeluaran');
    return pengeluaran.doc(widget.id).get();
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
                margin: EdgeInsets.symmetric(vertical: 30),
                width: 400,
                padding: EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xff011E6C), Color(0xff033BD2)]),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Center(
                  child: Text(
                    "Edit Pengeluaran",
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
              FutureBuilder(
                  future: ambilDocumentPengeluaran(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var dataPengeluaran = snapshot.data!.data() as Map;
                      return Form(
                        key: _formKey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              CustomFormField(
                                initialValue: dataPengeluaran["kebutuhan"],
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
                                initialValue: dataPengeluaran["harga_satuan"],
                                title: "Harga Satuan",
                                hintText: "Masukkan harga...",
                                whenSave: (newValue) {
                                  setState(() {
                                    harga_satuan = double.parse(newValue);
                                  });
                                },
                              ),
                              SizedBox(height: 15),
                              CustomFormField(
                                initialValue: dataPengeluaran["jumlah"],
                                title: "Jumlah",
                                hintText: "Masukkan Jumlah...",
                                whenSave: (newValue) {
                                  setState(() {
                                    jumlah = int.parse(newValue);
                                  });
                                },
                              ),
                              SizedBox(height: 65),
                              GestureDetector(
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      FirebaseFirestore.instance
                                          .collection("pengeluaran")
                                          .doc(widget.id)
                                          .update({
                                            "harga_satuan": harga_satuan,
                                            "jumlah": jumlah,
                                            "kebutuhan": kebutuhan,
                                            "tanggal": DateTime.now(),
                                            "total": harga_satuan * jumlah
                                          })
                                          .then((value) => Navigator.pushNamed(context, '/pengeluaran'));
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 10, 103, 180),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: Center(
                                      child: Text(
                                        "Update Pengeluaran",
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
                      );
                    }

                    return Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text('Loading Form...')
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
