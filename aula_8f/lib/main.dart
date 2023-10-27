import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:aula_8f/services/api.dart';

void main() {
  runApp(
    MaterialApp(
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _nameController = TextEditingController();
  final List<NameModel> _names = [];

@override
void initState() {
  super.initState();
  loadNames().then((names) {
    setState(() {
      _names.clear();
      _names.addAll(names as Iterable<NameModel>);
    });
  });
}

  // Future<void> loadNames() async {
  //   var url = Uri.parse(
  //       'https://crud-ads-5a01e-default-rtdb.firebaseio.com/names.json');

  //   var response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> data = json.decode(response.body);
  //     final List<NameModel> names = [];
  //     data.forEach((key, value) {
  //       names.add(NameModel(key: key, name: value['name']));
  //     });

  //     setState(() {
  //       _names.clear();
  //       _names.addAll(names);
  //     });
  //   }
  // }

  // Future<void> addName(String name) async {
  //   var url = Uri.parse(
  //       'https://crud-ads-5a01e-default-rtdb.firebaseio.com/names.json');

  //   var data = {
  //     'name': name,
  //   };

  //   var response = await http.post(url, body: json.encode(data));

  //   if (response.statusCode == 200) {
  //     print('Nome salvo com sucesso no Firebase.');
  //     loadNames();
  //   } else {
  //     print('Erro ao salvar nome no Firebase.');
  //   }
  // }

  // Future<void> deleteName(String key) async {
  //   var url = Uri.parse(
  //       'https://crud-ads-5a01e-default-rtdb.firebaseio.com/names/$key.json');

  //   var response = await http.delete(url);

  //   if (response.statusCode == 200) {
  //     print('Nome excluído com sucesso no Firebase.');
  //     loadNames();
  //   } else {
  //     print('Erro ao excluir nome no Firebase.');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Nomes'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nome',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              addName(_nameController.text);
              _nameController.clear();
            },
            child: Text('Adicionar Nome'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _names.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_names[index].name),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deleteName(_names[index].key);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class NameModel {
  final String key;
  final String name;

  NameModel({required this.key, required this.name});
}

// getContact() async {
//   var url = Uri.parse('https://crud-ads-5a01e-default-rtdb.firebaseio.com/.json');
//   var response = await http.get(url);
//   print('Response status: ${response.statusCode}');
//   print('Response body: ${response.body}');
// }

// postContact() async {
//   var url = Uri.parse('https://crud-ads-5a01e-default-rtdb.firebaseio.com/product/.json');

//   var data = {
//     'name': 'Product 1',
//     'description': 'Product 1 description',
//     'price': '29.99',
//   };

//   var response = await http.post(url, body: json.encode(data));
//   print('Response status: ${response.statusCode}');
//   print('Response body: ${response.body}');
// }

// deleteContact() async {
//   var url = Uri.parse('https://crud-ads-5a01e-default-rtdb.firebaseio.com/product/-NhEGssFObKFBh0wlbFW/.json');

//   var data = {
//     'name': 'Product 1',
//     'description': 'Product 1 description',
//     'price': '29.99',
//   };

//   var response = await http.delete(url);
//   print('Response status: ${response.statusCode}');
//   print('Response body: ${response.body}');
// }

// updateContact() async {
//   var url = Uri.parse('https://crud-ads-5a01e-default-rtdb.firebaseio.com/product/-NhEJ3slQ_v8eCDZFWlx/.json');

//   var data = {
//     'name': 'Garrafa',
//   };

//   var response = await http.patch(url, body: json.encode(data));
//   print('Response status: ${response.statusCode}');
//   print('Response body: ${response.body}');
// }

