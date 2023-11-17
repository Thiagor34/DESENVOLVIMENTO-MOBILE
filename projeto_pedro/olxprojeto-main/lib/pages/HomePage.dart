import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:olxprojeto/pages/AnuncioPage.dart';
import 'package:olxprojeto/pages/LoginPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> productList = [
    {
      'name': 'Produto 1',
      'price': 'R\$100.00',
      'image': 'assets/product1.jpg',
    },
    {
      'name': 'Produto 2',
      'price': 'R\$50.00',
      'image': 'assets/product2.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OLX"),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Nome do Cliente"),
              accountEmail: Text("cliente@email.com"),
              currentAccountPicture: CircleAvatar(),
            ),
            ListTile(
              title: Text("Meus Dados"),
              onTap: () {},
            ),
            ListTile(
              title: Text("Meus Anúncios"),
              onTap: () {},
            ),
            ListTile(
              title: Text("Sair do App"),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 50.0,
            // color: Colors.brown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  onTap: () {},
                  child: Text('DDD 48'),
                ),
                VerticalDivider(),
                InkWell(
                  onTap: () {},
                  child: Text('Categorias'),
                ),
                VerticalDivider(),
                InkWell(
                  onTap: () {},
                  child: Text('Filtros'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Card(
                    child: ListTile(
                      leading: Image.asset(productList[index]['image']),
                      title: Text(productList[index]['name']),
                      subtitle: Text(productList[index]['price']),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnuncioPage(),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
