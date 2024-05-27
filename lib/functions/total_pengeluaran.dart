 import 'package:cloud_firestore/cloud_firestore.dart';

Future<int> totalPengeluaran() async {
    CollectionReference pengeluaran = await FirebaseFirestore.instance.collection('pengeluaran');
    return pengeluaran
    .get()
    .then((QuerySnapshot snapshot) {
      double total_pengeluaran = 0;
      snapshot.docs.forEach((doc) {
        total_pengeluaran += doc["total"];
      });
      return total_pengeluaran.toInt();
    });
  }