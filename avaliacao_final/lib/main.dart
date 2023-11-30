import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:olxprojeto/pages/Categorias.dart';
import 'package:olxprojeto/pages/Create.dart';
import 'package:olxprojeto/pages/HomePage.dart';
import 'package:olxprojeto/pages/LoginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseFirestore db = FirebaseFirestore.instance;

  runApp(
    MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.lightBlue,
        ).copyWith(
          secondary: Colors.blueAccent[700],
        ),
      ),
      debugShowCheckedModeBanner: true,
      home: LoginPage(),
    ),
  );
}
