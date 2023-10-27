import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 3),
                    height: 200,
                    width: 200,
                    color: Colors.grey,
                    child: Stack(
                      children: [
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Text('OISAUBDIAS'),
                        ),
                        Text('Teste'),
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: 10,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, 
                    crossAxisSpacing: 5, 
                    mainAxisSpacing: 5,
                    childAspectRatio: 0.75),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    color: Colors.lightBlueAccent,
                  );
                },
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
