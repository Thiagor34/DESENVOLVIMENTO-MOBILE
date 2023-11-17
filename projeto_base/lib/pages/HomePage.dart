import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ssclassificados/pages/LoginPage.dart';

import '../components/ListItens.dart';
import '../components/TabsFilter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

bool isLoggeed = true;

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero, () {
      if (isLoggeed == false) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      }
    });
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
            accountName: Text('wwwwwwwwwww'),
            accountEmail: Text('www'),
            currentAccountPicture: CircleAvatar(
              child: Text('W'),
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
