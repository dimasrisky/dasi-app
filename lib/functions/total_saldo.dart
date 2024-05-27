import 'package:cloud_firestore/cloud_firestore.dart';

Future<int> totalSaldo() async {
  try{
    double total_pemasukan = 0;
    double total_pengeluaran = 0;

    await FirebaseFirestore.instance.collection('pemasukan')
      .get()
      .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((doc) {
          total_pemasukan += doc["nominal"];
        });
      });
    await FirebaseFirestore.instance.collection('pengeluaran')
      .get()
      .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((doc) {
          total_pengeluaran += doc["total"];
        });
      });
    double saldoSekarang = total_pemasukan - total_pengeluaran;
    return saldoSekarang.toInt();
  }catch(error){
    throw error;
  }

}