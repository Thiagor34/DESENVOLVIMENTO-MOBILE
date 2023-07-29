import 'dart:convert';

import 'package:http/http.dart' as http;

getUser() async {
  var url = Uri.parse('https://jsonplaceholder.typicode.com/users');
  var response = await http.get(url);
  var data = jsonDecode(response.body);

  //retorno do json
  var usuario = data.map((json) => modelUser.fromJson(json)).toList();

  for(var user in usuario) {
    print(user.nome);
  }
}

void main() {
  getUser();
}


//model
class modelUser{
  String nome;
  String email;
  String telefone;
  
//construtor
  modelUser({
    required this.nome, 
    required this.email, 
    required this.telefone, 
  });

//monta o json
  factory modelUser.fromJson(Map<String, dynamic>json){
    return modelUser(nome: json['name'], email: json['email'], telefone: json['phone']);
  }
}