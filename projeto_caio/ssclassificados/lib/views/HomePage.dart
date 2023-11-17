import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ssclassificados/views/LoginPage.dart';

import '../components/ListItens.dart';
import '../components/TabsFilter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {

  var user;


  getUser() async {
    Firebase.initializeApp();
    FirebaseAuth auth = await FirebaseAuth.instance;
    setState(() {
      user = auth.currentUser!;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SS Classificados'),
        actions: [
          IconButton(
            onPressed: null,
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: null,
            icon: Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: null,
            icon: Icon(Icons.favorite),
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 231, 226, 226),
      drawer: Drawer(
          child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user!.email!),
            accountEmail: Text(user!.displayName!),
            currentAccountPicture: CircleAvatar(
              child: Text(user[0]),
            ),
          ),
        ],
      )),
      body: Column(
        children: [TabsFilter(), ListItens()],
      ),
    );
  }
}
