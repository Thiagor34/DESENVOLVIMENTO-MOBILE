import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olxprojeto/pages/Create.dart';
import 'package:olxprojeto/pages/LoginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:olxprojeto/pages/Graficos.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu App Financeiro"),
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
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                  FirebaseAuth.instance.currentUser!.email?.split('@')[0] ??
                      "Nome do Cliente"),
              accountEmail: Text(FirebaseAuth.instance.currentUser!.email ??
                  "cliente@email.com"),
              currentAccountPicture: CircleAvatar(),
            ),
            ListTile(
              title: Text("Início"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            ListTile(
              title: Text("Lançamentos"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Create()),
                );
              },
            ),
            ListTile(
              title: Text("Gráficos"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Graficos()),
                );
              },
            ),
            ListTile(
              title: Text("Sair"),
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
            height: 150.0,
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 222, 221, 221),
              border: Border.all(
                color: const Color.fromARGB(255, 69, 69, 69),
                width: 2.0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            padding: EdgeInsets.all(16.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Lancamentos')
                  .where('UID',
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }

                var lancamentos = snapshot.data!.docs;

                double saldo = 0;

                lancamentos.forEach((lancamento) {
                  var dadosLancamento =
                      lancamento.data() as Map<String, dynamic>;

                  if (dadosLancamento['Tipo'] == 'Débito') {
                    saldo -= dadosLancamento['Valor'] ?? 0;
                  } else {
                    saldo += dadosLancamento['Valor'] ?? 0;
                  }
                });

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Saldo: ',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _formatCurrency(saldo),
                      style: TextStyle(
                        color: saldo < 0
                            ? Colors.red
                            : Color.fromARGB(255, 24, 173, 56),
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            color: Color.fromARGB(255, 61, 107, 140),
            height: 60.0,
            padding: EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Últimos Lançamentos',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                Icon(Icons.attach_money, color: Colors.white),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Lancamentos')
                  .where('UID',
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }

                var lancamentos = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: lancamentos.length,
                  itemBuilder: (context, index) {
                    if (lancamentos.isEmpty) {
                      return Center(
                        child: Text('Ainda não há informações.'),
                      );
                    }
                    var lancamento =
                        lancamentos[index].data() as Map<String, dynamic>;

                    return GestureDetector(
                      child: Card(
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(lancamento['Nome'] ?? ''),
                              Text(
                                '${_formatCurrency((lancamento['Valor'] ?? 0).toDouble())}',
                                style: TextStyle(
                                  color: lancamento['Tipo'] == 'Débito'
                                      ? Colors.red
                                      : Color.fromARGB(255, 24, 173, 56),
                                  fontWeight: lancamento['Tipo'] == 'Débito'
                                      ? FontWeight.bold
                                      : FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Categoria: ',
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: lancamento['Categoria'] ?? '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        color: Color.fromARGB(255, 61, 107, 140),
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              iconSize: 35,
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.add_circle),
              iconSize: 35,
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Create()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.insert_chart),
              iconSize: 35,
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Graficos()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _formatCurrency(double saldo) {
    final formatter = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return formatter.format(saldo);
  }
}
