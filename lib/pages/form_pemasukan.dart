import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String? title, hintText;
  final Function whenSave;
  const CustomFormField(
    {super.key,
    required this.title,
    required this.hintText,
    required this.whenSave
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
              style: TextStyle(
                fontSize: 15, 
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Color(0xff1f1f1f))
                  ),
                  hintText: "$hintText"
                ),
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

class FormPemasukan extends StatefulWidget {
  const FormPemasukan({super.key});

  @override
  State<FormPemasukan> createState() => _FormPemasukanState();
}

class _FormPemasukanState extends State<FormPemasukan> {
  final _formKey = GlobalKey<FormState>();

  String? nama, no_absen;
  var nominal;

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
            "Form Pembayaran",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ),
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
                    colors: [Color(0xff011E6C), Color(0xff033BD2)]
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Center(
                  child: Text(
                    "Pembayaran Kas",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                      ),
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
                        title: "Nama",
                        hintText: "Masukkan Nama...",
                        whenSave: (newValue) {
                          setState(() {
                            nama = newValue;
                          });
                        },
                      ),
                      SizedBox(height: 15),
                      CustomFormField(
                        title: "No Absen",
                        hintText: "Masukkan No Absen...",
                        whenSave: (newValue) {
                          setState(() {
                            no_absen = newValue;
                          });
                        },
                      ),
                      SizedBox(height: 15),
                      CustomFormField(
                        title: "Nominal",
                        hintText: "Masukkan Nominal...",
                        whenSave: (newValue) {
                          nominal = double.parse(newValue);
                        },
                      ),
                      SizedBox(height: 30),
                      GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              FirebaseFirestore.instance
                                  .collection('pemasukan')
                                  .add({
                                "nama": nama,
                                "no_absen": no_absen,
                                "nominal": nominal,
                                "tanggal_bayar": DateTime.now()
                              }).then((value) => {Navigator.pushNamed(context, '/home')});
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 10, 103, 180),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8)
                              )
                            ),
                            child: Center(
                              child: Text(
                                "Bayar Kas",
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
