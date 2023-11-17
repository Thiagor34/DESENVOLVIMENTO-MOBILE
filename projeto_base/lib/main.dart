import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ssclassificados/pages/Categorias.dart';
import 'package:ssclassificados/pages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseFirestore db = FirebaseFirestore.instance;
  db.collection("usuarios").add({'nome' : 'teste'});

  runApp(
    MaterialApp(
      home: Categorias_lista(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
    ),
  );
}
