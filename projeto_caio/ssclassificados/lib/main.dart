import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ssclassificados/views/HomePage.dart';
import 'package:ssclassificados/views/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  runApp(
    MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
    ),
  );
}
