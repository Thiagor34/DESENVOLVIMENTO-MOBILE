import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<NameModel>> loadNames() async {
  var url = Uri.parse('https://crud-ads-5a01e-default-rtdb.firebaseio.com/names.json');
  var response = await http.get(url);
  List<NameModel> names = [];

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    data.forEach((key, value) {
      names.add(NameModel(key: key, name: value['name']));
    });
  }
  return names; // Certifique-se de que a função retorne a lista correta.
}

Future<void> addName(String name) async {
  var url = Uri.parse('https://crud-ads-5a01e-default-rtdb.firebaseio.com/names.json');

  var data = {
    'name': name,
  };

  var response = await http.post(url, body: json.encode(data));

  if (response.statusCode == 200) {
    print('Nome salvo com sucesso no Firebase.');
  } else {
    print('Erro ao salvar nome no Firebase.');
  }
}

Future<void> deleteName(String key) async {
  var url = Uri.parse('https://crud-ads-5a01e-default-rtdb.firebaseio.com/names/$key.json');

  var response = await http.delete(url);

  if (response.statusCode == 200) {
    print('Nome excluído com sucesso no Firebase.');
  } else {
    print('Erro ao excluir nome no Firebase.');
  }
}

class NameModel {
  final String key;
  final String name;

  NameModel({required this.key, required this.name});
}
