import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Categorias_lista extends StatefulWidget {
  const Categorias_lista({super.key});

  @override
  State<Categorias_lista> createState() => _Categorias_listaState();
}

class _Categorias_listaState extends State<Categorias_lista> {
  @override
  Widget build(BuildContext context) {
    getAd();
    return Scaffold(
      appBar: AppBar(
        title: Text("Categorias"),
      ),
      body: FutureBuilder(future: getAd(), builder: (context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(snapshot.data[index]['name']),
                );
              },
            );
          },)
    );
  }
}

Future getAd() async {
  await Firebase.initializeApp();
  FirebaseFirestore db = FirebaseFirestore.instance;
  var categorias = await db.collection('Categorias').get();

  return categorias.docs;
}
