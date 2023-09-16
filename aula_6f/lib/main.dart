import 'package:aula_6f/components/getapi.dart';
import 'package:aula_6f/pages/SecondPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    getApi();
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: getApi(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            Center(child: Text('Tente novamente mais tarde'));
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return Hero(
                tag: snapshot.data[index]['name'],
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecondPage(
                          request: snapshot.data[index],
                        ),
                      ),
                    );
                  },
                  title: Text(snapshot.data[index]['name']),
                  subtitle: Text(snapshot.data[index]['company']),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(snapshot.data[index]['photo']),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
