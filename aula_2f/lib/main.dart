import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    theme: ThemeData(primarySwatch: Colors.purple),
    debugShowCheckedModeBanner: false,
  ));
}

PageController pageController = PageController();
int pageNow = 0;
int contador = 0;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Nubank'),
          backgroundColor: Colors.purple[500],
          titleTextStyle: TextStyle(
              fontSize: 42, color: Colors.white, fontWeight: FontWeight.bold),
          centerTitle: true,
          elevation: 10,
          actions: [
            Icon(Icons.person),
            SizedBox(width: 20),
            Icon(Icons.settings)
          ],
        ),
        // body: Column(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     Container(
        //       // margin: EdgeInsets.only(top:30, left: 10),
        //       // padding: EdgeInsets.all(20),
        //       width: double.infinity,
        //       height: 200,
        //       decoration: BoxDecoration(
        //           color: Colors.red,
        //           borderRadius: BorderRadius.circular(20),
        //           gradient: LinearGradient(
        //               colors: [Colors.red, Colors.blue],
        //               begin: Alignment.topLeft,
        //               end: Alignment.bottomRight),
        //           boxShadow: [
        //             BoxShadow(
        //                 color: Colors.black,
        //                 blurRadius: 10,
        //                 offset: Offset(5, 5))
        //           ]),
        //       child: Text('Container 1'),
        //     ),
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Container(
        //           width: 100,
        //           height: 100,
        //           color: Colors.red,
        //         ),
        //         Container(
        //           width: 100,
        //           height: 100,
        //           color: Colors.blue,
        //         ),
        //         Container(
        //           width: 100,
        //           height: 100,
        //           color: Colors.green,
        //         ),
        //       ],
        //     )
        //   ],
        // ),
        drawer: Drawer(
            child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Thiago Costa'),
              accountEmail: Text('thiagorcosta.26@gmail.com'),
              currentAccountPicture: CircleAvatar(
                child: Text('TC'),
              ),
            ),
            ListTile(
              title: Text('Minha Conta'),
              subtitle: Text('Informações da conta'),
              trailing: Icon(Icons.money),
              leading: Icon(Icons.money_off),
              onLongPress: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 3'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        )),
        body: PageView(
          controller: pageController,
          children: [
            Center(
              child: Container(
                child: Text(
                  contador.toString(),
                  style: TextStyle(fontSize: 82),
                ),
              ),
            ),
            Container(
              color: Colors.blue,
            ),
            Container(
              color: Colors.red,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: pageNow,
            onTap: (page) {
              pageController.animateToPage(page,
                  duration: Duration(milliseconds: 200), curve: Curves.linear);
              setState(() {
                pageNow =
                    page; //altera para verificar qual a página atual nos icones
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Início',
                  backgroundColor: Colors.red),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favoritos',
                  backgroundColor: Colors.blue),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Pesquisar',
                  backgroundColor: Colors.green),
            ]),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
                onPressed: () {
                  if (contador > 0)
                    setState(() {
                      contador--;
                    });
                },
                child: Icon(Icons.remove)),
            SizedBox(width: 14),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  contador++;
                });
              },
              child: Icon(Icons.add),
            )
          ],
        ));
  }
}
