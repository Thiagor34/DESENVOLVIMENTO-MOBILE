import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ssclassificados/views/HomePage.dart';

validateLogin(context, email, password) async {
  await Firebase.initializeApp();
  FirebaseAuth auth = FirebaseAuth.instance;
  auth.signInWithEmailAndPassword(email: email, password: password).then(
        (value){Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );}
      );
}
