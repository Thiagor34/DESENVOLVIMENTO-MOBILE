import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

PageController pageController = PageController();
int pageNow = 0;

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
        body: PageView(
          controller: pageController,
          children: [
            Container(
              color: Colors.green,
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
            pageNow = page; //altera para verificar qual a página atual nos icones              
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
          ],
        ));
  }
}
